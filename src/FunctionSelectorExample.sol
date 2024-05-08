// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IToken {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract FunctionSelector {
    /*
    Function selectors:
    "transfer(address,uint256)" -> 0xa9059cbb
    "transferFrom(address,address,uint256)" -> 0x23b872dd
    */

    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

contract Caller {
    event Response(bool success, bytes data);

    // Precomputed selectors for commonly used functions
    bytes4 private constant TRANSFER_SELECTOR = 0xa9059cbb; // "transfer(address,uint256)"
    bytes4 private constant TRANSFER_FROM_SELECTOR = 0x23b872dd; // "transferFrom(address,address,uint256)"

    // Function to call the "transfer" function using the selector
    function callTransfer(address _token, address _to, uint256 _amount) public {
        (bool success, bytes memory data) = _token.call(abi.encodeWithSelector(TRANSFER_SELECTOR, _to, _amount));
        require(success, "Transfer failed");
        emit Response(success, data);
    }

    // Function to call the "transferFrom" function using the selector
    function callTransferFrom(address _token, address _from, address _to, uint256 _amount) public {
        (bool success, bytes memory data) =
            _token.call(abi.encodeWithSelector(TRANSFER_FROM_SELECTOR, _from, _to, _amount));
        require(success, "TransferFrom failed");
        emit Response(success, data);
    }

    // General function to compute and call any function using `getSelector`
    function callFunction(address _contract, string calldata _signature, bytes calldata _args) public {
        bytes4 selector = bytes4(keccak256(bytes(_signature)));
        (bool success, bytes memory data) = _contract.call(abi.encodePacked(selector, _args));
        require(success, "Function call failed");
        emit Response(success, data);
    }
}
