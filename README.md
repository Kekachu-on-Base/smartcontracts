# KEKACHU Token

KEKACHU features automated tax collection and ETH conversion through Uniswap V2, with collected fees being directed to a designated treasury address, incorporating advanced anti-bot measures through a dynamic tax structure, progressive cooldown periods, anti-sniper protection during launch, transparent tax reduction phases, and verifiable transaction processing to prevent honeypot scenarios.

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


## Core Features & Functions

### Tax Management System

#### Phase Control Functions

1. `startTradingWithHighTax()`
   - **Access**: Owner only
   - **Purpose**: Initiates trading with high anti-bot taxes
   - **Effects**:
     - Sets initial buy/sell tax to 30%
     - Starts trading timer
     - Can only be executed once

2. `reduceTaxAfterLaunch()`
   - **Access**: Anyone (but requires conditions)
   - **Purpose**: Reduces taxes after initial anti-bot period
   - **Requirements**:
     - Trading must be started
     - 5 minutes must have passed since launch
     - Not previously executed
   - **Effects**: Reduces both buy/sell taxes to 5%

3. `setFinalTaxes()`
   - **Access**: Owner only
   - **Purpose**: Sets sustainable long-term tax rates
   - **Effects**:
     - Buy tax: 0.69%
     - Sell tax: 6.9%

4. `setUltimateTaxes()`
   - **Access**: Owner only
   - **Purpose**: Equalizes buy/sell taxes and removes limits
   - **Effects**:
     - Both taxes set to 0.69%
     - Removes max wallet restriction

5. `setZeroTaxes()`
   - **Access**: Owner only
   - **Purpose**: Final phase with no taxes
   - **Effects**: Removes all taxes (0%)

### Tax Processing System

#### Automated Tax Collection & Processing

1. `_transfer()`
   - **Purpose**: Core transfer function with tax processing
   - **Features**:
     - Applies appropriate buy/sell taxes
     - Handles max wallet limits
     - Processes automatic tax conversion
     - Exempts whitelisted addresses

2. `swapTokensForEth()`
   - **Purpose**: Converts collected taxes to ETH
   - **Process**:
     - Creates token->WETH swap path
     - Executes swap via Uniswap
     - Internal function called during transfers

3. `sendETHToFee()`
   - **Purpose**: Forwards converted ETH to fee collection address
   - **Process**: Direct ETH transfer to designated wallet

### Management Functions

#### Configuration & Control

1. `updateTaxSwapSettings()`
   - **Access**: Owner only
   - **Purpose**: Configure tax collection parameters
   - **Parameters**:
     - `thresholdBips`: When to trigger swap (0.1% - 2%)
     - `maxSwapBips`: Maximum swap amount (0.05% - 1%)

2. `updateStripclubAddress()`
   - **Access**: Owner only
   - **Purpose**: Update fee collection address
   - **Security**: Cannot be set to zero address

3. `toggleSwapEnabled()`
   - **Access**: Owner only
   - **Purpose**: Enable/disable automatic tax processing

#### Emergency & Recovery Functions

1. `manualSwap()`
   - **Access**: Owner only
   - **Purpose**: Manually trigger tax token conversion
   - **Process**:
     - Swaps all contract tokens to ETH
     - Forwards ETH to fee address

2. `burnTax()`
   - **Access**: Owner only
   - **Purpose**: Burns collected tax tokens
   - **Process**: Transfers specified amount to dead address

3. `recoverETH()`
   - **Access**: Owner only
   - **Purpose**: Recover stuck ETH from contract
   - **Security**: Cannot send to zero address

4. `recoverERC20()`
   - **Access**: Owner only
   - **Purpose**: Recover any stuck ERC20 tokens
   - **Security**: Cannot send to zero address

### Monitoring Functions

#### State & Settings Queries

1. `getTaxPhaseStatus()`
   - **Purpose**: Check current tax phase status
   - **Returns**: Boolean status for each phase

2. `getCurrentTaxSwapSettings()`
   - **Purpose**: View tax swap configuration
   - **Returns**: Current threshold and max swap amounts

3. `getCurrentTaxes()`
   - **Purpose**: Check current tax rates
   - **Returns**: Current buy and sell tax percentages

## Security Features

### Anti-Bot Measures
- High initial taxes (30%)
- 5-minute lockdown period
- Whitelist system for tax exemption

### Transfer Restrictions
- Max wallet limit (until ultimate phase)
- Zero address transfer protection
- Amount validation

### Owner Controls
- Phased tax reduction system
- Emergency recovery functions
- Configuration update capabilities

## Events

1. `TaxesUpdated`
   - Emitted when tax rates change
   - Includes phase information

2. `TokensBurned`
   - Tracks tax token burns
   - Records amount and initiator

3. `MaxWalletRemoved`
   - Signals removal of wallet restrictions

4. `TaxChangeQueued`
   - Indicates pending tax changes

5. `StripclubAddressUpdated`
   - Records fee address updates

6. `TaxSwapSettingsUpdated`
   - Logs changes to swap configuration

## Contract Constants

- `MAX_TAX_SWAP_THRESHOLD`: 2% (200 basis points)
- `MAX_TAX_SWAP_LIMIT`: 1% (100 basis points)
- Initial Supply: 69,000,000,000 tokens
- Decimals: 8
