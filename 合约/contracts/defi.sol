/*
    Copyright 2020 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    SPDX-License-Identifier: Apache License, Version 2.0
*/

pragma solidity 0.6.10;
import "./utils/Context.sol";
import "./utils/SafeMath.sol";

import { poor } from "./pool.sol";
import { DAC } from "./DAC.sol";
import { NBB } from "./NBB.sol";
import { ABDKMath64x64 } from "./ABDK.sol";
//Tether-USDT接口
interface IERC20 {
  function transfer(address recipient, uint256 amount) external;
 
}
contract Defi is poor,DAC,NBB{
    using ABDKMath64x64 for uint256;
    
    /*----------------参数-------------------*/

    //每日奖励的数量
    uint256 public dayRewardAmount = 2660;

    //USDT稳定币合约导入
    IERC20 usdtInterface = IERC20(0x1B4Fdea036675Ba29c6a6d7aC8Cc0816Eabac3A4);
    
    /*--------------------事件--------------------*/

    //买入后触发
    event Purchase(address indexed _buyer, uint256 indexed amount);
    
    //提现后触发
    event WithDraw(address indexed _withDrawer, uint256 indexed amount);
    
    //债券名字、符号、总发行量    奖励代币的名字、符号、总发行量
    constructor(
        string memory BDDname_,
        string memory BDDsymbol_,
        uint256  BDDtotalMint,
        string memory DACname_,
        string memory DACsymbol_,
        uint256 DACtotalMint,
        string memory NBBname_,
        string memory NBBsymbol_,
        uint256 NBBtotalMint
    )
        public
        poor(BDDname_, BDDsymbol_)
        DAC(DACname_,DACsymbol_)
        NBB(NBBname_,NBBsymbol_)
        
    {
        //将初始的债券、奖励代币、社区代币直接存到合约中
        _BDDmint(address(this),BDDtotalMint);
        _DACmint(address(this),DACtotalMint);
        _NBBmint(address(this),NBBtotalMint);
    }
    
   

    //每日分红一次
    function Reward() public onlyOwner returns(bool){
        
        //设置一个冷却时间   ----------------< 待完成

        //pool记录奖励总量 执行奖励函数则会奖励一次
        totalRewards = totalRewards + dayRewardAmount;
        
        //获取总用户数量
        uint256 UserNumber = getUserNumber();

        for(uint256 i =0 ;i < UserNumber ; i++ ){

            //确定每个地址的每日的分红量  DAC个人产币数据 =（个人债券持有张数\全网总债券张数）•每日DAC产出量----------<等待改动  小数会出问题
            uint256 dayEveryUserReward = (((userBDDMount[vips[i]]*100000000) / allUserBDDAmount) * dayRewardAmount)/100000000;

            //DAC每日分红的时候不需要转给他们,等他们提现的时候转给他们
            userRewards[vips[i]] = userRewards[vips[i]] + dayEveryUserReward;

        }
    }


    //买入方法    转入usdt 和 社区代币  --将usdt进行转账 --社区代币销毁
    function purchase(address _buyer,uint256 _usdtamount,uint256 _NBBamount) public {
        
        //之前已经买过的话那已经有了数据 直接修改对的拥有量
        uint256 amount = _usdtamount + _NBBamount ;
        
        //记录全网所有用户拥有的债券数量
        allUserBDDAmount = allUserBDDAmount + amount;

        if(isVip[_buyer] == true){
            
            //修改用户对应的债券数量
            userBDDMount[_buyer] = userBDDMount[_buyer] + amount;

            //将对应债券数量从合约转给用户
            AddressBDDtransfer(_buyer,amount);
           
            //按比例把usdt分别转账给三个金库地址和流动池----等待完成，如何使用小数-----<<<<<<等待搞定
            //97%三个地址分443   3%进入流动性矿池
            usdtInterface.transfer(treasuryList[0],(_usdtamount*97)/100);
            usdtInterface.transfer(treasuryList[1], (_usdtamount*3)/100);

            //社区代币直接销毁
            _NBBburn(_buyer,_NBBamount);
            
        }else{

            //加入VIP
            vips.push(_buyer);
            
            //是否为VIP-->true
            isVip[_buyer] = true;

            //修改用户对应的债券数量
            userBDDMount[_buyer] = userBDDMount[_buyer] + amount;

            //将对应债券数量从合约转给用户
            AddressBDDtransfer(_buyer,amount);
            
            usdtInterface.transfer(treasuryList[0],(_usdtamount*97)/100);
            usdtInterface.transfer(treasuryList[1], (_usdtamount*3)/100);
            
            //社区代币直接销毁
            _NBBburn(_buyer,_NBBamount);
        }
        emit Purchase(_buyer,amount);
        
    }
  
    function withDraw(address withDrawer,uint256 _amount) public{
        require(msg.sender == withDrawer);
        require(isVip[withDrawer] == true);
        require(userRewards[withDrawer] >= _amount);
    
        //减去用户的分红记录
        userRewards[withDrawer] = userRewards[withDrawer] - _amount;
        
        uint256 defla = (_amount*2)/100;
        //扣除通缩-------<<<小数还没实现
        if(needDeflation()==true){
            defla = (_amount*2)/100;
            _DACburn(address(this),defla);
        }

        uint256 Fee = (_amount*10)/100;
        uint amount = _amount - defla - Fee;
        //将DAC从合约转给用户
        AddressDACtransfer(withDrawer,amount);

        //触发事件
        emit WithDraw(withDrawer,_amount);

    }

    //判断是否还要通缩
    function needDeflation() public view returns(bool){
        if(DACtotalSupply()<=598000){
            return false;
        }
        return true;
    }
 

    
}