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

import { poor } from "./poor.sol";
import { DAC } from "./DAC.sol";
contract Defi is poor,DAC {
    uint256 public dayMintAmount = 2660;
    
    
    constructor(
        string memory _poolname,
        string memory _poolsymbol,
        string memory _DACname,
        string memory _DACsymbol
    )
        public
        poor(_poolname, _poolsymbol)
        DAC(_DACname,_DACsymbol)
        
    {
    }
    //先搞定DAC的逻辑
    /*
    DAC每天产出2660，当产出达到590万时不再产出
    通缩的的设置放在扣除手续费部分
    */
   

    //设定时间戳 每日更新分红一次---->等待搞定
    function Reward() public returns(bool){
        //需要发行总量
        require(_DACtotalSupply <= 5980000);
        
        //DAC记录发行总量
        _DACtotalSupply = _DACtotalSupply +dayMintAmount;
        
        //pool记录奖励总量
        totalRewards = totalRewards + dayMintAmount;
        
        //获取总用户数量
        uint256 UserNumber = getUserNumber();

        //
        for(uint256 i =0 ;i < UserNumber ; i++ ){
            //确定每个地址的每日的分红量  DAC个人产币数据 =（个人债券持有张数\全网总债券张数）•每日DAC产出量
            uint256 dayEveryUserReward = (userBDDMount[vips[i]] / _BDDtotalSupply)/dayMintAmount;
            //根据地址和每个人每日的分红量进行转账
            //进行转账  转账到poor这个合约地址 给他转DAC代币
            //修改用户的分红量记录
            userRewards[vips[i]] = userRewards[vips[i]] + dayEveryUserReward;
            //给每个用户锻造DAC
            _DACmint(vips[i],dayEveryUserReward);
        }
    }
    
}