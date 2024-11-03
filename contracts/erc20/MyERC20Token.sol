// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// /**
//  * @title MyERC20Token
//  * @dev This is a basic ERC20 token using the OpenZeppelin's ERC20PresetFixedSupply preset.
//  * You can edit the default values as needed.
//  */
// contract MyERC20Token is ERC20Burnable {

//     /**
//      * @dev Constructor to initialize the token with default values.
//      * You can edit these values as needed.
//      */
//     constructor() ERC20("DefaultTokenName", "DTN") {
//         // Default initial supply of 1 million tokens (with 18 decimals)
//         uint256 initialSupply = 1_000_000 * (10 ** 18);

//         // The initial supply is minted to the deployer's address
//         _mint(msg.sender, initialSupply);
//     }

//     // Additional functions or overrides can be added here if needed.
// }

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract TestToken is ERC20, Ownable {
//     constructor() ERC20("Test Token", "TEST") {
//         _mint(msg.sender, 1000000 * 10 ** decimals());
//     }

//     function mint(address to, uint256 amount) public onlyOwner {
//         _mint(to, amount);
//     }
// }

// contract TokenFaucet is ReentrancyGuard, Ownable {
//     TestToken public token;
//     uint256 public distributionAmount = 100 * (10**18); 
//     uint256 public cooldownPeriod= 2 minutes;
   
//     mapping(address => uint256) public lastClaimTime;
    
//     event TokensClaimed(address indexed recipient, uint256 amount);
    
//     constructor(address _tokenAddress) {
//         token = TestToken(_tokenAddress);
//     }
    
//     function claimTokens() external nonReentrant {
//         require(
//             block.timestamp >= lastClaimTime[msg.sender] + cooldownPeriod,
//             "Please wait for cooldown period"
//         );
//         require(
//             token.balanceOf(address(this)) >= distributionAmount,
//             "Insufficient tokens in faucet"
//         );
        
//         lastClaimTime[msg.sender] = block.timestamp;
//         token.transfer(msg.sender, distributionAmount);
        
//         emit TokensClaimed(msg.sender, distributionAmount);
//     }
    
//     function setDistributionAmount(uint256 _amount) external onlyOwner {
//         distributionAmount = _amount;
//     }
    
//     function setCooldownPeriod(uint256 _period) external onlyOwner {
//         cooldownPeriod = _period;
//     }
    
//     function withdrawTokens(uint256 _amount) external onlyOwner {
//         token.transfer(owner(), _amount);
//     }
// }