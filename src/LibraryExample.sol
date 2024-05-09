// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Library with an internal function (embedded)
library Math {
    // Internal function for computing square root
    function sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // Default value of z is 0 if y == 0
    }
}

contract TestMath {
    // Test function calling the Math library
    function testSquareRoot(uint256 x) public pure returns (uint256) {
        return Math.sqrt(x);
    }
}

// Library with a public function (linked)
library Array {
    // Public function to remove an element at a specific index
    function remove(uint256[] storage arr, uint256 index) public {
        require(arr.length > 0, "Cannot remove from an empty array");
        require(index < arr.length, "Index out of bounds");

        // Replace the element to be removed with the last element
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}

contract TestArray {
    using Array for uint256[];

    uint256[] public arr;

    function testArrayRemove() public {
        // Initialize the array
        for (uint256 i = 0; i < 3; i++) {
            arr.push(i);
        }

        // Remove the second element
        arr.remove(1);

        // Validate the results
        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
    }
}
