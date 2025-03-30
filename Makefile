.PHONY: compile test clean

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

# Default action
all: compile test
