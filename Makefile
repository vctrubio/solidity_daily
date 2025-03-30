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

# Deploy script with NAME parameter
deploy: compile
	bun run hardhat run scripts/deploy-$(NAME).js

# Deploy to a specific network
deploy-network: compile
	bun run hardhat run scripts/deploy-$(NAME).js

# Default action
all: compile test
