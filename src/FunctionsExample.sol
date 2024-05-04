// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract FunctionExamples {
    // Return multiple values
    function returnMultiple() public pure returns (uint256, bool, uint256) {
        return (1, true, 2);
    }

    // Named return values
    function namedReturn() public pure returns (uint256 x, bool y, uint256 z) {
        x = 1;
        y = true;
        z = 2;
        // No need to use return statement when variables are named
    }

    // Destructuring assignments from returned values
    function destructuringAssignments() public pure returns (uint256, bool, uint256, uint256, uint256) {
        (uint256 a, bool b, uint256 c) = returnMultiple();
        (uint256 x,, uint256 y) = (4, 5, 6);  // Skipping the middle value
        return (a, b, c, x, y);
    }

    // Working with arrays as function inputs and outputs
    uint256[] public numbers;

    function arrayInput(uint256[] memory arr) public {
        numbers = arr;
    }

    function arrayOutput() public view returns (uint256[] memory) {
        return numbers;
    }
}

contract AdvancedParameters {
    function functionWithMultipleInputs(
        uint256 x,
        uint256 y,
        uint256 z,
        address addr,
        bool flag,
        string memory str
    ) public pure returns (uint256) {
        return x + y + z;  // Just an example computation
    }

    function callFunction() external pure returns (uint256) {
        // Calling with positional arguments
        return functionWithMultipleInputs(1, 2, 3, address(0), true, "example");
    }

    function callFunctionWithKeyValue() external pure returns (uint256) {
        // Calling with key-value mapping
        return functionWithMultipleInputs({
            x: 1,
            y: 2,
            z: 3,
            addr: address(0),
            flag: true,
            str: "example"
        });
    }
}