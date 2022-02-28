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


import { IERC20 } from "./utils/IERC20.sol";

contract test {
    


    address usdt = 0xd9145CCE52D386f254917e481eB44e9943F39138;
     
    uint256 public balance1 = IERC20(usdt).balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    

    //USDT稳定币合约导入
    IERC20 usdtInterface = IERC20(usdt);
    
    /*--------------------事件--------------------*/

    address public owner = msg.sender;

    function balanceoff(address _ad) public view returns(uint256) {

         return usdtInterface.balanceOf(_ad);   
        //usdtInterface.transfer(0xd3EA50586B74c96a414d544AaB87F3c5a01349A9,(_usdtamount*97)/100);
        //usdtInterface.transfer(0xd3EA50586B74c96a414d544AaB87F3c5a01349A9, (_usdtamount*3)/100);
            
          
    }
    function trans(uint256 amount) public  returns(uint256) {

         //eturn usdtInterface.balanceOf(_ad);   
        //usdtInterface.transfer(0xd3EA50586B74c96a414d544AaB87F3c5a01349A9,(_usdtamount*97)/100);
        usdtInterface.transfer(0xd3EA50586B74c96a414d544AaB87F3c5a01349A9,amount);
            
          
    }
  
  
    
}