//3
// SPDX-License-Identifier: UNLICENSED

//2
pragma solidity >0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

//4
contract VolcanoCoin is Ownable {

    //5
    uint256 public totalSupply = 10000;

    //8
    // address owner;

    //18
    struct Payment {
        address addr;
        uint256 amount;
    }

    //13
    mapping(address => uint256) public balances;

    //19 **this is the tricky part for me
    mapping(address=>Payment[]) public paymentLog;
    // don't need the [] actually

    //12
    event totalSupplyChange(uint256);

    //17
    event transferChange(uint256, address);

    //11,15 ->why??
    constructor() {
        transferOwnership(msg.sender);
        balances[msg.sender] = totalSupply;
    }

    //6
    function returnTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

    //7,10,12
    function increaseSupply() external onlyOwner {
        totalSupply += 1000;
        emit totalSupplyChange(totalSupply);
    }
    
    //14
    function getUserCoin(address user) external view returns (uint256) {
        return balances[user];
    }

    //16,17,18
    function transfer(address toUser, uint256 transferCoin) external {
        // added condition
        require(balances[msg.sender] >= transferCoin, "Sender does not have enough balance");
        balances[toUser] += transferCoin;
        balances[msg.sender] -= transferCoin;
        //from Kyle's answer:
        paymentLog[msg.sender].push(Payment(toUser,transferCoin));
        // paymentLog[msg.sender] = Payment(toUser,transferCoin);
        emit transferChange(transferCoin, toUser);
    }
    
    //19 **also used Kyle's answer - why memory?
    function getPayment(address user) public view returns (Payment[] memory) {
        return paymentLog[user];
    }
}