#!/bin/bash

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

# Create centered header function
print_centered_header() {
    local term_width=$(tput cols)
    local text="$1"
    local color="$2"
    local padding=$(( (term_width - ${#text}) / 2 ))
    printf "%${padding}s" ''
    echo -e "${color}${text}${NC}"
}

# Function to generate random token name and symbol
generate_token_data() {
    local adjectives=("Super" "Mega" "Ultra" "Hyper" "Cosmic" "Digital" "Crypto" "Smart" 
        "Alpha" "Beta" "Delta" "Omega" "Epic" "Elite" "Prime" "Neo" "Meta" "Quantum" 
        "Solar" "Lunar" "Stellar" "Galaxy" "Atomic" "Phoenix" "Dragon" "Thunder" 
        "Crystal" "Diamond" "Golden" "Silver" "Platinum" "Infinity" "Unity" "Legacy"
        "Rapid" "Swift" "Agile" "Dynamic" "Power" "Energy" "Force" "Vital" 
        "Global" "World" "Earth" "Space" "Star" "Nova" "Nebula" "Quasar")
    
    local nouns=("Coin" "Token" "Cash" "Money" "Chain" "Link" "Net" "Pay" 
        "Finance" "Capital" "Credit" "Profit" "Share" "Stock" "Bond" "Fund" 
        "Asset" "Wealth" "Fortune" "Bank" "Trade" "Market" "Exchange" "Vault" 
        "Reserve" "Treasury" "Equity" "Value" "Gold" "Silver" "Crypto" "Block")
    
    local adj=${adjectives[$RANDOM % ${#adjectives[@]}]}
    local noun=${nouns[$RANDOM % ${#nouns[@]}]}
    
    local name="$adj$noun"
    local symbol="${name:0:1}${noun:0:2}"
    local supply=$((RANDOM % 100000000 + 1000000))
    
    echo "$name|$symbol|$supply"
}

# Clear screen and print header
clear
echo
print_centered_header "Tea Testnet Auto Deploy" "${GREEN}"
print_centered_header "made by t.me/bim0000" "${YELLOW}"
print_centered_header "join t.me/garapanbimo" "${BLUE}"
echo
print_centered_header "if you want to support me :" "${NC}"
print_centered_header "0x48baa3ACE7CdDeE47C100e87A0FC0A653258eb55" "${BLUE}"
print_centered_header "[EVM]" "${NC}"
echo
print_centered_header "3mSmt3fLQdP1eG8JH9fGTU2Wm3Z2HSs2fbaf1KyPjUq7" "${BLUE}"
print_centered_header "[SOLANA]" "${NC}"
echo
print_centered_header "ENJOY!" "${GREEN}"
echo
print_centered_header "Installing dependencies..." "${BLUE}"

# Create project structure
mkdir -p dist
touch .env

# Install dependencies silently
npm init -y > /dev/null 2>&1
npm install ethers@6.7.1 dotenv typescript tsx @types/node > /dev/null 2>&1

# Create configuration files
cat > package.json << 'EOL'
{
  "name": "token-factory-bot",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "start": "tsx deploy.ts"
  },
  "dependencies": {
    "ethers": "^6.7.1",
    "dotenv": "^16.0.3",
    "typescript": "^5.0.0",
    "tsx": "^4.7.0",
    "@types/node": "^18.0.0"
  }
}
EOL

cat > tsconfig.json << 'EOL'
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "esModuleInterop": true,
    "strict": true,
    "skipLibCheck": true,
    "outDir": "./dist"
  }
}
EOL

# Create deploy.ts with fixed factory address
cat > deploy.ts << 'EOL'
import { ethers } from 'ethers';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

dotenv.config();

const RED = '\x1b[31m';
const GREEN = '\x1b[32m';
const YELLOW = '\x1b[33m';
const BOLD = '\x1b[1m';
const RESET = '\x1b[0m';

const FACTORY_ABI = [
    "function createToken(string memory name, string memory symbol, uint256 totalSupply, address recipient) public",
    "function getDeployedTokens() public view returns (address[] memory)"
];

const FACTORY_ADDRESS = "0x847d23084c474e7a0010da5fa869b40b321c8d7b";
const provider = new ethers.JsonRpcProvider("https://tea-sepolia.g.alchemy.com/public");

async function getTotalTransactions(address: string): Promise<number> {
    return await provider.getTransactionCount(address);
}

async function deployToken(privateKey: string, name: string, symbol: string, totalSupply: string) {
    try {
        const wallet = new ethers.Wallet(privateKey, provider);
        const factory = new ethers.Contract(FACTORY_ADDRESS, FACTORY_ABI, wallet);
        
        console.log(`${RED}++++++++++++++++++++++++++${RESET}`);
        console.log(`${GREEN}Wallet Deployer: ${wallet.address}${RESET}`);
        console.log(`${BOLD}Deploying New Token >> ${name} <<${RESET}`);
        
        const tx = await factory.createToken(
            name,
            symbol,
            ethers.parseUnits(totalSupply, 18),
            wallet.address,
            { gasLimit: 3000000 }
        );
        
        const receipt = await tx.wait();
        const txCount = await getTotalTransactions(wallet.address);

        console.log(`Token Deployed! TX: ${receipt.hash}`);
        console.log(`${YELLOW}Total Transactions: ${txCount}${RESET}`);
        console.log(`${RED}++++++++++++++++++++++++++${RESET}\n`);
        
        return receipt.hash;
    } catch (error: any) {
        console.error(`${RED}Error deploying token: ${error?.message || 'Unknown error'}${RESET}`);
        return null;
    }
}

async function main() {
    const privateKeys = process.env.PRIVATE_KEYS?.split(',') || [];
    
    for (const key of privateKeys) {
        const tokenData = process.argv[2].split('|');
        await deployToken(key.trim(), tokenData[0], tokenData[1], tokenData[2]);
    }
}

main().catch((error) => {
    console.error('Fatal error:', error);
    process.exit(1);
});
EOL

# Create .gitignore
cat > .gitignore << 'EOL'
node_modules
.env
dist
EOL

# Function to add private key
add_private_key() {
    echo -e "${BLUE}Enter private key (or press Enter to finish):${NC}"
    read -r key
    
    if [ -n "$key" ]; then
        if grep -q "PRIVATE_KEYS=" .env; then
            sed -i "s/PRIVATE_KEYS=\(.*\)/PRIVATE_KEYS=\1,$key/" .env
        else
            echo "PRIVATE_KEYS=$key" >> .env
        fi
        return 0
    else
        return 1
    fi
}

# Main script
echo -e "${BLUE}Please add your private keys:${NC}"

while add_private_key; do
    echo -e "${GREEN}Private key added successfully!${NC}"
done

# Start deployment loop
echo -e "${GREEN}Starting deployment bot...${NC}"

while true; do
    token_data=$(generate_token_data)
    npx tsx deploy.ts "$token_data"
    echo -e "${BLUE}Waiting 60 seconds before next deployment...${NC}"
    sleep 60
done
