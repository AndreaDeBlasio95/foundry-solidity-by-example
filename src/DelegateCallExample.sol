// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Deploy this contract first
contract B {
    // Must have the same storage layout as contract A
    uint256 public num;
    address public sender;
    uint256 public value;

    // Function that modifies B's state variables
    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint256 public num;
    address public sender;
    uint256 public value;

    // Function that delegates execution to B's setVars function
    function setVars(address _contract, uint256 _num) public payable {
        // Ensure the contract address is valid
        require(_contract != address(0), "Invalid contract address");

        // Delegate call to the setVars function of contract B
        (bool success,) = _contract.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        require(success, "Delegatecall failed");
    }
}
