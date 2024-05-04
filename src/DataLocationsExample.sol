// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

/*            STORAGE
storage holds state variables that persist between function calls and transactions. It's the most expensive in terms of gas cost when it comes to writing, but reading from storage is relatively cheap.
*/
contract StorageExample {
    uint256 public count;  // This is a state variable stored in 'storage'

    function setCount(uint256 _count) public {
        count = _count;  // Writing to storage
    }
}
// - Minimize the number of state modifications to save gas.
// - Use smaller data types where possible, as Solidity packs multiple small-sized state variables into a single storage slot (32 bytes).


/*            MEMORY
memory data location is temporary and exists only during the execution of a function. It’s cheaper to use compared to storage but more expensive than calldata in terms of gas when it comes to function inputs.
*/
contract MemoryExample {
    function calculateSum(uint[] memory _numbers) public pure returns (uint sum) {
        for (uint i = 0; i < _numbers.length; i++) {
            sum += _numbers[i];  // Data is accessed from memory
        }
    }
}
// - Use `memory` for temporary variables and intermediate calculations within functions.
// - When working with complex data in functions that don't modify state, use `memory` arrays.


/*           CALLDATA
calldata is a non-modifiable, non-persistent area where function arguments are stored and behaves very much like memory. It’s the cheapest option in terms of gas, especially effective for external function calls.
*/
contract CalldataExample {
    function sumElements(uint[] calldata _numbers) external pure returns (uint sum) {
        for (uint i = 0; i < _numbers.length; i++) {
            sum += _numbers[i];  // Data is accessed from calldata
        }
    }
}
// - Use `calldata` for function parameters in `external` functions to save gas.
// - Consider `calldata` for arrays or complex types passed into the function that do not need to be modified.
