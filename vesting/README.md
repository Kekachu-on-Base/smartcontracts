# Token Vesting Smart Contracts

This repository contains the implementation of token vesting contracts for distributing tokens over specified time periods on Base Network.

## Overview

Four vesting contracts have been deployed, each handling 20 million tokens with different vesting durations:
- 1 month (30 days)
- 2 months (60 days)
- 3 months (90 days)
- 4 months (120 days)

## Contract Details

- Token Address: `0x0D8CB592f8ED649Cd6AC6bDF83Df092Bf6870f0c`
- Token Decimals: 8
- Amount per Contract: 20,000,000 tokens
- Network: Base Mainnet

## Deployed Contracts

| Duration | Contract Address | Start Date | End Date |
|----------|-----------------|------------|-----------|
| 30 days  | [Contract 1] | Dec 14, 2024 08:28:38 UTC | Jan 13, 2025 08:28:38 UTC |
| 60 days  | [Contract 2] | [Start Date] | [End Date] |
| 90 days  | [Contract 3] | [Start Date] | [End Date] |
| 120 days | [Contract 4] | [Start Date] | [End Date] |

## Key Functions

### View Functions

1. Check Vesting Schedule:
```solidity
function start() public view returns (uint256)
function duration() public view returns (uint256)
function end() public view returns (uint256)
```

2. Check Released Amounts:
```solidity
function released(address token) public view returns (uint256)
function releasable(address token) public view returns (uint256)
```

3. Check Vested Amount:
```solidity
function vestedAmount(address token, uint64 timestamp) public view returns (uint256)
```

### Action Functions

1. Release Vested Tokens:
```solidity
function release(address token) public
```

## Verification Guide

### Contract Verification Parameters

For the 30-day contract:
- Start Timestamp: 1731518918 (December 14, 2024 08:28:38 UTC)
- Duration: 2592000 (30 days in seconds)
- End Timestamp: 1734110918 (January 13, 2025 08:28:38 UTC)

To verify on Basescan:
```bash
npx hardhat verify --network base CONTRACT_ADDRESS 1731518918 2592000
```

### Timestamp Calculations
- 1 day = 86400 seconds
- 30 days = 2592000 seconds
- 60 days = 5184000 seconds
- 90 days = 7776000 seconds
- 120 days = 10368000 seconds

## Monitoring Vesting Progress

1. Check Current Vested Amount:
   - Call `vestedAmount(tokenAddress, uint64(block.timestamp))`
   - Compare with total allocation (20M tokens)

2. Check Available for Release:
   - Call `releasable(tokenAddress)`
   - This shows tokens ready for claiming

3. View Release History:
   - Check `Released` events in contract history
   - Call `released(tokenAddress)` for total released amount

## Important Links

- [Base Network Explorer](https://basescan.org)
- [Token Contract](https://basescan.org/address/0x0D8CB592f8ED649Cd6AC6bDF83Df092Bf6870f0c)
- [Vesting Contract Source Code](./contracts/VestingWallet.sol)

## Technical Implementation

The vesting contract implements:
- Linear vesting schedule
- Token release mechanism
- SafeERC20 for secure token transfers
- Ownable pattern for access control

### Vesting Formula

The amount of tokens vested at any given time is calculated using:
```
if (timestamp < start) return 0;
if (timestamp > end) return totalAllocation;
return (totalAllocation * (timestamp - start)) / duration;
```

## Security Considerations

1. Owner Control
   - The beneficiary (owner) is set at deployment
   - Owner can transfer ownership

2. Token Safety
   - Uses OpenZeppelin's SafeERC20
   - Protected against token transfer failures

3. Time Mechanics
   - Based on block timestamps
   - Linear release mechanism
   - No admin function to modify schedule

## Testing

1. Local Testing:
```bash
npx hardhat test
```

2. Live Contract Testing:
   - Check vested amounts using view functions
   - Monitor token balances
   - Track release events

## Development

Built using:
- Hardhat
- OpenZeppelin Contracts v5.1.0
- Solidity ^0.8.20

## License

MIT License