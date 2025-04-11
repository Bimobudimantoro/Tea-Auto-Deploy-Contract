# Tea Network Auto Deploy Contract Bot

Automated token deployment bot for Tea Network testnet that creates new tokens every 60 seconds with random names.

## Features
- Automatic token deployment every 60 seconds
- Random token name & symbol generation
- Multiple wallet support
- Transaction count tracking
- Colored console output
- Clean interface

## Prerequisites
- Node.js v16+
- npm or yarn
- bash shell environment

## Installation & Usage Guide

### Linux Users
```bash
# Install dependencies
apt update
apt install git nodejs npm

# Clone and setup
git clone https://github.com/Bimobudimantoro/Tea-Auto-Deploy-Contract.git
cd Tea-Auto-Deploy-Contract
chmod +x token-factory-bot.sh
./token-factory-bot.sh
```

### Windows WSL Users
```bash
# Enable WSL if not already enabled (in PowerShell as Administrator)
wsl --install

# Install dependencies in WSL
sudo apt update
sudo apt install git nodejs npm

# Clone and setup
git clone https://github.com/Bimobudimantoro/Tea-Auto-Deploy-Contract.git
cd Tea-Auto-Deploy-Contract
chmod +x token-factory-bot.sh
./token-factory-bot.sh
```

### Termux Users
```bash
# Install dependencies
pkg update
pkg install git nodejs-lts
termux-setup-storage

# Clone and setup
git clone https://github.com/Bimobudimantoro/Tea-Auto-Deploy-Contract.git
cd Tea-Auto-Deploy-Contract
chmod +x token-factory-bot.sh
./token-factory-bot.sh
```

## Usage Instructions

1. Run the script:
```bash
./token-factory-bot.sh
```

2. Enter your private key(s) when prompted
   - You can add multiple private keys
   - Press Enter without input to finish adding keys

3. The bot will automatically:
   - Generate random token names
   - Deploy tokens every 60 seconds
   - Show transaction details and counts

## Configuration

The script automatically creates all necessary files:
- `package.json` - Project dependencies
- `tsconfig.json` - TypeScript configuration
- `deploy.ts` - Deployment logic
- `.env` - Private key storage (not tracked by git)

## Support

If you find this bot useful, feel free to support the developer:

**EVM**: `0x48baa3ACE7CdDeE47C100e87A0FC0A653258eb55`  
**Solana**: `3mSmt3fLQdP1eG8JH9fGTU2Wm3Z2HSs2fbaf1KyPjUq7`

## Community

Join our community:
- Telegram: [@garapanbimo](https://t.me/garapanbimo)
- Developer: [@bim0000](https://t.me/bim0000)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Disclaimer

This is a tool for testnet usage. Always verify transactions and use at your own risk.
