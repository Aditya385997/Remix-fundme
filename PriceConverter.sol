//It is a smart contract which is also known as Library
//All Methods In Library Should be internal

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
library PriceConverter
{
     function getPrice() internal view returns(uint256){
        //The Data Would be Coming From External Sources Like ChainLink Also We Can Say That from different Contracts
        //So We Need Address and ABI - Applicaton Binary Interface Of That External Contract
        //Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        //ABI
        //To Bring Data There are no use of Api Chain link is used to bring external data to your smart contract
       
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //ETH In Terms Of USD
        //3000.00000000
        return uint256(price * 1e10); //1**10 = 10000000000
    }

    function getConversionRate(uint256 _ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSd = (ethPrice * _ethAmount)/1e18;
        return ethAmountInUSd;
    }   
}
