// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract MockERC721 is ERC721 {

    uint256 tokenId;
    event NFTMinted(address user, uint256 tokenId);

    constructor() ERC721("MockERC721", "M721") {

    }

    function mintNFT() external {
        tokenId++;
        _safeMint(msg.sender, tokenId - 1);
        emit NFTMinted(msg.sender, tokenId - 1);
    }
}