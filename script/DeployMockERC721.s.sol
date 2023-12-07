// SPDX-License-Identifier: MIT

// forge script script/DeployMockERC721.s.sol --rpc-url https://rpc-mumbai.maticvigil.com/ --broadcast --private-key PRIVATEKEY --etherscan-api-key KEY --verify
pragma solidity 0.8.20;

import {Script} from "lib/openzeppelin-contracts/lib/forge-std/src/Script.sol";
import {MockERC721} from "../src/MockERC721.sol";

contract DeployMockERC721 is Script {
    function run() external returns (MockERC721) {
        vm.startBroadcast();
        MockERC721 mockERC721 = new MockERC721();
        vm.stopBroadcast();
        return mockERC721;
    }
}
