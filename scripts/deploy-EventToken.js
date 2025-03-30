const hre = require("hardhat");

async function main() {
  console.log("Deploying EventToken contract...");

  // Display network information
  const network = hre.network.name;
  console.log(`Network: ${network}`);
  
  // Get chainId and other network details when available
  const provider = hre.ethers.provider;
  const { chainId } = await provider.getNetwork();
  console.log(`Chain ID: ${chainId}`);
  
  // Get the contract factory
  const EventToken = await hre.ethers.getContractFactory("EventToken");
  
  // Deploy the contract
  const eventToken = await EventToken.deploy();
  
  // Wait for deployment to complete
  await eventToken.waitForDeployment();
  
  const address = await eventToken.getAddress();
  console.log(`EventToken deployed to: ${address}`);

  // Display some additional information
  console.log("\nContract details:");
  console.log("----------------");
  
  const deployer = (await hre.ethers.getSigners())[0];
  console.log(`Deployer address: ${await deployer.getAddress()}`);
  
  // Block explorer URL if available for known networks
  let explorerUrl = "";
  if (network === "mainnet") {
    explorerUrl = `https://etherscan.io/address/${address}`;
  } else if (network === "sepolia") {
    explorerUrl = `https://sepolia.etherscan.io/address/${address}`;
  } else if (network === "polygon") {
    explorerUrl = `https://polygonscan.com/address/${address}`;
  } else if (network === "mumbai") {
    explorerUrl = `https://mumbai.polygonscan.com/address/${address}`;
  }
  
  if (explorerUrl) {
    console.log(`Explorer URL: ${explorerUrl}`);
  }
  
  console.log("\nVerification command:");
  console.log("--------------------");
  console.log(`npx hardhat verify --network ${network} ${address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
