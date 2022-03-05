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

contract Distribution {
    //所有的推广的人
    address[] public distributeMember;

    mapping(address => bool) isDistribuMember;

    //记录用户的推广量
    mapping(address => uint256) public userDistributeAmount;

    //记录这个用户的等级
    mapping(address => uint256) public userDistributeGrade;

    //记录这个用户有效的推广数量
    mapping(address => uint256) public userDistributeSon;

    mapping(address=>mapping(address=>bool)) public isMyFar;

    //记录总的分销奖励
    uint256 public totalDistributeReward;

    //记录用户自己的奖励数量
    mapping(address => uint256) public userDistributeReward;

    //提现总量
    uint256 public totolWithdrawAmount;


}