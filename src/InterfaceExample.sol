// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Define an interface for a generic token contract
interface IToken {
    // Declare functions without implementing them
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}

// A contract that interacts with the 'IToken' interface
contract TokenWallet {
    // State variable to hold the address of the token contract
    IToken private token;

    // Constructor to set the token contract address
    constructor(address _tokenAddress) {
        token = IToken(_tokenAddress);
    }

    // Function to check the balance of the wallet for the specific token
    function checkBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    // Function to transfer tokens from this wallet to another address
    function transferTokens(address to, uint256 amount) public returns (bool) {
        return token.transfer(to, amount);
    }

    // Function to approve tokens to another address
    function approveTokens(address spender, uint256 amount) public returns (bool) {
        return token.approve(spender, amount);
    }
}

// This example shows how to define and interact with interfaces.
// It includes a contract 'TokenWallet' that uses an interface 'IToken' to interact with a token contract.
// The interface defines standard token functions, allowing 'TokenWallet' to interact with any contract that implements 'IToken'.
