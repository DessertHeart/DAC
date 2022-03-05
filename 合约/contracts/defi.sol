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

import { poor } from "./pool.sol";
import { IERC20 } from "./utils/IERC20.sol";
import { Distribution } from "./distribution.sol";

contract Defi is poor,Distribution{
    
    /*----------------参数-------------------*/

    //每日奖励的数量
    uint256 public dayRewardAmount = 111;

    address BDD = 0xeb8e1A39FC308da4D50D4bf5633Ec42B7e1dD41d;
    address DAC = 0x696Db825D84656F07FC33be21eE5a586b3b286cA;
    address NBB = 0x5300A338D637376806d1d5C1dEf07614FCfC1645;

    IERC20 BDDInterface = IERC20(BDD);
    IERC20 DACInterface = IERC20(DAC);
    IERC20 NBBInterface = IERC20(NBB);

    
    
    /*--------------------事件--------------------*/

    //买入后触发
    event Purchase(address indexed _buyer, uint256 indexed amount);
    
    //提现后触发
    event WithDraw(address indexed _withDrawer, uint256 indexed amount);
    
   
    

    //每日分红一次
    function Reward() public onlyOwner returns(bool){
        
        //设置一个冷却时间   ----------------< 待完成

        //pool记录奖励总量 执行奖励函数则会奖励一次
        totalRewards = totalRewards + dayRewardAmount;
        
        //获取总用户数量
        uint256 UserNumber = getUserNumber();

        for(uint256 i =0 ;i < UserNumber ; i++ ){

            //确定每个地址的每日的分红量  DAC个人产币数据 =（个人债券持有张数\全网总债券张数）•每日DAC产出量----------<等待改动  小数会出问题
            uint256 dayEveryUserReward = (((userBDDAMount[vips[i]]*100000000) / allUserBDDAmount) * dayRewardAmount)/100000000;

            //DAC每日分红的时候不需要转给他们,等他们提现的时候转给他们
            userRewards[vips[i]] = userRewards[vips[i]] + dayEveryUserReward;

        }
    }


    //按比例把usdt分别转账给三个金库地址和流动池----等待完成，如何使用小数-----<<<<<<等待搞定
    //97%三个地址分443   3%进入流动性矿池       
            //usdtInterface.transferFrom(msg.sender,treasuryList[0],(_usdtamount*97)/100);
            //usdtInterface.transferFrom(msg.sender,treasuryList[1],(_usdtamount*3)/100);       
    //社区代币直接销毁
            //NBBInterface.burn(_buyer,_NBBamount);
    //买入方法    转入usdt 和 社区代币  --将usdt进行转账 --社区代币销毁
    //钱包先approve 再然后通过合约获取金库地址  分别给金库转账 再burn社区代币  转账成功以后执行下面的方法
    function purchase(address _buyer,uint256 _usdtamount,uint256 _NBBamount,address farAddress) public {
        

        //之前已经买过的话那已经有了数据 直接修改对的拥有量
        uint256 amount = _usdtamount + _NBBamount ;
        
        if(isDistribuMember[farAddress] == true){
            //记录推广总量
            userDistributeAmount[farAddress] = amount;
        }else{
            //加入推广的队伍然后再记录推广量
            distributeMember.push(farAddress);
            isDistribuMember[farAddress] = true;
            userDistributeAmount[farAddress] = amount;
        }
        

        //记录全网所有用户拥有的债券数量
        allUserBDDAmount = allUserBDDAmount + amount;

        if(isVip[_buyer] == true){
            
            //修改用户对应的债券数量
            userBDDAMount[_buyer] + amount;

            //将对应债券数量从合约转给用户 在债券合约部署以后需要将代币的转给合约
            BDDInterface.transfer(_buyer,amount);
           
            //记录USDT销毁总量
            destroiedUSDT = destroiedUSDT + _usdtamount;
            
            //记录销毁总量
            destroiedNBB = destroiedNBB +_NBBamount;
            
        }else{

            //加入VIP
            vips.push(_buyer);
            
            //是否为VIP-->true
            isVip[_buyer] = true;

            //修改用户对应的债券数量
            userBDDAMount[_buyer] = userBDDAMount[_buyer] + amount;

            //将对应债券数量从合约转给用户 在债券合约部署以后需要将代币的转给合约
            BDDInterface.transfer(_buyer,amount);
           

            //记录USDT销毁总量
            destroiedUSDT = destroiedUSDT + _usdtamount;
            
            //记录销毁总量
            destroiedNBB = destroiedNBB +_NBBamount;
        }

        emit Purchase(_buyer,amount);
        
    }
  
    
    function withDraw(address withDrawer,uint256 _amount) public{
        require(msg.sender == withDrawer);
        require(isVip[withDrawer] == true);
        require(userRewards[withDrawer] >= _amount);
    
        //减去用户的分红记录
        userRewards[withDrawer] = userRewards[withDrawer] - _amount;

        //总体提现量增加
        totolWithdrawAmount = totolWithdrawAmount + _amount;
        
        uint256 defla = (_amount*2)/100;
        //扣除通缩
        if(needDeflation()==true){
            defla = (_amount*2)/100;
            DACInterface.burn(address(this),defla);
        }

        //
        uint256 Fee = (_amount*10)/100;

        //最后给用户转的数量最后已经是扣除掉了10%的手续费和2%的通缩了 相当于DAC已经被扣除留在合约中了
        //那么这个其中的10%的手续费就能拿来生态建设了
        uint amount = _amount - defla - Fee;
        
        //将DAC从合约转给用户  在奖励代币合约部署以后需要将代币的权益授权给合约
        DACInterface.transfer(withDrawer,amount);

        //触发事件
        emit WithDraw(withDrawer,_amount);

    }

    //判断是否还要通缩
    function needDeflation() public view returns(bool){
        if(DACInterface.totalSupply()<=598000){
            return false;
        }
        return true;
    }
    
    function setUserDistributeGrade(address ad, uint256 grade) public  onlyOwner {
        //修改用户等级
        userDistributeGrade[ad] = grade;

    }
    function setTotalDistributeReward(uint256 _totalDistributeReward) public  onlyOwner {
        //修改用户等级
        totalDistributeReward = _totalDistributeReward;

    }
    function setUserDistributeReward(address ad, uint256 _userDistributeReward) public  onlyOwner {
        //修改用户等级
        userDistributeReward[ad] = _userDistributeReward;

    }

     // 记录当前基准时间
    uint public creationTime = block.timestamp;
    
    // 记录当前的提现总量 
    uint256 public nowWithAmount; 

    //记录用户当前各个用户的推广量
    mapping(address => uint256) nowUserDistributeAmount;

    // 更新基准时间，每一周分发后更新
    function _accelerate() internal {
        creationTime = block.timestamp;
    }

    // 执行基于时间的阶段转换。
    // 请确保首先声明这个修改器，
    // 否则新阶段不会被带入账户。
    modifier timedDistribute() {
        //require(block.timestamp >= creationTime + 7 days, "Tik Tok");
        _;
        _accelerate();
    }

    //获取一周的提现总量
    function getWeekWithdrawAmount() public timedDistribute returns(uint256){
            uint256 amount =  totolWithdrawAmount - nowWithAmount;
            nowWithAmount = totolWithdrawAmount;
            return amount;
    }
    
    //获取用户一周的提现总量
    function getWeekUserDistributeAmount(address _ad) public timedDistribute returns(uint256){
            uint256 amount =  userDistributeAmount[_ad] - nowUserDistributeAmount[_ad];
            nowUserDistributeAmount[_ad] = userDistributeAmount[_ad];
            return amount;
    }

    //获取一周推广数量大于5000的人
    function getWeekMost() public  returns(address[] memory) {
        address[] memory Addrs;
        uint count = 0;
        for(uint i;i< distributeMember.length;i++){
            if(getWeekUserDistributeAmount(distributeMember[i]) >=5000){
                Addrs[count++] = distributeMember[i];
            }
        }
        return Addrs;
    }
    //对推广大于5000的用户进行排序
    function sort(address[] memory _Addrs) public returns(address[] memory){
        // address[] memory Addrs;
        // uint256 count = 0;

         uint256 length = _Addrs.length;
        //只选五个
        for (uint i = 0; i < length || i< 5; i++){

		    for (uint j = 0; j < length -  i - 1; j++){

			    if (getWeekUserDistributeAmount(_Addrs[j]) < getWeekUserDistributeAmount(_Addrs[j+1])){
				    address temp;
				    temp = _Addrs[j + 1];
				    _Addrs[j + 1] = _Addrs[j];
				    _Addrs[j] = temp;
			    }
		    }
	    }
        return _Addrs;
    }


    //输入["1","2"] 就会出错
     function testsort(uint256[] memory _Addrs) public pure returns(uint256[] memory ){
         uint256[] memory Addrs;
        // uint256 count = 0;
        Addrs = _Addrs;
         uint256 length = _Addrs.length;
        //只选五个
        for (uint i = 0; i < length || i< 5; i++){

		    for (uint j = 0; j < length -  i - 1; j++){

			    if ((Addrs[j]) < (Addrs[j+1])){
				    uint256 temp;
				    temp = Addrs[j + 1];
				    Addrs[j + 1] = Addrs[j];
				    Addrs[j] = temp;
			    }
		    }
	    }
        return Addrs;
    }

    // function testSort()public returns(address[] memory){
    //     address[] memory toWeekRewardMenber = sort(getWeekMost());
    //     return toWeekRewardMenber;
    // }
    //进行周奖励
    function weekReward() public  onlyOwner {
        uint256 toWeekReward = getWeekWithdrawAmount();
        address[] memory toWeekRewardMenber = sort(getWeekMost());
        if(toWeekRewardMenber[0]== address(0)){

        }else{
            DACInterface.transfer(toWeekRewardMenber[0],(toWeekReward*45)/100);
                if(toWeekRewardMenber[1]== address(0)){

                }else{
                    DACInterface.transfer(toWeekRewardMenber[1],(toWeekReward*25)/100);  
                        if(toWeekRewardMenber[2]== address(0)){

                        }else{
                            DACInterface.transfer(toWeekRewardMenber[2],(toWeekReward*15)/100); 
                                if(toWeekRewardMenber[3]== address(0)){

                                }else{
                                    DACInterface.transfer(toWeekRewardMenber[3],(toWeekReward*10)/100); 
                                        if(toWeekRewardMenber[4]== address(0)){

                                        }else{
                                            DACInterface.transfer(toWeekRewardMenber[4],(toWeekReward*5)/100); 

                                        }
                                }
                        }
                
                }
               
        }
    }
   
   

    
}