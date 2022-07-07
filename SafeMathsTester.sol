pragma solidity ^0.8.0;

contract SafeMathsTester{

    uint8 public bigNumber = 255;//The biggest Number Stored in uint8 is 255

    function add() public
    {
       unchecked{bigNumber = bigNumber + 1;}
    }

}
