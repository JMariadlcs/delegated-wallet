// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IDelegationIndexer {
    function ERC721Delegation(address to, address contractAddress, uint256 tokenId, bool activeDelegation) external returns (bytes32);
    function checkERC721Delegation(address from, address to, address contractAddress, uint256 tokenId) external view returns(bool);
}