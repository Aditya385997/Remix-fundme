//Main Approach Is To Get Funds From The USer
//Withdraw Funds 
//Set Minimum funding value in USD

//This Contract Two Basic Function Get Funds And Withdraw To Methods Are Created

//In Fund We are Taking Some ehterum from the user and than we are storing the users address and amount funded in array
//While withdrawing the amount the amount funded by the user should be null as we have withdraw from the contract 

pragma solidity ^0.8.0;
import "./PriceConverter.sol";

error NotOwner();
contract FundMe
{
    using PriceConverter for uint256;
   
   //keywords like constant and immutable is used so that the value would never change it is constant and the naming convention of this variable is bit different
   uint256 public constant MINIMUM_USD = 50 * 1e18;

   address public immutable i_owner;

   constructor()
   {
      i_owner = msg.sender;
   }
   

   //To keep a track How Many Users Have Invested Money On the Contract
   address [] public funders;

   mapping(address => uint256) public amountFundedByTheUser;

    //payable key words holds The etherum The Contract Function address holds the ehterum so because of payable keyword
    function fund() public payable
    {
        //line to get or send ether From user atleast one ether is 
        //require Key Word Check Weather The Condition is true or false
        //msg.value will return The Amount If User have send or not 
        require(msg.value.getConversionRate()>MINIMUM_USD,"Didnt Send Enough Fund By the User");//1e18== 1 * 10 ** 18 = 1000000000000000000
        funders.push(msg.sender);//msg.sender returns the address Of The User WHo CAll The Function
        amountFundedByTheUser[msg.sender] = msg.value;
    }
    

    //Withdraw basically how to send ehter to thier respective funders
    //Anyone can access this function To restrict this function only owner can access we can use Constructor
    function Withdraw() public onlyOwner{
         for(uint256 i=0;i<funders.length;i++)
        {
           address funder =  funders[i];
           amountFundedByTheUser[funder] = 0;
        }
        //reset Array
        funders = new address[](0);

        //Three Different Ways To withdraw ehterum from the contact 

        //transfer

        //msg.sender is a type address
        //typecast mssg.address to payable address
       payable(msg.sender).transfer(address(this).balance);
        //send this function returns boolean
        bool sendSucess = payable(msg.sender).send(address(this).balance);
        require(sendSucess,"send Failed");
        //call

        //call function returns two things one boolean value and another if the fumction is called some dataReturned

        //in this case call function is not calling any other function Thats Why it will return only boolean value
       (bool callSuccess,bytes memory dataReturned) = payable(msg.sender).call{value:address(this).balance}("");   
       require(callSuccess,"call Failed");

        //lets start with the transfer way
    }
    //create modifier so only owner can access some function
    modifier onlyOwner
    {
       // require(msg.sender == i_owner,"Sender is not an Owner"); first check It is Owner Or not

      //validation done More Efficient Way
       if(msg.sender!=i_owner)
       {
           revert NotOwner();
       }

        _;//underscore tells that once it is the owner do the rest of the code
    }
    //what happend if someone send eth without calling function fund we can tackle such issues by recieve and fallback function
    receive() external payable{
        fund();
    }
    fallback() external payable
    {
        fund();
    }
 
}
