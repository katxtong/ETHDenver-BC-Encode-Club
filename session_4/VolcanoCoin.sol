//3
// SPDX-License-Identifier: UNLICENSED

//2
pragma solidity >0.8.0;

//4
contract VolcanoCoin {

    //5
    uint256 totalSupply = 10000;

    //8
    address owner;

    //13
    mapping(address => uint256) public balances;

    //18
    struct Payment {
        address addr;
        uint256 amount;
    }

    //19 **this is the tricky part for me
    mapping(address=>Payment[]) public paymentLog;

    //12
    event totalSupplyChange(uint256, address indexed);

    //17
    event transferChange(uint256, address indexed);

    //11,15
    constructor() {
        owner = msg.sender;
        balances[msg.sender] = 10000;
    }

    //9
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    //6
    function returnTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    //7,10,12
    function increaseSupply() public onlyOwner {
        totalSupply += 1000;
        emit totalSupplyChange(totalSupply, msg.sender);
    }
    
    //14
    function getUserCoin(address user) public view returns (uint256) {
        return balances[user];
    }

    //16,17,18
    function transfer(address toUser, uint256 transferCoin) public {
        balances[toUser] += transferCoin;
        balances[msg.sender] -= transferCoin;    
        //paymentLog.addr = msg.sender;
        //paymentLog.amount = transferCoin;
        //from Kyle's answer:
        paymentLog[msg.sender].push(Payment(toUser,transferCoin));
        emit transferChange(transferCoin, toUser);
    }
    
    //19 **also used Kyle's answer - why memory?
    function getPayment(address user) public view returns (Payment[] memory) {
        return paymentLog[user];
    }
}