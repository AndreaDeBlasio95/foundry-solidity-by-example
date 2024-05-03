// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract VariablesContantsImmutableGas {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public immutable MY_UINT = 123;

    // State variables are stored on the Blockchain.
    string public text = "Hello World";
    uint256 public num = 123;

    // Ether units: wei, gwei, ether
    uint256 public oneWei = 1 wei; // 1 wei is the smallest unit of ether, is equal to 1
    uint256 public oneGwei = 1 gwei; // 1 gwei is equal to 1e9 wei
    uint256 public oneEther = 1 ether; // 1 ether is equal to 1e18 wei

    // gas variables
    uint256 public gasToSpendToFailTransaction = 0;

    constructor(uint256 _myUint) {
        // Immutable variables can be set only once
        MY_UINT = _myUint;
    }

    function doSomething() public {
        // Local variables are not saved on the blockchain.
        uint256 localVar = 456;

        // Some global variables
        uint256 timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // Address of the caller
    }

    // Using up all of the gas that you send causes your transaction to fail.
    // State changes are undone.
    // Gas spent are not refunded.
    function infiniteLoopThatSpendAllGas() public {
        while (true) {
            gasToSpendToFailTransaction += 1;
        }
    }
}
