// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Fundme} from "../src/FundMe.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external  returns(Fundme){
        HelperConfig helperConfig = new HelperConfig();
        vm.startBroadcast();
        Fundme fundme = new Fundme(helperConfig.activeNetworkConfig());
        vm.stopBroadcast();
        return fundme;
    }
}