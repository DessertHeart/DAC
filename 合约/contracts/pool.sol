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

import { Ownable } from "./utils/Ownable.sol";
import { AddressArrayUtils } from "./utils/AddressArrayUtils.sol";

contract poor is Ownable {
    
    using AddressArrayUtils for address[];
    /*----------------参数-------------------*/
    //用户列表
    address[] public vips;

    //金库
    address[] public treasuryList = [
        //这是我的测试用  后面要盖
        0xCdbf93cd8D70D02eeB3BDB5049ce424b9AB8c25B,
        0xd3EA50586B74c96a414d544AaB87F3c5a01349A9
    ];
    
    //每个用户对应的债券量
    mapping(address=>uint256) public userBDDAMount;

    //用户是否已经成为Vip
    mapping(address=>bool) public isVip;

    //总分红量
    uint256 public totalRewards;

    //总的已经被购买的债券数量
    uint256 public allUserBDDAmount;
    
    //用户分红量
    mapping (address => uint256) public userRewards;

    //已经销毁的NBB
    uint256 public destroiedNBB;

    //已经销毁的usdt
    uint256 public destroiedUSDT;

    //查询用户数量
    function getUserNumber() public onlyOwner view returns(uint256){
        return vips.length;
    }

    //移除某金库地址 合约拥有者的权限
    function removeTreasuryList(address _oldTreasuryListAddr) external onlyOwner {

        treasuryList = treasuryList.remove(_oldTreasuryListAddr);

    }
    //添加新的金库地址 合约拥有者的权限
    function addTreasuryList(address _newTreasuryListAddr) external onlyOwner  {
        require(indexOf(treasuryList,_newTreasuryListAddr) == false);
        treasuryList.push(_newTreasuryListAddr);
    }

    //查询金库列表
    function getTreasuryList() public view  returns(address[] memory){
        return treasuryList;
    }

    //看金库有没有该地址
    function indexOf(address[] memory A, address a) internal pure returns ( bool) {
        uint256 length = A.length;
        for (uint256 i = 0; i < length; i++) {
            if (A[i] == a) {
                return (true);
            }
        }
        return (false);
    }

    
}