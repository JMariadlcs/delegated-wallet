// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "src/DelegationIndexer.sol";

contract TestDelegationIndex is Test {
    DelegationIndexer public delegationIndexer;

    address coldWallet = 0xC5b9C0549136A7eC4a2270f56afbC29002223F51; // Cold Wallet: wallet that contains the ERC721 tokens
    address hotWallet = 0xe371cDd686341baDbE337D21c53fA51Db505e361; // Wallet that is going to be used as hot wallet 
    address ERC721ContractAddress = 0x3768a0c3d522125f828a3E9F5cA225E4F63fFDb8; // Invented
    uint32 tokenId = 0;

    function setUp() public {
        delegationIndexer = new DelegationIndexer();
    }

    function testDelegationIsNotActive() public view {
        bool delegationIsActive = delegationIndexer.checkERC721Delegation(coldWallet, hotWallet, ERC721ContractAddress, tokenId);
        assert(delegationIsActive == false);
    }

    function testAddERC721Delegation() public {
        vm.prank(coldWallet);
        bytes32 ERC721DelegationHash = delegationIndexer.ERC721Delegation(hotWallet, ERC721ContractAddress, tokenId, true);
        bool delegationIsActive = delegationIndexer.ERC721Delegations(coldWallet, ERC721DelegationHash);
        assert(delegationIsActive == true);
    }

    function testCheckAddedERC721Delegation() public {
        vm.prank(coldWallet);
        delegationIndexer.ERC721Delegation(hotWallet, ERC721ContractAddress, tokenId, true);
        bool delegationIsActive = delegationIndexer.checkERC721Delegation(coldWallet, hotWallet, ERC721ContractAddress, tokenId);
        assert(delegationIsActive == true);
    }

   function testRevokeERC721Delegation() public {
        vm.prank(coldWallet);
        delegationIndexer.ERC721Delegation(hotWallet, ERC721ContractAddress, tokenId, true);
        bool delegationIsActive = delegationIndexer.checkERC721Delegation(coldWallet, hotWallet, ERC721ContractAddress, tokenId);
        assert(delegationIsActive == true);

        vm.prank(coldWallet);
        delegationIndexer.ERC721Delegation(hotWallet, ERC721ContractAddress, tokenId, false);
        delegationIsActive = delegationIndexer.checkERC721Delegation(coldWallet, hotWallet, ERC721ContractAddress, tokenId);
        assert(delegationIsActive == false);
    }

}
