//SPDX-License-Identifier: MIT 
pragma solidity 0.8.19;

/**
 * @title A smart Raffle contract
 * @author Sourabh Thakur
 * @notice This contract is for creating a sample raffle
 * @dev This contract is a simple lottery system where users can enter the raffle by sending Ether
 */

 contract Raffle{
    // Errors
    error Raffle__SendMoreToEnterRaffle();

    // Events
    event RaffleEnter(address indexed player);

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    constructor(uint256 entranceFee){
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public {
       if(msg.value < i_entranceFee){
            revert Raffle__SendMoreToEnterRaffle();
       } 
    }

    function pickWinner() public {}
 }