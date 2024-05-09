/*
Explanation of Key Elements
1. hash Function: Demonstrates the hashing of mixed data types using `keccak256`.
2. collision Function:
    - Illustrates potential hash collisions with `abi.encodePacked`.
    - Example: `encodePacked("AAA", "BBB")` and `encodePacked("AA", "ABBB")` yield the same hash.
3. noCollision Function:
    - Uses `abi.encode` instead of `abi.encodePacked` to prevent hash collisions.
4. GuessTheMagicWord Contract:
    - Precomputes the Keccak-256 hash of "Solidity" as the answer.
    - `guess` function compares user input with the correct hash.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Demonstrates hashing and hash collisions
contract HashFunction {
    // Compute the Keccak-256 hash from various inputs
    function hash(string memory _text, uint256 _num, address _addr) public pure returns (bytes32) {
        // Compute hash using keccak256
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }

    // Example of potential hash collision using abi.encodePacked
    function collision(string memory _text, string memory _anotherText) public pure returns (bytes32) {
        // Hash collision can occur when multiple dynamic types are passed
        // Use abi.encode to avoid collision
        return keccak256(abi.encodePacked(_text, _anotherText));
    }

    // Prevent hash collision by using `abi.encode`
    function noCollision(string memory _text, string memory _anotherText) public pure returns (bytes32) {
        return keccak256(abi.encode(_text, _anotherText));
    }
}

// Guess the magic word using Keccak-256
contract GuessTheMagicWord {
    // Precomputed hash of the magic word "Solidity"
    bytes32 public answer = 0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;

    // Check if the guessed word matches the magic word
    function guess(string memory _word) public view returns (bool) {
        return keccak256(abi.encodePacked(_word)) == answer;
    }
}
