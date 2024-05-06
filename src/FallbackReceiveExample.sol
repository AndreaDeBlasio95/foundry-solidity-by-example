// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EtherReceiver {
    event Received(address, uint);
    event FallbackCalled(address, uint);

    // Fallback function must be declared as external.
    fallback() external payable {
        // Emit an event whenever fallback is called
        emit FallbackCalled(msg.sender, msg.value);
    }

    // Receive function must be declared as external and payable.
    receive() external payable {
        // Emit an event whenever Ether is received
        emit Received(msg.sender, msg.value);
    }
}

// This contract demonstrates the use of fallback and receive functions.
// - The `receive()` function is optimized for cases where the contract is sent Ether with no data.
// - The `fallback()` function acts as a catch-all for any other transaction not matching a function or in the absence of the `receive()` function.
