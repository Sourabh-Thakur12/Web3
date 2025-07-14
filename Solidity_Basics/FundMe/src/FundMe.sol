//Get funds from users
//withdraw funds
//set a minimum funding value in inr

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contract/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Fundme{
    // connecting PriceConverter to uint256 datatype
    using PriceConverter for uint256; 

    uint256 public constant MINIMUM_ISD = 1e18/80;
    address[] public funders;
    mapping (address funder => uint256 amountFunded) addressToamountfunded;
    AggregatorV3Interface private s_priceFeed;
    
    address private immutable i_owner;
    constructor(address _priceFeedAddress) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(_priceFeedAddress);
    }
    
    function fund() public payable{
        // alllow user to send
        // have a minimum inr sent
        
        //send eth to this account
        uint256 LibraryFunction_Conversionrate = msg.value.getConversionRate(s_priceFeed); // we linked uint256 to PriceConverter and msg.value is a uint256 type so it can access the PriceConverter contract
        require(LibraryFunction_Conversionrate >= MINIMUM_ISD, "minimum requiremnet not reached"); //global variable 
        funders.push(msg.sender);
        addressToamountfunded[msg.sender] = addressToamountfunded[msg.sender] + msg.value; 

        // if txn reverts it  undo actions that has been done, send remaing gas back

    }

    function cheaperWithdraw() public onlyOwner{
        uint256 fundersCount = funders.length;
        for(uint256 funderIndex = 0; funderIndex < fundersCount; funderIndex++){
             address funder = funders[funderIndex];
            addressToamountfunded[funder] = 0;
        }
    }
    function withdraw() public onlyOwner{

        // for loop
        for(uint256 funderIndex = 0; funderIndex< funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToamountfunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // withraw the fund 
        // usinng call
        (bool callSucesss,)  = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucesss, "Call Failed");
    }

    modifier  onlyOwner(){
        require(msg.sender == i_owner, "Must be owner");
        _; // "_" is placeholder for everything else
    }

    // getters
    function getAddressToAmountFunded(address funder) external view returns(uint256){
        return addressToamountfunded[funder];
    }

    function getFunder(uint256 index) external view returns(address){
        return funders[index];
    }

    function getOwner() external view returns(address){
        return i_owner;
    }

   
}