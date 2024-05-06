// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract VisibilityExample {
    // State variable examples
    int public publicVar = 10;      // Accessible by anyone.
    int private privateVar = 20;    // Accessible only within this contract.
    int internal internalVar = 30;  // Accessible within the contract and derived ones.

    // Public function: Accessible from anywhere.
    function publicFunction() public view returns(int) {
        return publicVar;
    }

    // Private function: Accessible only within this contract.
    function privateFunction() private view returns(int) {
        return privateVar;
    }

    // Internal function: Accessible within this contract and derived ones.
    function internalFunction() internal view returns(int) {
        return internalVar;
    }

    // External function: Can only be called from outside the contract.
    function externalFunction() external pure returns(string memory) {
        return "Only callable externally";
    }

    // Function to access private function
    function testPrivateFunction() public view returns(int) {
        return privateFunction();
    }
}

// Derived contract to demonstrate internal visibility
contract DerivedVisibility is VisibilityExample {
    // Access internal function from parent contract
    function testInternalFunction() public view returns(int) {
        return internalFunction();
    }
}
