// import { deployContract } from "../utils";

// export default async function () {
//   await deployContract("MyERC20Token");
// }

const { ethers } = require("hardhat");

export async function main() {
  // Deploy TestToken contract
  const TestToken = await ethers.getContractFactory("TestToken");
  const testToken = await TestToken.deploy();
  await testToken.deployed();
  console.log("TestToken deployed to:", testToken.address);

  // Deploy TokenFaucet contract with TestToken address as an argument
  const TokenFaucet = await ethers.getContractFactory("TokenFaucet");
  const tokenFaucet = await TokenFaucet.deploy(testToken.address);
  await tokenFaucet.deployed();
  console.log("TokenFaucet deployed to:", tokenFaucet.address);

  // (Optional) Transfer some tokens from the owner to the faucet for distribution
  const distributionAmount = ethers.utils.parseUnits("10000", 18); // Adjust the amount as needed
  const transferTx = await testToken.transfer(tokenFaucet.address, distributionAmount);
  await transferTx.wait();
  console.log(`Transferred ${distributionAmount.toString()} tokens to the faucet`);
}

// Run the main function and handle errors
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
