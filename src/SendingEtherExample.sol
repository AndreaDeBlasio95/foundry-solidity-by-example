// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

// Contract to receive Ether
contract ReceiveEther {
    /*
    Decision Tree:
           Sending Ether
               |
         msg.data is empty?
              / \
            yes  no
            /       \
    receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Receives Ether only if msg.data is empty
    receive() external payable {}

    // Called when msg.data isn't empty or no receive function exists
    fallback() external payable {}

    // Get the balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

// Contract to send Ether
contract SendEther {
    // Using `transfer` (not recommended)
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    // Using `send` (not recommended)
    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    // Using `call` (recommended)
    function sendViaCall(address payable _to) public payable {
        // Returns a boolean indicating success or failure and returned data
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
