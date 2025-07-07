// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {SimpleStorage}from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage{ //addfivestorage inherits SimpleStorage
    // funtion overrides
    function store(uint256 _favouriteNumber)public override{
    myFaviouriteNumber = _favouriteNumber + 5;
    }
}
