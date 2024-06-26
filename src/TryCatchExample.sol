// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// External contract used for try/catch examples
contract Foo {
    address public owner;

    constructor(address _owner) {
        // Revert if _owner is an invalid address
        require(_owner != address(0), "Invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    // Function that can fail if x is zero
    function myFunc(uint256 x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "my func was called";
    }
}

contract Bar {
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;

    // Constructor to initialize an instance of Foo
    constructor() {
        // Initialize Foo with the message sender
        foo = new Foo(msg.sender);
    }

    // Example of try/catch with an external call
    // tryCatchExternalCall(0) => Log("external call failed")
    // tryCatchExternalCall(1) => Log("my func was called")
    function tryCatchExternalCall(uint256 _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch Error(string memory reason) {
            emit Log(reason);
        } catch {
            emit Log("external call failed");
        }
    }

    // Example of try/catch with contract creation
    // tryCatchNewContract(0x0000000000000000000000000000000000000000) => Log("Invalid address")
    // tryCatchNewContract(0x0000000000000000000000000000000000000001) => LogBytes("")
    // tryCatchNewContract(0x0000000000000000000000000000000000000002) => Log("Foo created")
    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns (Foo newFoo) {
            emit Log("Foo created");
        } catch Error(string memory reason) {
            // Catch errors due to revert/require statements
            emit Log(reason);
        } catch (bytes memory reason) {
            // Catch errors due to failing assert
            emit LogBytes(reason);
        }
    }
}
