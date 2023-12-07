// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract DelegationIndexer {

    /// @notice Struct for ERC 721 token delegations
    struct ERC721DelegationStruct {
        address from;
        address to;
        address contractAddress;
        uint256 tokenId;
    }

    /// @notice Records if a delegationHash from a delegator is active or not delegator => delegationHash => isActive
    mapping(address => mapping(bytes32 => bool)) public ERC721Delegations;

    event ERC721Delegated(address indexed from, address indexed to, address indexed contractAddress, uint256 tokenId);

    function ERC721Delegation(address to, address contractAddress, uint256 tokenId, bool activeDelegation) external returns (bytes32 ERC721DelegationHash) {
        ERC721DelegationHash = keccak256(abi.encode(msg.sender, to, contractAddress, tokenId));

        if (activeDelegation) ERC721Delegations[msg.sender][ERC721DelegationHash] = true;
        else ERC721Delegations[msg.sender][ERC721DelegationHash] = false;
    }

    function checkERC721Delegation(address from, address to, address contractAddress, uint256 tokenId) external view returns(bool delegationActive) {
        bytes32 hash =  keccak256(abi.encode(from, to, contractAddress, tokenId));
        delegationActive = ERC721Delegations[from][hash];
    }

}