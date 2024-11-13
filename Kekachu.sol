// SPDX-License-Identifier: SBF

/*** 
kekachu.com                    @@@                                        
linktr.ee/kekachu           @%@@@@                                        
                           %%@@@@@                                         
                         %@@@@@@@                                          
                       @@@@%#**#@                                          
                     %%%*******%                                           
                    %#********%                                            
                   %#********#%                                            
                  ##********#%                                             
                 %#*******##%                                              
                %##**********###%                 @@%%%%%%%%%@@            
               %#*****************#%     %%%#######*****@@@@@@@@           
             @%********************#%%%*#**************@@@@@@@   %%%%#*###%
            @%#**###*******###*######*****************%@@@@ %##******####%@
           @%%%###***#####****###*#*#***************#@@@%#************###% 
           @@%%=-+%%**##%%%*=----+%=+%*************%@%*****************##% 
          %#%*=----=*###==------=@@@%******####%%%*********************#%% 
         %#*****+===+***#*=----=*%#****##@      %*******ワンフォー*******#%@ 
         %#%%%##%%%#*******************##@      ***********************#%  
          %#%%%%%%%%%#%%%%#########****##@      **********************#%   
           %*********#%##%%%%%%%%%%**###%       ********************##%@   
            %*************************#%        #*****************###%%    
             @#***********************%         %************#######%%     
                %###*********#%%*#***#%         #*******#%%%%@@@@          
                %********########%%#%*#@        %#******#@                 
               @**********###*#*#*##%***%        *******%@                 
               %#***八八***##*#*#*#***#**#%@************#%                  
              %###*********#*##*#*###****%%@**********##@                  
             %%#************##*###*##%**%##%#*******#%%@                   
   %       %###****************#%%#****#%##*###*%%%@                       
 %%##%%   %#**#*********#*************%#*#*%*#%%###%                       
 %%##**#@%#**##*********#*************#****卐**%##%%%@                      
  @%#****##**##********##*************##**#%**#%@                          
    %#*****#**#********%*ワンフォー***###**#%***%                           
     %%*****###********%**************#####%*#*%                           
       %#*****%*******%#***************####***#                            
         %%%##%#*****#%######*********%####*##%                            
           @@@@%%%###%      @%%%#%#%##%%%%%%%                              
                  @ @                       

██╗  ██╗███████╗██╗  ██╗ █████╗  ██████╗██╗  ██╗██╗   ██╗
██║ ██╔╝██╔════╝██║ ██╔╝██╔══██╗██╔════╝██║  ██║██║   ██║
█████╔╝ █████╗  █████╔╝ ███████║██║     ███████║██║   ██║
██╔═██╗ ██╔══╝  ██╔═██╗ ██╔══██║██║     ██╔══██║██║   ██║
██║  ██╗███████╗██║  ██╗██║  ██║╚██████╗██║  ██║╚██████╔╝
╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ 
八 Mentally challenged genetic accident with Tourette 八                                                     
***/

pragma solidity 0.8.28;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IERC20Metadata is IERC20{
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
    }


contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router02 {
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
}

