// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IDelegationIndexer {
    /** 
     * @notice function for delegating an ERC721 token
     * @param to HotWallet address to be delegated
     * @param contractAddress address of the ERC721 delegated
     * @param tokenId Id of the ERC721 token delegated
     * @param activeDelegation trigger for active/revoke delegation
     * @dev function returns the delegation hash generated (bytes32 type)
     */
    function ERC721Delegation(address to, address contractAddress, uint32 tokenId, bool activeDelegation) external returns (bytes32);

    /** 
     * @notice function for checking if an ERC721 token delegation is active
     * @param from ColdWallet address of the wallet that contains the ERC721 token
     * @param to HotWallet address to be delegated
     * @param contractAddress address of the ERC721 delegated
     * @param tokenId Id of the ERC721 token delegated
     * @dev function returns a boolean indicating if the delegation is active or not
     */
    function checkERC721Delegation(address from, address to, address contractAddress, uint32 tokenId) external view returns(bool);
}