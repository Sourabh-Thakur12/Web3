//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Fundme} from "../src/FundMe.sol";
import {Test, console} from "../lib/forge-std/src/Test.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";


contract FundMetest is Test{
    Fundme fundme;

    address public  USER  = makeAddr("User");
    uint256 constant STARTING_VALUE = 10e18;
    uint256 constant SEND_VALUE = 0.1 ether;

    function setUp() external {
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();      
        vm.deal(USER, STARTING_VALUE);
        // fundme = new Fundme();
    }

    function testMinimumISDisOne() public view{
        assertEq(fundme.MINIMUM_ISD(), 1e18/80);
    }

    function  testOwnerIsMsgSender() public view {
        assertEq(fundme.getOwner(), msg.sender);
    }

    function test_RevertWhen_NotEnoughEth() public {
        vm.expectRevert();
        fundme.fund();

    }

    function testFundersAddedToDataStructure() public{
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundme.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddFunderToArrayFunders() public{
        vm .prank(USER);
        fundme.fund{value: SEND_VALUE}();

        address funder = fundme.getFunder(0);
        assertEq(funder, USER); 
    }

    function testOnlyOwnerCanWithdraw() public funded{
        vm.prank(USER);
        vm.expectRevert("Must be owner");
        fundme.withdraw();
    }

    function testWithdrawWithaSingleUser() public funded{
        // Arrange
        uint256 startingOwnerBalance = fundme.getOwner().balance;
        uint256 startingFundMebalance =  address(fundme).balance;

        // Act
        vm.prank(fundme.getOwner());
        fundme.withdraw();


        // Assert
        uint256 endingOwnerbalance = fundme.getOwner().balance;
        uint256 endingFundMeBalance = address(fundme).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMebalance + startingOwnerBalance, endingOwnerbalance);
    }

    function testWithdrawFromMultipleUsers() public funded{
        // Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;

        // Act
        for(uint160 i = startingFunderIndex; i < numberOfFunders; i++){
            hoax(address(i), SEND_VALUE);
            fundme.fund{value: SEND_VALUE}();
        }

        uint256 startingOwnerBalance = fundme.getOwner().balance;
        uint256 startingFundMebalance =  address(fundme).balance;

        vm.prank(fundme.getOwner());
        fundme.withdraw();

        // Assert
        uint256 endingOwnerbalance = fundme.getOwner().balance;
        uint256 endingFundMeBalance = address(fundme).balance;

        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMebalance + startingOwnerBalance, endingOwnerbalance);
        
    }
    modifier funded(){
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        _;
    }

    
}
