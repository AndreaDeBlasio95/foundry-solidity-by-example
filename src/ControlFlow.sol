// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract ControlFlow {
    // if, else if, else
    function foo(uint256 _x) public pure returns (uint256) {
        if (_x < 10) {
            return 0;
        } else if (_x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint256 _x) public pure returns (uint256) {
        return _x < 10 ? 1 : 2;
    }
    // ------------------------------

    // for loop
    function forLoop() public {
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip this, go to the next iteration
                continue;
            }
            if (i == 5) {
                // Exit the loop
                break;
            }
        }
    }
    // ------------------------------

    // while loop
    function whileLoop() public {
        uint256 i = 0;
        while (i < 10) {
            i++;
        }
    }
    // ------------------------------
}
