// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// library for the fund me which contains the calculations

import {AggregatorV3Interface} from "@chainlink/contract/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
     function getPrice() internal view returns (uint256){
        //usd/eth address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
         AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
         (, int256 price,,,) = priceFeed.latestRoundData();
         uint256 usd_1 = uint256(price * 1e10);
         return usd_1;
    }

    function getConversionRate(uint256 _amountEth ) internal view returns(uint256){
        uint ethPrice = getPrice();
        uint ethAmountinUsd = (ethPrice * _amountEth)/ 1e18;
        return ethAmountinUsd;
    }
}