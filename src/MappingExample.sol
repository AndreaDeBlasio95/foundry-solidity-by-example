// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract MappingExample {
      // Mappinng from address to uint
      mapping(address => uint256) public myMap;

      function get(address _addr) public view returns(uint256){
            // Mapping always returns a value
            // If the value was never set, it will return the default value
            return myMap[_addr];
      }

      function set(address _addr, uint256 _value) public {
            // Update the value at this address
            myMap[_addr] = _value;
      }

      function remove(address _addr) public {
            // Reset the value to the default value
            delete myMap[_addr];
      }
}
contract NestedMappingExample {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr1, uint256 _value) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_value];
    }

    function set(address _addr1, uint256 _value, bool _boolValue) public {
        nested[_addr1][_value] = _boolValue;
    }

    function remove(address _addr1, uint256 _value) public {
        delete nested[_addr1][_value];
    }
}