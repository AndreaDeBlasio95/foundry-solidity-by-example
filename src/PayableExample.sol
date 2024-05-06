// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// A simple crowdfunding contract where users can donate Ether.
contract Crowdfunding {
    // Record of the total amount of Ether donated
    uint public totalDonations;

    // Record of Ether donated per address
    mapping(address => uint) public donations;

    // Event to emit when a donation is received
    event DonationReceived(address donor, uint amount);

    // Function to donate to the crowdfunding campaign
    // Marked as `payable` to accept Ether
    function donate() public payable {
        require(msg.value > 0, "You need to send some Ether");

        donations[msg.sender] += msg.value;
        totalDonations += msg.value;

        emit DonationReceived(msg.sender, msg.value);
    }

    // Function to withdraw the donations
    // Only the owner (deployer) of the contract can call this function
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdraw() public {
        require(msg.sender == owner, "You are not the owner");

        payable(owner).transfer(address(this).balance);
    }

    // Fallback function to accept Ether sent directly to the contract's address
    fallback() external payable {
        donate();
    }

    // Receive function for plain Ether transactions
    receive() external payable {
        emit DonationReceived(msg.sender, msg.value);
    }
}
