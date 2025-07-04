// SPDX-License-Identifier: MIT
pragma solidity 0.8.18; //solidity versions

contract SimpleStorage{
    // Types: bool, uint, int, address, byte, string
    //defaulted to storage
    uint256 myFaviouriteNumber ;

    struct Person{
        uint256 favouriteNumber;
        string name;
    }

    //Public keyword use to make it visible in contract it is defaulted to internal
    Person[] public listofPeople;

    mapping(string => uint256) public nameToFavouriteNumber;

    function store(uint256 _favouriteNumber)public{
        myFaviouriteNumber = _favouriteNumber;    
        }

    // view  is to retrival function a funtion can not change state
    function retrive()public view returns(uint256){
        return myFaviouriteNumber;
    }

    // memory, callback, storage
    function addPerson(string memory _name, uint256 _favouriteNumber)public{
        listofPeople.push();
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}




