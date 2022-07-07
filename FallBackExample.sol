pragma solidity ^0.8.7;

contract FallbackExample
{
    uint256 public result;
    //if there is no data in call data function recieve is called by the blockchain
    receive() external payable
    {
        result = 1;
    }
    //if there is data in call data function fallback is called by the blockchain
    fallback() external payable
    {
        result = 2;
    }
    /*
        Ether Is Send To Contract
        Is msg.data empty?
              /   \
            yes    No
            /        \
          receive()? fallback();
           /   \
        yes    NO
        /       \
    recieve()    fallback();
    */
}
