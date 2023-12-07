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

    /// @notice Event emitted when someone delegates an ERC721 token
    event ERC721Delegated(address indexed from, address indexed to, address indexed contractAddress, uint256 tokenId);

    /** 
     * @notice function for delegating an ERC721 token
     * @param to HotWallet address to be delegated
     * @param contractAddress address of the ERC721 delegated
     * @param tokenId Id of the ERC721 token delegated
     * @param activeDelegation trigger for active/revoke delegation
     * @dev function returns the delegation hash generated (bytes32 type)
     */
    function ERC721Delegation(address to, address contractAddress, uint256 tokenId, bool activeDelegation) external returns (bytes32 ERC721DelegationHash) {
        ERC721DelegationHash = keccak256(abi.encode(msg.sender, to, contractAddress, tokenId));

        if (activeDelegation) ERC721Delegations[msg.sender][ERC721DelegationHash] = true;
        else ERC721Delegations[msg.sender][ERC721DelegationHash] = false;
    }

    /** 
     * @notice function for checking if an ERC721 token delegation is active
     * @param from ColdWallet address of the wallet that contains the ERC721 token
     * @param to HotWallet address to be delegated
     * @param contractAddress address of the ERC721 delegated
     * @param tokenId Id of the ERC721 token delegated
     * @dev function returns a boolean indicating if the delegation is active or not
     */
    function checkERC721Delegation(address from, address to, address contractAddress, uint256 tokenId) external view returns(bool delegationActive) {
        bytes32 hash =  keccak256(abi.encode(from, to, contractAddress, tokenId));
        delegationActive = ERC721Delegations[from][hash];
    }

}