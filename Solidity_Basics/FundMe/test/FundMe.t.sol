//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Fundme} from "../src/FundMe.sol";
import {Test, console} from "../lib/forge-std/src/Test.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";


contract FundMetest is Test{
    Fundme fundme;

    function setUp() external {
        // DeployFundMe deployfundme = new DeployFundMe();
        // fundme = deployfundme.run();      
        fundme = new Fundme();
    }

    function testMinimumISDisOne() public view{
        assertEq(fundme.MINIMUM_ISD(), 1e18/80);
    }

    function  testOwnerIsMsgSender() public view {
        assertEq(fundme.i_owner(), address(this));
    }

    

}
