import * as hre from "hardhat";
import { getWallet } from "./utils";
import { ethers } from "hardhat";
import {  formatUnits } from "ethers";
import * as dotenv from "dotenv";
dotenv.config();

const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS as string;
if (!CONTRACT_ADDRESS) throw new Error("⛔️ Provide address of the contract to interact with in the .env file!");

export default async function () {
  console.log(`Running script to interact with contract at ${CONTRACT_ADDRESS}`);

  const contractArtifact = await hre.artifacts.readArtifact("TokenFaucet");

  const tokenFaucet = new ethers.Contract( CONTRACT_ADDRESS, contractArtifact.abi, getWallet());

  async function claimTokens() {
    try {
      const transaction = await tokenFaucet.claimTokens();
      console.log(`Transaction hash for claiming tokens: ${transaction.hash}`);
      await transaction.wait();
      console.log("Tokens claimed successfully.");
    } catch (error) {
      console.error("Error claiming tokens:", error);
    }
  }


  async function checkBalance(address: string) {
    try {
      const balance = await tokenFaucet.balanceOf(address);
      console.log(`Balance of ${address}: ${formatUnits(balance, 18)} tokens`);
    } catch (error) {
      console.error("Error checking balance:", error);
    }
  }

  console.log(" claiming tokens...");
  await claimTokens();

  console.log("Checking balance of the wallet...");
  await checkBalance(getWallet().address);
}
