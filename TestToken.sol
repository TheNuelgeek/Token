// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

contract TestToken{

    // A token contract
    // define the total number of token that will ever be in exitence
    // be able to tranfer from one account to another

    // STATE VARIABLES 

    uint public totalSupply;
    string public nameOfToken;
    string public tokenSymbol;
    //address tokenAddress;

    mapping(address => uint) public balances;

    // FUNCTIONS

    constructor(
        uint _totalSupply,
        string memory _nameOfToken,
        string memory _tokenSymbol
    )
    {
        totalSupply = _totalSupply;
        nameOfToken = _nameOfToken;
        tokenSymbol = _tokenSymbol;
       balances[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint amount)public returns(bool) {
        uint userBal = balances[msg.sender];
        require(amount <= userBal,"Insufficient Balance");
        balances[msg.sender] -= amount;
        balances[_to] += amount;
        return true;   
    }
}