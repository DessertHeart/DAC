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

import { BDD } from "./BDD.sol";
import { AddressArrayUtils } from "./utils/AddressArrayUtils.sol";
import { Ownable } from "./utils/Ownable.sol";
//Tether-USDT接口
interface USDTinterface {
    function transferFrom(address _from, address _to, uint _value) external;
}
contract poor is Ownable,BDD {
    using AddressArrayUtils for address[];
    //记录BDD已经铸造了多少
    uint256 public BDDtotalMinted;
    //用户列表
    address[] public vips;

    //金库
    address[] public treasuryList;
    
    //每个用户对应的债券量
    mapping(address=>uint256) public userBDDMount;

    //用户是否已经成为Vip
    mapping(address=>bool) public isVip;

    //总分红量
    uint256 public totalRewards;
    
    //用户分红量
    mapping (address => uint256) public userRewards;

     //USDT稳定币合约导入
    address USDTinterfaceAddr = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    USDTinterface usdtInterface = USDTinterface(USDTinterfaceAddr);

    constructor(
        string memory _name,
        string memory _symbol
    )
        public
        BDD(_name, _symbol)
    {

    }
    
    //买入方法
    //转入usdt 和 社区代币  --将usdt进行转账 --社区代币销毁
    function purchase(address _buyer,uint256 _usdtamount,uint256 _NBBamount) public {
        //之前已经买过的话那已经有了数据 直接修改对的拥有量
        uint256 amount = _usdtamount + _NBBamount ;
        if(isVip[_buyer] == true){
            BDDtotalMinted = BDDtotalMinted + amount;
            userBDDMount[_buyer] = userBDDMount[_buyer] + amount;
            _BDDmint(_buyer,amount);
            //按比例把usdt分别转账给三个金库地址和流动池----等待完成
            
        }else{
            vips.push(_buyer);
            isVip[_buyer] = true;
            BDDtotalMinted = BDDtotalMinted + amount;
            userBDDMount[_buyer] = userBDDMount[_buyer] + amount;
            _BDDmint(_buyer,amount);
             //按比例把usdt分别转账给三个金库地址和流动池----等待完成
        }
        
    }
  
    function withDraw(uint256 _amount) public returns(bool){
        require(isVip[msg.sender] == true);
        require(userRewards[msg.sender] >= _amount);
        //进行转账
        //减去用户的分红记录
        userRewards[msg.sender] = userRewards[msg.sender] - _amount;
    }
    function getUserNumber() public view returns(uint256){
        return vips.length;
    }

 
    function addTreasuryList(address _newTreasuryListAddr) external  {

        treasuryList.push(_newTreasuryListAddr);

    }

   
    function removeTreasuryList(address _oldTreasuryListAddr) external {

        treasuryList = treasuryList.remove(_oldTreasuryListAddr);

    }

    
}