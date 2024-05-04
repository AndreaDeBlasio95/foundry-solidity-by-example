// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

/*          Events
Events are a way for a contract to communicate that something happened on the blockchain to your app front-end. They are emitted by the contract and logged in the transaction's log. The log is stored on the blockchain and can be accessed later. Events are defined using the event keyword and are emitted using the emit keyword. Events are useful for:
- Listening for changes: You can listen for events emitted by a contract to update your app front-end.
- Debugging: You can use events to log information about the contract's state.
- Inter-contract communication: You can use events to communicate between contracts.
- User notifications: You can use events to notify users of important contract events.
- Data storage: You can use events to store data on the blockchain.
- Gas optimization: Events are cheaper than storage variables.
- History: Events are stored on the blockchain forever.
*/
contract EventExample {
    // Declare an event with up to three indexed parameters to enable efficient filtering.
    // `indexed` is used for parameters that you might need to filter by when watching for events.
    event Log(address indexed sender, string message);

    // A simpler event that doesn't require parameters or indexing.
    event AnotherLog();

    // Function to test emitting different events.
    function testEmitEvents() public {
        // Emitting an event with the sender's address and a message.
        emit Log(msg.sender, "Hello World!");

        // Emitting the same event type with a different message.
        emit Log(msg.sender, "Hello EVM!");

        // Emitting a simple event with no parameters.
        emit AnotherLog();
    }
}

