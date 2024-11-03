//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenFaucet is ReentrancyGuard, Ownable {
    string public name = "Test Token";
    string public symbol = "TEST";
    uint256 public totalSupply = 1000000 * (10 **18);
    mapping(address => uint256) public balanceOf;
    
    uint256 public distributionAmount = 100 * (10**18); 
    uint256 public cooldownPeriod = 2 minutes;

    mapping(address => uint256) public lastClaimTime;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event TokensClaimed(address indexed recipient, uint256 amount);

    constructor() {
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Transfer to the zero address");
        require(balanceOf[msg.sender] >= amount* (10**18), "Insufficient balance");

        balanceOf[msg.sender] -= amount* (10**18);
        balanceOf[to] += amount* (10**18);
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function claimTokens() external nonReentrant {
        require( block.timestamp >= lastClaimTime[msg.sender] + cooldownPeriod,
         "Please wait for cooldown period" );

        require(balanceOf[address(this)] >= distributionAmount,
            "Insufficient tokens in faucet");

        lastClaimTime[msg.sender] = block.timestamp;
        balanceOf[address(this)] -= distributionAmount;
        balanceOf[msg.sender] += distributionAmount;


        emit TokensClaimed(msg.sender, distributionAmount);
        emit Transfer(address(this), msg.sender, distributionAmount);
    }

    function setDistributionAmount(uint256 _amount) external onlyOwner {
        distributionAmount = _amount;
    }

    function setCooldownPeriod(uint256 _period) external onlyOwner {
        cooldownPeriod = _period;
    }

    function withdrawTokens(uint256 _amount) external onlyOwner {
        require(balanceOf[address(this)] >= _amount, "Insufficient tokens in faucet");
        balanceOf[address(this)] -= _amount;
        balanceOf[msg.sender] += _amount;
        emit Transfer(address(this), msg.sender, _amount);
    }
}
