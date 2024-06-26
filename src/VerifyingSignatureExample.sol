// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract VerifySignature {
    // Generate the hash of the original message
    function getMessageHash(address _to, uint256 _amount, string memory _message, uint256 _nonce)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }

    // Compute the Ethereum Signed Message Hash (ESMH) from the message hash
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\\x19Ethereum Signed Message:\\n32", _messageHash));
    }

    // Verify the signature by comparing the recovered signer with the expected signer
    function verify(
        address _signer,
        address _to,
        uint256 _amount,
        string memory _message,
        uint256 _nonce,
        bytes memory _signature
    ) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_to, _amount, _message, _nonce);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recoverSigner(ethSignedMessageHash, _signature) == _signer;
    }

    // Recover the signer's address from the Ethereum Signed Message Hash and the signature
    function recoverSigner(bytes32 _ethSignedMessageHash, bytes memory _signature) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    // Split a 65-byte signature into `r`, `s`, and `v` components
    function splitSignature(bytes memory sig) public pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "Invalid signature length");

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}
