// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AbiDecode {
    // Struct to demonstrate complex data encoding/decoding
    struct MyStruct {
        string name;
        uint256[2] nums;
    }

    // Encode data into a byte array using `abi.encode`
    function encode(uint256 x, address addr, uint256[] calldata arr, MyStruct calldata myStruct)
        external
        pure
        returns (bytes memory)
    {
        return abi.encode(x, addr, arr, myStruct);
    }

    // Decode data back into structured types
    function decode(bytes calldata data)
        external
        pure
        returns (uint256 x, address addr, uint256[] memory arr, MyStruct memory myStruct)
    {
        // Decode the byte data using the correct types
        (x, addr, arr, myStruct) = abi.decode(data, (uint256, address, uint256[], MyStruct));
    }

    // Additional Encoding Functions
    function encodeWithSelector(uint256 x, address addr, uint256[] calldata arr, MyStruct calldata myStruct)
        external
        pure
        returns (bytes memory)
    {
        return abi.encodeWithSelector(this.decode.selector, x, addr, arr, myStruct);
    }

    function encodeWithSignature(uint256 x, address addr, uint256[] calldata arr, MyStruct calldata myStruct)
        external
        pure
        returns (bytes memory)
    {
        return
            abi.encodeWithSignature("decode((uint256,address,uint256[],(string,uint256[2])))", x, addr, arr, myStruct);
    }

    // Test decoding process to ensure correctness
    function testDecoding()
        external
        pure
        returns (uint256 x, address addr, uint256[] memory arr, MyStruct memory myStruct)
    {
        uint256[] memory array = new uint256[](3);
        array[0] = 1;
        array[1] = 2;
        array[2] = 3;

        uint256[2] memory nums = [uint256(1), uint256(2)];
        MyStruct memory myStructInput = MyStruct("TestStruct", nums);
        bytes memory encodedData = abi.encode(42, address(0x123), array, myStructInput);

        return abi.decode(encodedData, (uint256, address, uint256[], MyStruct));
    }
}
