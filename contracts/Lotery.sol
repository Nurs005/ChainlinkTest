// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./VRFv2Consumer.sol";

contract Lotery is Ownable{
    
    VRFv2Consumer public randNum;
    
    IERC20 public  a;
    constructor () Ownable(msg.sender){
        a = IERC20(0xed5C99A58bC4549EC185bc7b4F027FF529d67DFF);
       randNum = VRFv2Consumer(0xf1bCDeD879Fd1A837a9Ce03916cd8726Db55ee1F);
    }

    function setTokenAddress(address _token) public onlyOwner {
        a = IERC20(_token);
    }

    struct loteryStayckers{
        address Stakers;
        uint luckyNum;
        bool wasOrNot;
    }

    loteryStayckers[] public stakerList;


    
    uint public price = 100000000;
    uint private  winNum;
    uint public finally;
    bool public openOrClose;
    

    function fixOwner(address newOwn) public onlyOwner{
        _transferOwnership(newOwn);
    }
    
    event Registration ( uint indexed  lucky, bool indexed sucsees);
    
    event WinnerEatDinner (address indexed  winner, string indexed yepe);

    
    function openReg(bool opcl) public onlyOwner {
        openOrClose = opcl;
    }

    function overrideConst(address token, address vrf) public onlyOwner{
        randNum = VRFv2Consumer(vrf);
        a = IERC20(token);
    }

    function regLotery() public {
        require(openOrClose == true, "Registration is not open");
        a.transferFrom(msg.sender, address(this), price);
       uint requestId =  randNum.requestRandomWords();
       stakerList.push (loteryStayckers(msg.sender, requestId, true));
       emit Registration( requestId, true);

    }

    function getrandNam() public {
        stakerList[]
    }

    

    function fixPrice(uint prise) public onlyOwner {
        price = prise;
    } 
    
    function generateWinNum(uint win) public onlyOwner {
        require(win < 10000, "Your win number too long");
        winNum = win;
    }
    
    function setTimeSearchWin (uint time) public onlyOwner{
        finally  = time;  //https://www.unixtimestamp.com/
    }
    function searchWiner () public onlyOwner {
        require (block.timestamp >= finally, "Final time hasn't arrived yet!");
    for (uint i = 0; i<stakerList.length; i++){
        if (stakerList[i].wasOrNot == true){
            if (stakerList[i].luckyNum == winNum){
            a.transfer(owner(), tem);
            a.transfer(stakerList[i].Stakers, a.balanceOf(address(this)));
            emit WinnerEatDinner(stakerList[i].Stakers, "God bllesed you!!!");
            }
        }
        stakerList[i].wasOrNot = false;
      }
    }

    uint tem;
    function commision() internal {
         tem = a.balanceOf(address(this)) * 100 / 3;
    } 

}