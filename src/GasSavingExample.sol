// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Gas Golf
contract GasSavingExample {
    // Various gas optimization techniques
    // - Start: 50908 gas
    // - Calldata: 49163 gas
    // - Load state variables to memory: 48952 gas
    // - Short circuit: 48634 gas
    // - Loop increments (++i): 48244 gas
    // - Cache array length: 48209 gas
    // - Load array elements to memory: 48047 gas
    // - Uncheck i overflow/underflow: 47309 gas

    uint256 public total;

    // Optimized function to sum even numbers less than 99
    function sumIfEvenAndLessThan99(uint256[] calldata nums) external {
        uint256 _total = total; // Load state variable to memory
        uint256 len = nums.length; // Cache array length

        for (uint256 i = 0; i < len;) {
            uint256 num = nums[i]; // Cache array element
            if (num % 2 == 0 && num < 99) {
                // Short-circuit evaluation
                _total += num;
            }
            unchecked {
                ++i; // Use prefix increment and unchecked math
            }
        }

        total = _total; // Store result back to the state variable
    }
}

contract GasSavingNewPart {
    // 1. replacing memory with calldata
    function processData(uint256[] calldata nums) external pure returns (uint256) {
        uint256 sum;
        for (uint256 i = 0; i < nums.length; ++i) {
            sum += nums[i];
        }
        return sum;
    }

    // 2. Loading State Variables into memory:
    uint256 public stateVariable;

    function useStateVariable(uint256 input) external {
        uint256 localCopy = stateVariable; // Load into memory
        localCopy += input;
        stateVariable = localCopy; // Update state variable once
    }

    // 3. Replace for Loop i++ with ++i:
    function incrementExample() external pure {
        for (uint256 i = 0; i < 10; ++i) {
            // Use prefix increment (++i)
            uint256 x = i;
        }
    }

    // 4. Cache Array Elements:
    function cacheArrayElements(uint256[] calldata nums) external pure returns (uint256) {
        uint256 sum;
        for (uint256 i = 0; i < nums.length; ++i) {
            uint256 num = nums[i]; // Cache element
            sum += num;
        }
        return sum;
    }

    // 5. Cache Array Length:
    function cacheArrayLength(uint256[] calldata nums) external pure returns (uint256) {
        uint256 sum;
        uint256 length = nums.length; // Cache length
        for (uint256 i = 0; i < length; ++i) {
            sum += nums[i];
        }
        return sum;
    }

    // 6. Short Circuit Evaluation:
    function shortCircuit(uint256 num) external pure returns (bool) {
        // If `num` is even, further conditions are evaluated; otherwise, return false
        return num % 2 == 0 && num < 100;
    }

    // 7. Unchecked Math Operations:
    function uncheckedIncrement() external pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < 10;) {
            unchecked {
                ++i;
            }
            sum += i;
        }
        return sum;
    }

    // 8. Use fixed-size array to avoid dynamic array resizing
    bytes32 public fixedData = "Optimized";

    function useFixedSizeData(bytes32 data) external pure returns (bytes32) {
        return data;
    }
}
