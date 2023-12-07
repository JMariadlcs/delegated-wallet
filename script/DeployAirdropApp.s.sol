// SPDX-License-Identifier: MIT

// forge script script/DeployAirdropApp.s.sol --rpc-url https://rpc-mumbai.maticvigil.com/ --broadcast --private-key PRIVATEKEY --etherscan-api-key KEY --verify
pragma solidity 0.8.20;

import {Script} from "lib/openzeppelin-contracts/lib/forge-std/src/Script.sol";
import {AirdropApp} from "../src/AirdropApp.sol";

contract DeployAirdropApp is Script {
    function run() external returns (AirdropApp) {
        vm.startBroadcast();

        address delegationIndexerAddress = 0x3D1733E1927aaAcA3711f8e3428767F4a2B71A6f; // Deployed in Mumbai
        address mockERC721Address = 0x77d4F25Cebf15472a7d0f68c8448C04DD095e44C; // Deployed in Mumbai
        uint256 tokenId = 0;
        uint256 airdropTokenAmount = 100e18;
        AirdropApp airdropApp = new AirdropApp(delegationIndexerAddress, mockERC721Address, tokenId, airdropTokenAmount);
        vm.stopBroadcast();
        return airdropApp;
    }
}