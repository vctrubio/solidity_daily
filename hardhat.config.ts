import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import "@nomicfoundation/hardhat-ethers"; // Add ethers support

const config: HardhatUserConfig = {
  solidity: "0.8.28",
};

export default config;
