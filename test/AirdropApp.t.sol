// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "src/AirdropApp.sol";
import "src/DelegationIndexer.sol";
import "src/MockERC721.sol";

contract TestAirdropApp is Test {
    MockERC721 public mockERC721;
    DelegationIndexer public delegationIndexer;
    AirdropApp public airdropApp;

    address coldWallet = 0xC5b9C0549136A7eC4a2270f56afbC29002223F51; // Cold Wallet: wallet that contains the ERC721 tokens
    address hotWallet = 0xe371cDd686341baDbE337D21c53fA51Db505e361; // Wallet that is going to be used as hot wallet 
    address ERC721ContractAddress = 0x3768a0c3d522125f828a3E9F5cA225E4F63fFDb8; // Invented
    uint256 aidropTokenAmount = 100e18;
    uint256 tokenId = 0;

    function setUp() public {
        mockERC721 = new MockERC721();
        delegationIndexer = new DelegationIndexer();
        airdropApp = new AirdropApp(address(delegationIndexer), address(mockERC721), tokenId, aidropTokenAmount);

        vm.prank(coldWallet);
        mockERC721.mintNFT(); // ColdWallet mints ERC721 and will never will transfered
    }

    function testColdWalletMintedERC721Correctly() public view {
        assert(mockERC721.ownerOf(0) == coldWallet);
    }

    function testColdWalletClaimAirdropCorrectly() public {
        vm.prank(coldWallet);
        airdropApp.claimAirdrop();
        assert(airdropApp.balanceOf(coldWallet) == aidropTokenAmount);
    }


}
