// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

/*          Modifiers
Are reusable pieces of code that can alter the behavior of functions in a smart contract. They are used to change how functions behave by running checks or logic before and/or after the function executes. Modifiers can be used for various purposes, such as:
- Restricting access: Ensuring only certain users can call a function.
- Validating inputs: Checking conditions on function arguments before execution.
*/

contract FunctionModifierExample {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}
