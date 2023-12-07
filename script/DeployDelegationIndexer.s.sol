// SPDX-License-Identifier: MIT

// forge script script/DeployDelegationIndexer.s.sol --rpc-url https://rpc-mumbai.maticvigil.com/ --broadcast --private-key PRIVATEKEY --etherscan-api-key KEY --verify
pragma solidity 0.8.20;

import {Script} from "lib/openzeppelin-contracts/lib/forge-std/src/Script.sol";
import {DelegationIndexer} from "../src/DelegationIndexer.sol";

contract DeployDelegationIndexer is Script {
    function run() external returns (DelegationIndexer) {
        vm.startBroadcast();
        DelegationIndexer delegationIndexer = new DelegationIndexer();
        vm.stopBroadcast();
        return delegationIndexer;
    }
}