//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Score {

    uint256 public score;

    address public owner;

    mapping(address => uint256) scoreList;
    address[] keyList;

    uint256[] allPossibleNumber;
    uint256[9] oneDigitNumber;

    struct Funder {
        address addr;
        uint256 amount;
    }

    // will hold address + amount
    Funder giver;


    // modifier is like an iterator
    // so essentially provides an early exit to a function if a condition isn't met
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    // good to have a log of what happened
    // can have max only 3 indexers
    event scoreSet2(uint256, address indexed);
    
    // not reused
    constructor() {
        owner = msg.sender;
    }

    function setScore(uint256 newScore) public onlyOwner {
        score = newScore;
        giver.addr = msg.sender;
        giver.amount = 123;
        scoreList[msg.sender] = 53;
        // allPossibleNumber.push(score);
        // oneDigitNumber[0] = 7;
        emit scoreSet2(newScore, msg.sender);
    }

    function getScore() public view returns (uint) {
        return score;
    }

    // going into mapping and passing in key user to return uint256
    function getUserScore(address user) public view returns (uint256) {
        return scoreList[user];
    }

}