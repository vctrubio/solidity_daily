.PHONY: compile test clean deploy

# Compile solidity contracts
compile:
	npx hardhat compile

# Run tests with bun
test: compile
	bun run hardhat test

# Run a specific test file
test-file:
	bun run hardhat test $(file)

# Clean build artifacts
clean:
	rm -rf artifacts cache typechain typechain-types

# Deploy using bunx hardhat specific contract + network
deploy-et: 
	bunx hardhat run scripts/deploy-EventToken.js --network localhost

# Default action
all: compile test