contract Kekachu is Context, ERC20, Ownable {

    mapping (address => bool) private _isExemptFromExitTax;

    address payable public _Stripclub;
   
    uint256 private _buyFee=0;
    uint256 private _sellFee=0;
    uint256 private _maxWallet; 

    uint256 public _taxSwapThreshold; 
    uint256 public _maxTaxSwap; 
    uint256 public tradingStartTime;
    address public uniswapV2Pair;
    uint256 public constant MAX_TAX_SWAP_THRESHOLD = 200; 
    uint256 public constant MAX_TAX_SWAP_LIMIT = 100;     

    IUniswapV2Router02 private immutable uniswapV2Router;

    bool private swapEnabled = true;
    bool private _limitRemoved = false;
    bool public maxWalletEnabled = true;
    bool private _startTradingExecuted;
    bool private _cooldownTaxExecuted;
    bool private _finalTaxExecuted;
    bool private _ultimateTaxExecuted;
    bool private _zeroTaxExecuted;


    constructor ()  ERC20(unicode"Kekachu", unicode"KEKU", 8) {
        require(0x7aFE1DB4AFF51B894350660fa9790079167654a0 != address(0), "Zero address not allowed retard");
        _Stripclub = payable(0x7aFE1DB4AFF51B894350660fa9790079167654a0);
        address _v2Router;
        if(block.chainid == 5){
            _v2Router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
        } else if(block.chainid == 8453){
            _v2Router = 0x4752ba5DBc23f44D87826276BF6Fd6b1C372aD24;
        } else {
            revert("Chain not configured faggot");
        }

        uniswapV2Router = IUniswapV2Router02(_v2Router);
        uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH());

        _mint(msg.sender, 69000000000 * 10**decimals());

        _isExemptFromExitTax[owner()] = true;
        _isExemptFromExitTax[address(this)] = true;
        _isExemptFromExitTax[_Stripclub] = true;
        _isExemptFromExitTax[_v2Router] = true;

        _taxSwapThreshold = totalSupply() * 30 / 10000;
        _maxTaxSwap = totalSupply() * 10 / 10000;
        _maxWallet = totalSupply() * 1 / 100;
    }

    // EVENTS
    event TaxesUpdated(uint256 buyFee, uint256 sellFee, string phase);
    event TokensBurned(uint256 amount, address initiator);
    event MaxWalletRemoved(uint256 timestamp);
    event TaxChangeQueued(string phase, uint256 executionTime);
    event StripclubAddressUpdated(address indexed newAddress);
    event TaxSwapSettingsUpdated(
    uint256 newThreshold,
    uint256 newMaxSwap,
    string reason
    );

    /*** @dev Tax Swap Control - Anti-Manipulation System
         Threshold (0.1-2%): When to swap tax tokens -> ETH
         MaxSwap (0.05-1%): Max size per swap

         Technical Benefits:
         1. Gas vs Price Impact Balance
            - Higher = fewer swaps, more gas efficient
            - Lower = smaller price impact per swap
        2. Anti-Manipulation
            - MaxSwap < Threshold prevents tax buildup
            - Capped at 2% max to prevent whale dumps
            - Events track all changes for transparency
        3. Liquidity Optimization
            - Adjustable based on pool depth
            - Prevents tax tokens from accumulating
    ***/
    
    function updateTaxSwapSettings(
        uint256 thresholdBips,
        uint256 maxSwapBips
        ) external onlyOwner {
        require(thresholdBips <= 200, "Threshold max 2%");
        require(thresholdBips >= 10, "Threshold min 0.1%");
        require(maxSwapBips <= 100, "MaxSwap max 1%");
        require(maxSwapBips >= 5, "MaxSwap min 0.05%");
    
        uint256 newThreshold = totalSupply() * thresholdBips / 10000;
        uint256 newMaxSwap = totalSupply() * maxSwapBips / 10000;
        require(newMaxSwap < newThreshold, "MaxSwap must be < Threshold");
        _taxSwapThreshold = newThreshold;
        _maxTaxSwap = newMaxSwap;
        emit TaxSwapSettingsUpdated(
            newThreshold,
            newMaxSwap,
            "Owner adjusted tax swap settings"
        );
    }

    function updateStripclubAddress(address payable newAddress) external onlyOwner {
        require(newAddress != address(0), "New address cannot be zero address");
        _Stripclub = newAddress;
        emit StripclubAddressUpdated(newAddress); 
   } 

    function startTradingWithHighTax() external onlyOwner {
        require(!_startTradingExecuted, "Trading already started retarded degen");
        _buyFee = 3000;  
        _sellFee = 3000; 
        _startTradingExecuted = true;
        tradingStartTime = block.timestamp;
        emit TaxesUpdated(_buyFee, _sellFee, "Start Trading - High Tax Phase Faggot");
    }

    /*** @dev Launch sequence using boolean + timestamp checks for safety:
        startTradingWithHighTax(): Owner controlled (30% tax, sets _startTradingExecuted)
        reduceTaxAfterLaunch(): Anyone can call after 5min (5% tax) - prevents malicious high tax trap/dev manipulation
        Protected by requires: _startTradingExecuted check prevents early reduction
        Time-gated: block.timestamp + 5min prevents rush
        One-time execution: Boolean flags prevent replay
        = Safe launch with guaranteed tax reduction, no way to keep high tax
    ***/

    function reduceTaxAfterLaunch() external {
        require(_startTradingExecuted, "Trading not started");
        require(!_cooldownTaxExecuted, "Cooldown already executed");
        require(block.timestamp >= tradingStartTime + 5 minutes, "Too early");
   
        _buyFee = 500;  
        _sellFee = 500;
        _cooldownTaxExecuted = true;
   
        emit TaxesUpdated(_buyFee, _sellFee, "Cooldown Period");
    }

    function setFinalTaxes() external onlyOwner {
        require(_cooldownTaxExecuted, "Must set cooldown taxes first");
        require(!_finalTaxExecuted, "Final taxes already executed");
        _buyFee = 69;   
        _sellFee = 690; 
        _finalTaxExecuted = true;
        emit TaxesUpdated(_buyFee, _sellFee, "Final Taxes");
    }

    function setUltimateTaxes() external onlyOwner {
        require(_finalTaxExecuted, "Must set final taxes first");
        require(!_ultimateTaxExecuted, "Ultimate taxes already executed");
    
        _buyFee = 69;  
        _sellFee = 69; 
        _maxWallet = totalSupply(); 
        _ultimateTaxExecuted = true;
    
        emit TaxesUpdated(_buyFee, _sellFee, "Ultimate Taxes");
        emit MaxWalletRemoved(block.timestamp);
    }

    function setZeroTaxes() external onlyOwner {
        require(_ultimateTaxExecuted, "Must set ultimate taxes first");
        require(!_zeroTaxExecuted, "Zero taxes already executed");
        _buyFee = 0; 
        _sellFee = 0; 
        _zeroTaxExecuted = true;
        emit TaxesUpdated(_buyFee, _sellFee, "Zero Taxes");
    }

    function getTaxPhaseStatus() external view returns (
        bool tradingStarted,      
        bool cooldownExecuted,    
        bool finalPhase,          
        bool ultimateExecuted,    
        bool zeroTaxSet          
    ) {
        return (
            _startTradingExecuted,
            _cooldownTaxExecuted,
            _finalTaxExecuted,
            _ultimateTaxExecuted,
            _zeroTaxExecuted
        );
    }

    function getCurrentTaxSwapSettings() external view returns (
        uint256 threshold,
        uint256 maxSwap
        ) {
        return (_taxSwapThreshold, _maxTaxSwap);
    }

    function getCurrentTaxes() external view returns (uint256 buyTax, uint256 sellTax) {
        return (_buyFee, _sellFee);
    }

    function toggleSwapEnabled() external onlyOwner {
        swapEnabled = !swapEnabled;
    }

    function setUniswapV2Pair(address _uniswapV2Pair) public onlyOwner {
        require(uniswapV2Pair == address(0), "uniswapV2Pair has already been set");
        uniswapV2Pair = _uniswapV2Pair;
    }

    function _transfer(address from, address to, uint256 amount) override internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        
        if (!_isExemptFromExitTax[from] && !_isExemptFromExitTax[to]) {
            require(_startTradingExecuted, "Trading not started");
            uint256 taxAmount = 0;

            if (to == uniswapV2Pair) {
                taxAmount = amount * _sellFee / 10000;  // Changed from 100 to 10000
            } else if (from == uniswapV2Pair && to != uniswapV2Pair && to != address(uniswapV2Router)) {
                require(balanceOf(to) + amount <= _maxWallet, "Exceeds the maxWallet.");
                taxAmount = amount * _buyFee / 10000;  // Changed from 100 to 10000
            }

            uint256 contractTokenBalance = balanceOf(address(this));
            if (to == uniswapV2Pair && swapEnabled && contractTokenBalance > _maxTaxSwap) {
                swapTokensForEth(min(amount, min(contractTokenBalance, _taxSwapThreshold)));
                uint256 contractETHBalance = address(this).balance;
                if(contractETHBalance > 0) {
                    sendETHToFee(address(this).balance);
                }
            }

            if(taxAmount > 0){
                amount -= taxAmount;
                super._transfer(from, address(this), taxAmount);
            }
        }

        super._transfer(from, to, amount);
    }

    function min(uint256 a, uint256 b) private pure returns (uint256){
      return (a>b)?b:a;
    }

    function swapTokensForEth(uint256 tokenAmount) internal {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        _approve(address(this), address(uniswapV2Router), tokenAmount);
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }
    
    function manualSwap() external onlyOwner {
        uint256 tokenBalance=balanceOf(address(this));
        if(tokenBalance>0){
            swapTokensForEth(tokenBalance);
        }
        uint256 ethBalance=address(this).balance;
        if(ethBalance>0){
            sendETHToFee(ethBalance);
        }
    }

        /*** @dev Token Recovery Functions:
        rescueCloggedTokens: Recovers ANY stuck ERC20 tokens from contract
                   - Rescue mechanism for tokens sent/stuck in contract
                   - Sends to fixed Stripclub wallet
                   - Balance check prevents empty transfers
                   - More accurate name for its true purpose
        ***/

    function rescueCloggedTokens(address tokenAddress) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        uint256 contractTokenBalance = token.balanceOf(address(this));
        require(contractTokenBalance > 0, "No tokens to withdraw");
        token.transfer(_Stripclub, contractTokenBalance);
    }

        /*** @dev
        burnTax: Burns accumulated tax tokens permanently
                 Reduces supply by sending to dead address
                 Both functions = flexibility in tax usage
        ***/

    function burnTax(uint256 tokenAmount) external onlyOwner {
        require(tokenAmount > 0, "Invalid token amount");
        require(tokenAmount <= balanceOf(address(this)), "Exceeds contract token balance");

        address deadAddress = 0x000000000000000000000000000000000000dEaD;
        _transfer(address(this), deadAddress, tokenAmount);
    
        emit TokensBurned(tokenAmount, msg.sender);
    }

    function sendETHToFee(uint256 amount) private {
        _Stripclub.transfer(amount);
    }

    function recoverETH(address payable to) external onlyOwner {
        require(to != address(0), "Invalid address provided");
        uint256 balance = address(this).balance;
        (bool success, ) = to.call{value: balance}("");
        require(success, "Failed to send Ether");
    }

        /*** @dev Emergency ETH Recovery:
        Allows owner to rescue stuck ETH from contract
        Uses low-level call for maximum gas efficiency
        Prevents sending to zero address
        Safety: Only owner can call
        ***/

    function recoverERC20(address token, address to) external onlyOwner {
        require(to != address(0), "Invalid address provided");
        IERC20 erc20Token = IERC20(token);
        uint256 balance = erc20Token.balanceOf(address(this));
        erc20Token.transfer(to, balance);
    }

    receive() external payable {}

    }