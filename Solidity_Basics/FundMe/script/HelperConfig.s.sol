//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from "../test/mock/MockV3Aggregator.sol";

contract HelperConfig is Script{

    constructor() {
       if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaConfig();
        } else if(block.chainid == 1){
            activeNetworkConfig = getMainnetConfig();
        } else {
            activeNetworkConfig = getLocalConfig();
        }
       } // This constructor is intentionally left empty.
        // It is used to initialize the script environment.
    

    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig{
        address priceFeed;
    }

    function getSepoliaConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
    }

    function getMainnetConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            priceFeed: 0x3886BA987236181D98F2401c507Fb8BeA7871dF2
        });
    }

    function getLocalConfig() public  returns (NetworkConfig memory) {
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(8, 2000e8);
        vm.stopBroadcast();

        NetworkConfig memory AnvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return AnvilConfig;
    }
}