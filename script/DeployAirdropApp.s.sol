// SPDX-License-Identifier: MIT

// forge script script/DeployAirdropApp.s.sol --rpc-url https://rpc-mumbai.maticvigil.com/ --broadcast --private-key PRIVATEKEY --etherscan-api-key KEY --verify
pragma solidity 0.8.20;

import {Script} from "lib/openzeppelin-contracts/lib/forge-std/src/Script.sol";
import {AirdropApp} from "../src/AirdropApp.sol";

contract DeployAirdropApp is Script {
    function run() external returns (AirdropApp) {
        vm.startBroadcast();

        address delegationIndexerAddress = 0x03FfF50ef7C829B1aF69dcaAd257bD9426897f41; // Deployed in Mumbai
        address mockERC721Address = 0x9Fd12DfDe6eF24fa793C699941363d8E61E4c983; // Deployed in Mumbai
        uint256 tokenId = 0;
        uint256 airdropTokenAmount = 100e18;
        AirdropApp airdropApp = new AirdropApp(delegationIndexerAddress, mockERC721Address, tokenId, airdropTokenAmount);
        vm.stopBroadcast();
        return airdropApp;
    }
}