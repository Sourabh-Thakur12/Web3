//Get funds from users
//withdraw funds
//set a minimum funding value in inr

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumISD = 1e18/80;
    address[] public funders;
    mapping (address funder => uint256 amountFunded) addressToamountfunded;
    function fund() public payable{
        // alllow user to send
        // have a minimum inr sent
        
        //send eth to this account
        require(getConversionRate(msg.value) >= minimumISD, "minimum requiremnet not reached"); //global variable 
        funders.push(msg.sender);
        addressToamountfunded[msg.sender] = addressToamountfunded[msg.sender] + msg.value; 

        // if txn reverts it  undo actions that has been done, send remaing gas back

    }

    // function withdraw() public{}

    function getPrice() public view returns (uint256){
        //usd/eth address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
         AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
         (, int256 price,,,) = priceFeed.latestRoundData();
         uint256 usd_1 = uint256(price * 1e10);
         return usd_1;
    }

    function getConversionRate(uint256 _amountEth ) public view returns(uint256){
        uint ethPrice = getPrice();
        uint ethAmountinUsd = (ethPrice * _amountEth)/ 1e18;
        return ethAmountinUsd;
    }
}