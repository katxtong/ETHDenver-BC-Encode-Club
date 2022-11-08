// SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.0;

contract VolcanoCoin is Ownable {

    uint256 totalSupply = 10000;
    mapping(address => uint256) balances;
    mapping(address => Payment[]) payments;

    event totalSupplyChange(uint256);
    event transfer(uint256, address);

    struct Payment {
        uint256 amount;
        address receiver;
    }

    constructor() {
        balances[owner()] = 10000;
    }

    function increaseTotalSupply() external onlyOwner {
        require(msg.sender == owner(), "only owner can change total supply");
        totalSupply += 1000;
        balances[owner()] += 1000;
        emit totalSupplyChange(totalSupply);
    }
    
    function transferCoin(address toUser, uint256 transferCoin) external {
        // added condition
        assert(transferCoin >0);
        require(balances[msg.sender] >= transferCoin, "Sender does not have enough balance");
        balances[toUser] += transferCoin;
        balances[msg.sender] -= transferCoin;
        recordPayment(msg.sender, toUser, transferCoin);
        emit transfer(transferCoin, toUser);
    }
        
    //14
    function getUserCoin(address user) external view returns (uint256) {
        return balances[user];
    }
    
    //6
    function returnTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

    //19 **also used Kyle's answer - why memory?
    function getPayment(address user) public view returns (Payment[] memory) {
        return payments[user];
    }

    function recordPayment(address sender, address receiver, uint256 amount) private {
        payments[sender].push(Payment(amount, receiver));
    }

}
