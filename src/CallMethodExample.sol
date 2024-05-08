// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ReceiverCallMethodExample {
    event Received(address indexed caller, uint256 amount, string message);

    // Fallback function to handle unknown function calls and direct Ether transfers.
    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    // Function to receive Ether and emit a message
    function foo(string memory _message, uint256 _x) public payable returns (uint256) {
        emit Received(msg.sender, msg.value, _message);
        return _x + 1;
    }

    // Receive ether function
    // This function is called when the contract receives Ether without data
    receive() external payable {
        emit Received(msg.sender, msg.value, "Receive was called");
    }
}

interface IReceiver {
    function foo(string memory _message, uint256 _x) external payable returns (uint256);
}

contract CallerCallMethodExample {
    event Response(bool success, bytes data);

    // Improved function to call `foo` using an interface
    function testCallFoo(address payable _addr) public payable {
        IReceiver receiver = IReceiver(_addr);
        try receiver.foo{value: msg.value}("call foo", 123) returns (uint256 result) {
            emit Response(true, abi.encode(result));
        } catch (bytes memory errorData) {
            emit Response(false, errorData);
        }
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{value: msg.value}(abi.encodeWithSignature("doesNotExist()"));

        emit Response(success, data);
    }
}
