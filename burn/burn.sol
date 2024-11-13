/**
 * @dev **********************
 * TECHNICAL SPECIFICATION & ARCHITECTURE
 * 
 * CORE MECHANISM:
 * Fixed burn quantum: 6M tokens (8 decimals)
 * Dual-auth burn execution: Owner + AutismLLM
 * Auto-tracked token deposits via ERC20 hooks
 * 
 * ACCESS CONTROL:
 * Burn(): Access matrix = {owner, AUTISM_LLM}
 * LP_Transfer(): Access matrix = {owner}
 * Deposits: Unrestricted public access
 * 
 * TRANSFER CONSTRAINTS:
 * Max throughput: 10% / 24h period
 * Target: Immutable LP staking endpoint
 * 
 * SECURITY PARAMETERS:
 * No extraction vectors
 * No upgrade patterns
 * Auto deposit detection
 * **********************
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenBurner is Ownable {
    using SafeERC20 for IERC20;

    IERC20 public immutable token;
    address public immutable LP_STAKING_CONTRACT;
    address public immutable AUTISM_LLM;
    uint256 public constant BURN_AMOUNT = 6_000_000 * 10**8;
    uint256 public constant MAX_DAILY_PERCENTAGE = 10;
    uint256 public lastTransferTime;
    address public constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    // Events
    event TokensReceived(address indexed from, uint256 amount);
    event BurnExecuted(address indexed executor, uint256 amount);
    event StakingTransfer(uint256 amount);

    constructor(
        address _token,
        address _lpStakingContract,
        address _autismLLM
    ) {
        require(_token != address(0) && _lpStakingContract != address(0) && _autismLLM != address(0), "Invalid address");
        token = IERC20(_token);
        LP_STAKING_CONTRACT = _lpStakingContract;
        AUTISM_LLM = _autismLLM;
        lastTransferTime = block.timestamp;
    }

    modifier canBurn() {
        require(msg.sender == owner() || msg.sender == AUTISM_LLM, "Only owner or AutismLLM");
        _;
    }

    // Automatic token deposit detection
    function onERC20Received(address from, uint256 amount) external returns (bytes4) {
        require(msg.sender == address(token), "Only specified token");
        emit TokensReceived(from, amount);
        return this.onERC20Received.selector;
    }

    function burn() external canBurn {
        require(token.balanceOf(address(this)) >= BURN_AMOUNT, "Insufficient balance");
        token.safeTransfer(BURN_ADDRESS, BURN_AMOUNT);
        emit BurnExecuted(msg.sender, BURN_AMOUNT);
    }

    function transferToStaking(uint256 amount) external onlyOwner {
        require(block.timestamp >= lastTransferTime + 1 days, "24h limit active");
        
        uint256 currentBalance = token.balanceOf(address(this));
        uint256 maxAmount = (currentBalance * MAX_DAILY_PERCENTAGE) / 100;
        require(amount <= maxAmount, "Exceeds daily limit");
        require(amount > 0, "Zero transfer");
        
        token.safeTransfer(LP_STAKING_CONTRACT, amount);
        lastTransferTime = block.timestamp;
        emit StakingTransfer(amount);
    }

    function getDailyLimit() external view returns (uint256) {
        return (token.balanceOf(address(this)) * MAX_DAILY_PERCENTAGE) / 100;
    }

    function canTransferAfter() external view returns (uint256) {
        return lastTransferTime + 1 days;
    }
}