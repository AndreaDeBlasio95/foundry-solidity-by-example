// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Interface defining an ERC20 transfer function
interface IERC20 {
    function transfer(address recipient, uint256 amount) external;
}

// Contract implementing an ERC20-like transfer function
contract Token {
    function transfer(address recipient, uint256 amount) external {}
}

contract AbiEncode {
    // Test generic contract call using `data`
    function test(address _contract, bytes calldata data) external {
        (bool ok,) = _contract.call(data);
        require(ok, "call failed");
    }

    // Encode function data using a string signature
    function encodeWithSignature(address to, uint256 amount) external pure returns (bytes memory) {
        // Note: Typo in signature won't be checked at compile-time
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    // Encode function data using a function selector
    function encodeWithSelector(address to, uint256 amount) external pure returns (bytes memory) {
        // Note: Incorrect types in parameters won't be checked at compile-time
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    // Encode function data using `abi.encodeCall` with compile-time checks
    function encodeCall(address to, uint256 amount) external pure returns (bytes memory) {
        // Any typos or incorrect types will trigger a compilation error
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }

    // New Function: Decode ABI-encoded data
    function decodeData(bytes calldata data) external pure returns (address to, uint256 amount) {
        // Decode the data using the signature format
        (to, amount) = abi.decode(data, (address, uint256));
    }

    // New Function: Test call via `encodeWithSignature`
    function testSignatureCall(address _contract, address to, uint256 amount) external {
        bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", to, amount);
        (bool ok,) = _contract.call(data);
        require(ok, "Signature call failed");
    }

    // New Function: Test call via `encodeWithSelector`
    function testSelectorCall(address _contract, address to, uint256 amount) external {
        bytes memory data = abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
        (bool ok,) = _contract.call(data);
        require(ok, "Selector call failed");
    }

    // New Function: Test call via `encodeCall`
    function testEncodeCall(address _contract, address to, uint256 amount) external {
        bytes memory data = abi.encodeCall(IERC20.transfer, (to, amount));
        (bool ok,) = _contract.call(data);
        require(ok, "EncodeCall failed");
    }
}
