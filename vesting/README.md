# Kekachu ($KEKU) Token Vesting Documentation

This repository contains the implementation of token vesting contracts for distributing $KEKU tokens over specified time periods on Base Network.

## Overview

Four vesting contracts have been deployed, each handling 0.69% of total supply (476,100,000 $KEKU) with sequential vesting periods:
- Contract 1: Immediate start, 30-day vesting
- Contract 2: Starts after 1 month, 30-day vesting
- Contract 3: Starts after 2 months, 30-day vesting
- Contract 4: Starts after 3 months, 30-day vesting

## Token Details

- Name: Kekachu
- Symbol: $KEKU
- Contract Address: `0x0D8CB592f8ED649Cd6AC6bDF83Df092Bf6870f0c`
- Decimals: 8
- Total Supply: 69,000,000,000 $KEKU
- Amount per Vesting Contract: 476,100,000 $KEKU (0.69% of supply)
- Network: Base Mainnet

## Deployed Vesting Contracts

| Contract | Address | Start Date | End Date | Amount |
|----------|---------|------------|-----------|---------|
| Vesting 1 | `0x3709ADF4968153C01381AA550271BeBF2c22C6d9` | Nov 13, 2024 | Dec 13, 2024 | 476.1M $KEKU |
| Vesting 2 | `0x59A28a82a47e5D43e1F3c68024b327168F63dE81` | Dec 13, 2024 | Jan 13, 2025 | 476.1M $KEKU |
| Vesting 3 | `0x0eA8b2827314fD8cEf2f9Dd031EE60cA06FC5F42` | Jan 13, 2025 | Feb 13, 2025 | 476.1M $KEKU |
| Vesting 4 | `0xa1969FDF5B34b78EeD6EE66e5bB083AC336c347C` | Feb 13, 2025 | Mar 13, 2025 | 476.1M $KEKU |

## Vesting Schedule

Total tokens being vested: 1,904,400,000 $KEKU (2.76% of total supply)

### Release Schedule
- Nov 13 - Dec 13, 2024: Contract 1 releases ~15.87M $KEKU daily
- Dec 13 - Jan 13, 2025: Contract 2 releases ~15.87M $KEKU daily
- Jan 13 - Feb 13, 2025: Contract 3 releases ~15.87M $KEKU daily
- Feb 13 - Mar 13, 2025: Contract 4 releases ~15.87M $KEKU daily

Each contract:
- Vests linearly over 30 days
- Releases tokens continuously
- Can be claimed at any time during vesting
- Automatically calculates claimable amounts

## How to Check Your Vesting

1. Connect to Base Network
2. Check the contract for your vesting period
3. Use view functions to see:
   - Total vested amount
   - Available for claiming
   - Already claimed amount

## Important Links

- [Base Explorer](https://basescan.org)
- [$KEKU Token](https://basescan.org/address/0x0D8CB592f8ED649Cd6AC6bDF83Df092Bf6870f0c)
- [Vesting Contract 1](https://basescan.org/address/0x3709ADF4968153C01381AA550271BeBF2c22C6d9)
- [Vesting Contract 2](https://basescan.org/address/0x59A28a82a47e5D43e1F3c68024b327168F63dE81)
- [Vesting Contract 3](https://basescan.org/address/0x0eA8b2827314fD8cEf2f9Dd031EE60cA06FC5F42)
- [Vesting Contract 4](https://basescan.org/address/0xa1969FDF5B34b78EeD6EE66e5bB083AC336c347C)

## Security Features

- Linear vesting mechanism
- No admin functions to modify vesting
- Immutable schedule
- Protected token transfers

## Timeline Overview

```
Nov 13 -------- Dec 13 -------- Jan 13 -------- Feb 13 -------- Mar 13
   |              |              |              |              |
Contract 1     Contract 2     Contract 3     Contract 4      Complete
476.1M KEKU    476.1M KEKU    476.1M KEKU    476.1M KEKU
```
