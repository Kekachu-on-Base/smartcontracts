# CHUD Token

CHUD is a deflationary token implementing advanced tax evolution mechanics and automated liquidity management on the Base Network.

## Tokenomics

### Total Supply: 69,000,000,000 CHUD

#### Initial Distribution
| Allocation | Percentage | Amount | Description |
|------------|------------|---------|-------------|
| Permanent Burn | 69% | 47,610,000,000 | Initial burn to reduce total supply |
| Liquidity Pool | 14% | 9,660,000,000 | Initial liquidity provision |
| LP Staking | 10% | 6,900,000,000 | Rewards for LP staking program |
| Project Development | 4.20% | 2,898,000,000 | Project development fund (12-month timelock) |
| Development Team | 2.76% | 1,904,400,000 | Split across multiple timelocks |
| Reserve | 0.04% | 27,600,000 | Emergency fund |

#### Development Team Allocation Breakdown
| Timelock Period | Percentage | Amount |
|-----------------|------------|---------|
| 1 Month Lock | 0.69% | 476,100,000 |
| 2 Month Lock | 0.69% | 476,100,000 |
| 3 Month Lock | 0.69% | 476,100,000 |
| 6 Month Lock | 0.69% | 476,100,000 |

### Tax Structure Evolution
The contract implements a dynamic tax structure that evolves through multiple phases:

1. **Launch Phase (0-5 minutes)**
   - Buy Tax: 30%
   - Sell Tax: 30%
   - Purpose: Anti-sniper protection

2. **Stabilization Phase (Post 5 minutes)**
   - Buy Tax: 5%
   - Sell Tax: 5%
   - Purpose: Market stabilization

3. **Maturity Phase**
   - Buy Tax: 0.69%
   - Sell Tax: 6.9%
   - Purpose: Sustainable tokenomics

4. **Final Phase**
   - Buy Tax: 0.69%
   - Sell Tax: 0.69%
   - Max Wallet Limit: Removed
   - Purpose: Market normalization

5. **Ultimate Phase**
   - Buy Tax: 0%
   - Sell Tax: 0%
   - Purpose: Full decentralization

### Security Features
- Max Wallet: 1% of total supply (until final phase)
- Max Transaction: Dynamic based on phase
- Tax Swap Threshold: 0.3% of total supply
- Max Tax Swap: 0.1% of total supply
- Anti-Bot Measures: Progressive tax reduction
- Automated Liquidity Generation

Would you like me to continue with other sections of the README, such as:
1. Technical Features & Contract Architecture
2. Security Mechanisms
3. Deployment & Network Information
4. Setup & Integration Guide
5. Development Commands & Testing

Let me know which section you'd like to focus on next!
