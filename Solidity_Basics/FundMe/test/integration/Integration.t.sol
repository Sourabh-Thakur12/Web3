
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Fundme} from "../../src/FundMe.sol";
import {Test, console} from "../../lib/forge-std/src/Test.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundme, WithdrawFundme} from "../../script/Interactions.s.sol";


contract FundMetestIntegration is Test{
    Fundme fundme;

    address public  USER  = makeAddr("User");
    uint256 constant STARTING_VALUE = 10e18;
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant GAS_PRICE = 1e9; // 1 gwei
    function setUp() external {
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();
        vm.deal(USER, STARTING_VALUE);
        }

    function testUserCanFund() public{
            FundFundme fundFundme = new FundFundme();
            fundFundme.fundFundMe(address(fundme));

            WithdrawFundme withdrawFundme = new WithdrawFundme();
            withdrawFundme.withdrawFundMe(address(fundme));

            assert(address(fundme).balance == 0);
        }

}