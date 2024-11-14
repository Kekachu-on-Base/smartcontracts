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
- Contract Address: `0x1784D7329f99826b6bFC374eC62eEFA38Ab9F107`
- Decimals: 8
- Total Supply: 69,000,000,000 $KEKU
- Amount per Vesting Contract: 476,100,000 $KEKU (0.69% of supply)
- Network: Base Mainnet

## Deployed Vesting Contracts

| Contract | Address | Start Date | End Date | Amount |
|----------|---------|------------|-----------|---------|
| Vesting 1 | `0x1a062722685FF8F9ea5f33f1ad6707d4FAE6c184` | Nov 13, 2024 | Dec 13, 2024 | 476.1M $KEKU |
| Vesting 2 | `0x611e7A3933F60FC57754Ea48bE19BE7FaD490073` | Dec 13, 2024 | Jan 13, 2025 | 476.1M $KEKU |
| Vesting 3 | `0xa3e0F011653D2a2C1Aac66F56a2Fbb53C7352f51` | Jan 13, 2025 | Feb 13, 2025 | 476.1M $KEKU |
| Vesting 4 | `0xb4bb49d5218CBdd352BA9f73a3C77Ea1ae9A89d3` | Feb 13, 2025 | Mar 13, 2025 | 476.1M $KEKU |

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
- [Vesting Contract 1](https://basescan.org/address/0x1a062722685FF8F9ea5f33f1ad6707d4FAE6c184)
- [Vesting Contract 2](https://basescan.org/address/0x611e7A3933F60FC57754Ea48bE19BE7FaD490073)
- [Vesting Contract 3](https://basescan.org/address/0xa3e0F011653D2a2C1Aac66F56a2Fbb53C7352f51)
- [Vesting Contract 4](https://basescan.org/address/0xb4bb49d5218CBdd352BA9f73a3C77Ea1ae9A89d3)

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
