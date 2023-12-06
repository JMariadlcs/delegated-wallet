// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "./interfaces/IDelegationIndexer.sol";

error NotElegible();

contract AirdropApp is ERC20 {
    address delegationIndexerAddress;
    address ERC721ContractAddress;
    uint256 tokenId;
    uint256 airdropTokenAmount;

    event AirdropClaimed(address receiver);

    constructor(
        address _delegationIndexerAddress,
        address _ERC721ContractAddress,
        uint256 _tokenId,
        uint256 _aidropTokenAmount
    ) ERC20("AirdropApp", "ADRP") {
        delegationIndexerAddress = _delegationIndexerAddress;
        ERC721ContractAddress = _ERC721ContractAddress;
        tokenId = _tokenId;
        airdropTokenAmount = _aidropTokenAmount;
    }

    function claimAirdrop() external {
        address ERC721Owner = ERC721(ERC721ContractAddress).ownerOf(tokenId);
        if (
            msg.sender != ERC721Owner ||
            !IDelegationIndexer(delegationIndexerAddress).checkERC721Delegation(
                ERC721Owner,
                msg.sender,
                ERC721ContractAddress,
                tokenId
            )
        ) revert NotElegible();

        _mint(msg.sender, airdropTokenAmount);
    }
}
