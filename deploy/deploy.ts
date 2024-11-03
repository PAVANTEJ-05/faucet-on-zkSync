 import { deployContract } from "./utils"; 

 export default async function () {
     try {
  const faucetArtifactName = "TokenFaucet"; 
 
         const faucetConstructorArguments: any[] = []; 
 

         const faucetAddress = await deployContract(faucetArtifactName, faucetConstructorArguments);
         console.log("TokenFaucet deployed at:", faucetAddress);
         
     } catch (error) {
         console.error("Deployment failed:", error);
     }
 }
 
