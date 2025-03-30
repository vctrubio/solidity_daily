// Script to load EventToken contract and provide multiple signers for hardhat console
// Usage: hh console --network <network> > .load scripts/load-EventToken.js

const hre = require("hardhat");

async function loadEventToken() {
  try {
    // Display network information
    const network = hre.network.name;
    console.log(`Network: ${network}`);
    
    const provider = hre.ethers.provider;
    const { chainId } = await provider.getNetwork();
    console.log(`Chain ID: ${chainId}`);
    
    // Get signers
    const signers = await hre.ethers.getSigners();
    const [deployer, a1, a2, a3, a4, a5] = signers;
    
    console.log(`\nAvailable accounts:`);
    console.log(`deployer: ${await deployer.getAddress()}`);
    console.log(`a1: ${await a1.getAddress()}`);
    console.log(`a2: ${await a2.getAddress()}`);
    console.log(`a3: ${await a3.getAddress()}`);
    console.log(`a4: ${await a4.getAddress()}`);
    console.log(`a5: ${await a5.getAddress()}`);
    
    // Contract address - replace with your deployed address or read from deployments file
    let contractAddress;
    
    // Check if an address was provided via environment variable
    if (process.env.CONTRACT_ADDRESS) {
      contractAddress = process.env.CONTRACT_ADDRESS;
      console.log(`\nUsing provided contract address: ${contractAddress}`);
    } else {
      console.log(`\nNo contract address provided. Attempting to deploy a new instance...`);
      // Deploy a new instance if no address provided
      const EventToken = await hre.ethers.getContractFactory("EventToken");
      const eventToken = await EventToken.deploy();
      await eventToken.waitForDeployment();
      contractAddress = await eventToken.getAddress();
      console.log(`Deployed new EventToken to: ${contractAddress}`);
    }
    
    // Get contract instance
    const eventToken = await hre.ethers.getContractAt("EventToken", contractAddress);
    console.log(`\nEventToken loaded at ${contractAddress}`);
    
    // Example interaction - you can remove or modify these
    console.log(`\nExample interactions available:`);
    console.log(`- eventToken.getOwner()`);
    console.log(`- eventToken.connect(a1).subcribe()`);
    console.log(`- eventToken.connect(deployer).subcribe(await a2.getAddress())`);
    console.log(`- eventToken.getTokenOf(await a1.getAddress())`);
    
    // Return the variables to make them available in the console
    return {
      eventToken,
      deployer,
      a1, a2, a3, a4, a5,
      provider,
      network,
      chainId
    };
  } catch (error) {
    console.error("Error loading contract:", error);
    throw error;
  }
}

// Execute the function and assign returned values to global variables
async function main() {
  const contracts = await loadEventToken();
  
  // Assign to global scope for console use
  Object.assign(global, contracts);
  
  console.log("\nAll variables have been loaded into the global scope.");
  console.log("You can now interact with the contract directly.");
}

// Auto-execute when loaded in console
main().catch(err => console.error(err));
