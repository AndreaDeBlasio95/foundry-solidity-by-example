// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Callee {
    uint256 public x;
    uint256 public value;

    // Set value of `x`
    function setX(uint256 _x) public returns (uint256) {
        x = _x;
        return x;
    }

    // Set value of `x` and accept Ether
    function setXandSendEther(uint256 _x) public payable returns (uint256, uint256) {
        x = _x;
        value = msg.value;
        return (x, value);
    }
}

contract Caller {
    // Call setX using a direct contract instance
    function setX(Callee _callee, uint256 _x) public {
        uint256 x = _callee.setX(_x);
    }

    // Call setX by casting an address to a Callee instance
    function setXFromAddress(address _addr, uint256 _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    // Call setXandSendEther with Ether
    function setXandSendEther(Callee _callee, uint256 _x) public payable {
        (uint256 x, uint256 value) = _callee.setXandSendEther{value: msg.value}(_x);
    }

    // Use low-level call to interact with another contract
    function lowLevelCallSetX(address _addr, uint256 _x) public returns (bool) {
        (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("setX(uint256)", _x));
        require(success, "Low-level call failed");
        return success;
    }
}
