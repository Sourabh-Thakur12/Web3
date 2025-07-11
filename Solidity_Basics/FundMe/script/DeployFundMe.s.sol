// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Fundme} from "../src/FundMe.sol";
import {Script} from "../lib/forge-std/src/Script.sol";

contract DeployFundMe is Script {
    function run() external {

        vm.startBroadcast();
        new Fundme();
        vm.stopBroadcast();
       
    }
}