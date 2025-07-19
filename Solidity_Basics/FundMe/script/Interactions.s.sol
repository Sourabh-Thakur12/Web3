// Fund
// Withdraw

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DeployFundMe} from "./DeployFundMe.s.sol";
import {Fundme} from "../src/FundMe.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract FundFundme is Script {
      uint256 constant SEND_VALUE = 0.1 ether;

      function fundFundMe(address mostRecentDeployed) public{
            vm.startBroadcast();
            Fundme(payable(mostRecentDeployed)).fund{value: SEND_VALUE}();
            vm.stopBroadcast();
            console.log("Fund Sent with %s", SEND_VALUE);
      }

   function run() external{
         address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("Fundme", block.chainid);

         vm.startBroadcast();
         fundFundMe(mostRecentDeployed);
         vm.stopBroadcast();
   }
}

contract WithdrawFundme is Script {
       uint256 constant SEND_VALUE = 0.1 ether;

      function withdrawFundMe(address mostRecentDeployed) public{
            // vm.deal(USER, STARTING_VALUE);
            vm.startBroadcast();
            Fundme(payable(mostRecentDeployed)).withdraw();
            vm.stopBroadcast();
            console.log("Fund Withdrawn with %s", SEND_VALUE);
      }

   function run() external{
         address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("Fundme", block.chainid);

         vm.startBroadcast();
         withdrawFundMe(mostRecentDeployed);
         vm.stopBroadcast();
   }    
}