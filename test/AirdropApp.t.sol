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

    address coldWallet = 0xC5b9C0549136A7eC4a2270f56afbC29002223F51; // Cold Wallet: wallet that will mint and contain the ERC721 token
    address hotWallet = 0xe371cDd686341baDbE337D21c53fA51Db505e361; // Wallet that is going to be used as hot wallet 
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

    function testHotWalletCanNotClaimWithoutBeingDelegated() public {
        vm.prank(hotWallet);
        vm.expectRevert();
        airdropApp.claimAirdrop();
    }

    function testColdWalletClaimAirdropCorrectly() public {
        vm.prank(coldWallet);
        airdropApp.claimAirdrop();
        assert(airdropApp.balanceOf(coldWallet) == aidropTokenAmount);
    }

    function testHotWalletClaimAirdropAfterBeingDelegatedCorrectly() public {
        vm.prank(coldWallet);

        delegationIndexer.ERC721Delegation(hotWallet, address(mockERC721), tokenId, true);
        vm.stopPrank();

        vm.prank(hotWallet);
        airdropApp.claimAirdrop();
        assert(airdropApp.balanceOf(hotWallet) == aidropTokenAmount);
    }


}
