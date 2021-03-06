/**
 *Submitted for verification at BscScan.com on 2022-02-13
*/

// SPDX-License-Identifier: MIT



pragma solidity >=0.6.0 <0.8.0;

interface IERC20 {
   
    function totalSupply() external view returns (uint256);

   
    function balanceOf(address account) external view returns (uint256);

   
    function transfer(address recipient, uint256 amount) external returns (bool);

   
    function allowance(address owner, address spender) external view returns (uint256);

   
    function approve(address spender, uint256 amount) external returns (bool);

   
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

   
    event Transfer(address indexed from, address indexed to, uint256 value);

   
    event Approval(address indexed owner, address indexed spender, uint256 value);
}



library SafeMath {
   
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;    if (c < a) return (false, 0);    return (true, c);}

   
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);    return (true, a - b);}

   
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        
        
        
        if (a == 0) return (true, 0);    uint256 c = a * b;    if (c / a != b) return (false, 0);    return (true, c);}

   
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);    return (true, a / b);}

   
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);    return (true, a % b);}

   
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;    require(c >= a, "SafeMath: addition overflow");    return c;}

   
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");    return a - b;}

   
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;    uint256 c = a * b;    require(c / a == b, "SafeMath: multiplication overflow");    return c;}

   
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");    return a / b;}

   
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");    return a % b;}

   
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);    return a - b;}

   
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);    return a / b;}

   
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);    return a % b;}
}



library Address {
   
    function isContract(address account) internal view returns (bool) {
        
        
        

        uint256 size;assembly { size := extcodesize(account) }
        return size > 0;}

   
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        
        (bool success, ) = recipient.call{ value: amount }("");    require(success, "Address: unable to send value, recipient may have reverted");}

   
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");}

   
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);}

   
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");}

   
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");    require(isContract(target), "Address: call to non-contract");

        
        (bool success, bytes memory returndata) = target.call{ value: value }(data);    return _verifyCallResult(success, returndata, errorMessage);}

   
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");}

   
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        
        (bool success, bytes memory returndata) = target.staticcall(data);    return _verifyCallResult(success, returndata, errorMessage);}

   
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");}

   
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        
        (bool success, bytes memory returndata) = target.delegatecall(data);    return _verifyCallResult(success, returndata, errorMessage);}

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;    } else {
            
            if (returndata.length > 0) {
                

                
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);        }
        }
    }
}


library SafeERC20 {
    using SafeMath for uint256;using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));}

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));}

   
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        
        
        
        
        require((value == 0) || (token.allowance(address(this), spender) == 0),    "SafeERC20: approve from non-zero to non-zero allowance"
        );    _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));}

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);    _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));}

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");    _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));}

   
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        
        
        

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");    if (returndata.length > 0) { 
            
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");    }
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;}

    function _msgData() internal view virtual returns (bytes memory) {
        this; 
        return msg.data;}
}



abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

   
    constructor () internal {
        address msgSender = _msgSender();    
        _owner = msgSender;    
        emit OwnershipTransferred(address(0),msgSender);
    }

   
    function owner() public view virtual returns (address) {
        return _owner;}

   
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");    _;}

   
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));    _owner = address(0);}

   
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");    emit OwnershipTransferred(_owner, newOwner);    _owner = newOwner;}
}





interface IERC20Meta is IERC20 {
    function name() external view returns (string memory);function symbol() external view returns (string memory);function decimals() external view returns (uint8);
}




interface IUniswapFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);function allPairs(uint) external view returns (address pair);function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;function setFeeToSetter(address) external;
}





interface IUniswapPair {
    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,    uint112 reserve1,    uint32 blockTimestampLast
        );
}




interface IUniswapRouter01 {
    function factory() external pure returns (address);function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,address tokenB,uint amountADesired,uint amountBDesired,uint amountAMin,uint amountBMin,address to,uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);function addLiquidityETH(
        address token,uint amountTokenDesired,uint amountTokenMin,uint amountETHMin,address to,uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);function removeLiquidity(
        address tokenA,address tokenB,uint liquidity,uint amountAMin,uint amountBMin,address to,uint deadline
    ) external returns (uint amountA, uint amountB);function removeLiquidityETH(
        address token,uint liquidity,uint amountTokenMin,uint amountETHMin,address to,uint deadline
    ) external returns (uint amountToken, uint amountETH);function removeLiquidityWithPermit(
        address tokenA,address tokenB,uint liquidity,uint amountAMin,uint amountBMin,address to,uint deadline,bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);function removeLiquidityETHWithPermit(
        address token,uint liquidity,uint amountTokenMin,uint amountETHMin,address to,uint deadline,bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);function swapExactTokensForTokens(
        uint amountIn,uint amountOutMin,address[] calldata path,address to,uint deadline
    ) external returns (uint[] memory amounts);function swapTokensForExactTokens(
        uint amountOut,uint amountInMax,address[] calldata path,address to,uint deadline
    ) external returns (uint[] memory amounts);function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}



interface IUniswapRouter02 is IUniswapRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,uint liquidity,uint amountTokenMin,uint amountETHMin,address to,uint deadline
    ) external returns (uint amountETH);function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,uint liquidity,uint amountTokenMin,uint amountETHMin,address to,uint deadline,bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,uint amountOutMin,address[] calldata path,address to,uint deadline
    ) external;function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,address[] calldata path,address to,uint deadline
    ) external payable;function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,uint amountOutMin,address[] calldata path,address to,uint deadline
    ) external;
}




contract HJXPool is IERC20, Ownable {

    using SafeMath for uint256;
    using SafeERC20 for IERC20Meta;
    address public constant HOLE =address(0x000000000000000000000000000000000000dEaD);//????????????
    uint256 public constant RATE_PRECISION = 1000;    //??????
    address private _xToken;    //????????????
    address private _usdt;    //usdt
    address private _router;    //????????????
    uint256 private _slippage = 200;    //????????????
    uint256 private _rebateOcc = 200;  //????????????usdt????????????20
    uint256[] private _rebateRequireHashrate = [100, 100, 500, 1000, 3000];// ?????????????????????????????????
    uint256[] private _rebateLevels = [1, 2, 3, 13, 23];    // ???????????????  
    uint256[] private _rebateRates = [150,100,50,40,40,40,40,40,40,40,40,40,40,30,30,30,30,30,30,30,30,30,30];     //???????????????  ??????15 ??????10 ??????5 ??????4 ??????3
    bool private _init = false;    // ???????????????????????????
    bool private _autoSwapFlag = false;    //????????????
    address private _root;    //?????????-----??????????????????????????????????????????????????????
    address private _rebateFee;    // ???????????????????????????usdt????????????
    address private _market;    // ???????????????????????????????????????  ???usdt??????????????????
    uint256 private _autoBuyRate = RATE_PRECISION;     // ????????????????????????   ??????????????????
    bool private _enableTransfer = true;     // ????????????????????????
    uint256[] private _claimFeeRates;    // ??????????????????????????????
    address[] private _claimFeeMarkets;    // ??????????????????????????????????????????????????????
    string private _name;    //????????????
    string private _symbol;//????????????   
    uint8 private _decimals;//???????????? 
    mapping(address => mapping(address => uint256)) private _allowances;     // ???????????????mapping
    uint256 private _depositAmountMinLimit;    // ??????????????????
    uint256 private _depositAmountMaxLimit;    // ??????????????????
    mapping(address => bool) private _blackList;    // ??????????????????
    mapping (address=>bool) private _isVIP; //???????????????
    // ???????????????
    struct Pool {
        uint256 startTime;            // ????????????
        uint256 hashrate;            // ?????????
        uint256 accBonusPerShare;            // ?????????
        uint256 lastRewardTime;        // ????????????????????????
    }

    // ???????????????
    struct Miner {
        uint256 hashrate;            // ?????????
        uint256 bonus;           // ????????????
        uint256 out;            //???????????????
        address referee;        // ????????????
        address[] refers;        // ????????????
        uint256 rebateTotal;        // ???????????????
        uint256 totalHashrate;        //??????????????????
    }

    // ?????????????????????
    struct RebateInfo {
        address rebateUser;        // ??????????????????
        uint256 rebateTime;        // ??????????????????
        uint256 rebateAmount;        // ????????????
        uint256 level;        // ????????????
        uint256 rebateRate;        // ????????????
    }

    // ?????????  
    struct TokenPool {   
        address token0;        // usdt????????? 
        address token1;        // ?????????????????????
        uint256 hashrate;        // ????????????
        uint256 token0Total;        // usdt????????? ?????????
        uint256 token1Total;        // ?????????????????????  ???????????????????????????????????????
        address[]  allUsers;          // ???????????????
    }

    mapping(address => RebateInfo[]) private _rebateInfos;    // ????????????????????????????????????????????????
    mapping(address => Miner) private _miners;    // ???????????????????????????????????????
    Pool private _pool;    // ?????????????????????
    TokenPool[] private _tokenPools;    // ???????????????????????????

    receive() external payable {}
    // ????????????
    constructor(address router_,address usdt_,address xToken_,address root_,address rebateFee_,address market_) public {
        _usdt = usdt_;    
        _router = router_;    
        _xToken = xToken_;    
        _root = root_;   
        _rebateFee = rebateFee_;    
        _market = market_;  
        // ??????usdt????????????????????????????????????????????????
        _depositAmountMinLimit =100 *10**(uint256(IERC20Meta(_usdt).decimals()));    
        _depositAmountMaxLimit =20000 *10**uint256(IERC20Meta(_usdt).decimals());
        _name = "Bond DLC";   
        _symbol = "BDC";   
        _decimals = IERC20Meta(_usdt).decimals();     
    }



    
    /** 
        @dev _pool.accBonusPerShare = add ?????? * ?????? * 10**9 / ???????????????    ????????????????????????   ??????????????????
     */
    function _updateBonusShare() public onlyOwner {
        //require(block.timestamp>=_pool.lastRewardTime + 1 days,"time not enough");
        //???????????????????????????????????? ????????? ????????????????????????????????????????????????
        if (_pool.hashrate == 0) {
            return;
        }
        uint256 dayMint = 9041*10**16; // ?????? * ?????? * 10**9 / ???????????????
        _pool.accBonusPerShare = dayMint.add(_pool.accBonusPerShare);   //???????????????????????? 
        _pool.lastRewardTime = block.timestamp;// ??????????????????
        //??????????????????????????????????????? //?????????????????????
        uint256 acc = _pool.accBonusPerShare;
        for(uint256 i= 0; i < _tokenPools.length;i++){
            // ????????????????????????
            TokenPool storage tokenPool = _tokenPools[i];
            for(uint256 j= 0 ; j< tokenPool.allUsers.length;j++){
                address uers = tokenPool.allUsers[j];
                uint256 dayEveryUserReward = _miners[uers].hashrate.mul(acc).div(_pool.hashrate) ;  
                //DAC??????????????????????????????????????????,????????????????????????????????????
                _miners[uers].bonus = dayEveryUserReward.add(_miners[uers].bonus);
                tokenPool.token1Total = dayEveryUserReward.add(tokenPool.token1Total);//?????????????????????
            }
        }
    }

    
    /**
        @dev  ??????????????????????????????   ?????????????????????
     */
    function _updateMiner(address account,uint256 hashrate,bool reverse) private {  
        // ?????????????????????
        if (reverse) {
            _miners[account].hashrate = _miners[account].hashrate.sub(hashrate);//????????????????????????
        }else {
            _miners[account].hashrate = hashrate.add(_miners[account].hashrate); // ??????????????????
        }
       
    }

    /**
        @dev ?????????????????????amount???????????????????????????usdt
     */
    function _getPrice(address t0,address t1,uint256 amount) private view returns (uint256) {
        address pair = IUniswapFactory(IUniswapRouter02(_router).factory()).getPair(t0, t1);//?????????????????????????????????????????????      
        (uint256 r0, uint256 r1, ) = IUniswapPair(pair).getReserves(); // ???????????????
        (uint256 reserve0, uint256 reserve1) = (IUniswapPair(pair).token0() ==t0) ? (r0, r1): (r1, r0);   // ????????????????????????
        return IUniswapRouter02(_router).getAmountOut(amount, reserve0, reserve1); //      
    }

   
    /**
        @dev ????????????80???usdt??????????????????,????????????

     */
    function _autoSwapAndBurn(address token0,address token1,uint256 amountIn,uint256 deadline) private returns (uint256) {
        address[] memory paths = new address[](2);
        paths[0] = token0;    
        paths[1] = token1;
        uint256 out = _getPrice(token0, token1, amountIn);//????????????????????????    
        uint256 minOut = out.sub(out.mul(_slippage).div(RATE_PRECISION));//out - out * 200 / 1000   ???????????????20
        IERC20Meta(token0).approve(_router, amountIn); // ???token0?????????????????????????????????           
        // ?????????????????????80???usdt?????????????????????  ???????????????0??????
        uint256[] memory amounts = IUniswapRouter02(_router).swapExactTokensForTokens(amountIn, minOut, paths, HOLE, deadline);    
        return amounts[amounts.length - 1]; //?????????????????????
    }

   
   /**
        @dev ???????????? ??????????????????????????????

    */
    function _rebateLevelMap(uint256 index) private view returns (uint256) {
        uint256 deepth = _rebateLevels.length; //deepth = 5 
        for (uint256 i = 0; i < deepth; i++) {
            if (index < _rebateLevels[i]) {
                return i;        
            }
        }
    }

   /**
        @dev ?????? ???25???????????????????????????  ????????????????????????_rebateFee
    */
    function _rebate(address account,uint256 value,uint256 hashrate,address tokenAddres) private {
        address referee = _miners[account].referee;//?????????
        uint256 deepth = _rebateLevels.length;   //deepth = 5
        uint256 use = 0;    
        //  i < 25 
        for (uint256 i = 0; i < _rebateLevels[deepth - 1]; i++) {
            if (referee == address(0)) {
                break;        
            }
            uint256 index = _rebateLevelMap(i);  //{i=0->index=0}  {i=1->index=1} {i=2->index=2}
            //????????????????????????????????????  {500 * 10*18}  {500*10**18} {1000*10**18}
            if (_miners[referee].hashrate >=_rebateRequireHashrate[index].mul(10**uint256(IERC20Meta(tokenAddres).decimals()))){
                //{??????=value*200/1000} {??????=value*150/1000} {??????=value*120/1000} 
                uint256 commission = value.mul(_rebateRates[i]).div(RATE_PRECISION);    
                _miners[referee].rebateTotal = commission.add(_miners[referee].rebateTotal);//????????????????????????            
                use = commission.add(use);            
                IERC20Meta(_usdt).safeTransfer(referee, commission); //?????????????????????
                // ??????????????????????????????   
                RebateInfo memory rebateInfo = RebateInfo({
                    rebateUser: account,            
                    rebateTime: block.timestamp,            
                    rebateAmount: commission,            
                    level: i,            
                    rebateRate: _rebateRates[i]
                });
                _rebateInfos[referee].push(rebateInfo);//?????????????????????        
            }
            //????????????????????????
            _miners[referee].totalHashrate = hashrate.add(_miners[referee].totalHashrate);        
            //?????????????????????
            referee = _miners[referee].referee;   
        }

        uint256 balance = value.sub(use); //??????????????????  ???????????????_rebateFee
        IERC20Meta(_usdt).safeTransfer(_rebateFee, balance);
    }


    /**
        @dev ????????????0??????????????????????????????????????????????????? --------???????????????
     */
    function _isActive(address account ) private view returns (bool) {
        return _miners[account].referee != address(0) || account == _root;
    }

    /**
        @dev ???????????????????????????
     */
    function _isAvailableTokenPool(uint256 index) private view returns (bool) {
        return index < _tokenPools.length;
    }

    /**
        @dev ??????????????????????????????   ??????????????????????????????
     */
    function rebateListNum(address account) public view returns (uint256) {
        return _rebateInfos[account].length;
    }

   /**
        @dev ???????????????
    */
    function rebateInfo(uint256 start,uint256 end,address account)public view returns (
        uint256[] memory levels, 
        address[] memory users,    
        uint256[] memory rebateValues,    
        uint256[] memory times,    
        uint256[] memory rates)
        {
        //?????????????????????????????????????????????
        RebateInfo[] memory logs = _rebateInfos[account];  
        // ??????????????????????????????????????????
        require(logs.length > 0, "NxPool: no data");
        if (start >= logs.length) {
            start = logs.length - 1;    
        }
        if (end == 0) {
            end = 1;    
        } else if (end > logs.length) {
            end = logs.length;    
        }
        if (start >= end) {
            start = end - 1;    
        }

        uint256 length = end.sub(start);
        levels = new uint256[](length);
        users = new address[](length);  
        rebateValues = new uint256[](length);
        times = new uint256[](length); 
        rates = new uint256[](length); 

        uint256 j = 0;   
        // ???????????????????????? 
        for (uint256 id = end; id > start; id--) {
            RebateInfo memory log = logs[id - 1];        
            levels[j] = log.level + 1;        
            users[j] = log.rebateUser;        
            rebateValues[j] = log.rebateAmount;        
            times[j] = log.rebateTime;        
            rates[j] = log.rebateRate;       
            j++;    
        }
    }

   
     /**
        @dev ???????????????????????????????????????
     */
    function getHashrates(address account)public view returns (uint256){
        return _miners[account].hashrate;
    }

   /**
        @dev ????????????????????????????????? -------------???????????????
    */
    function viewMinting(address account) public view returns (uint256) {
        return _miners[account].bonus;
    }

   /**
        @dev ?????????????????????
    */
    function pool()public view returns (uint256 hashrate,uint256 acc,uint256 lastRewardTime,uint256 startTime){
        hashrate = _pool.hashrate;    
        acc = _pool.accBonusPerShare;     
        lastRewardTime = _pool.lastRewardTime;    
        startTime = _pool.startTime;
    }

    /**
        @dev ?????????????????????
     */
    function tokenPools()
        public view returns (
            address[] memory token0Addresses,    
            address[] memory token1Addresses,    
            uint256[] memory hashrates,   
            uint256[] memory token1Totals,       
            uint256[] memory token0Totals
        ){
        uint256 length = _tokenPools.length;    
        token0Addresses = new address[](length);    
        token1Addresses = new address[](length);    
        hashrates = new uint256[](length);    
        token1Totals = new uint256[](length);       
        token0Totals = new uint256[](length);
        for (uint256 i = 0; i < length; i++) {
            token0Addresses[i] = _tokenPools[i].token0;        
            token1Addresses[i] = _tokenPools[i].token1;        
            hashrates[i] = _tokenPools[i].hashrate;       
            token1Totals[i] = _tokenPools[i].token1Total;        
            token0Totals[i] = _tokenPools[i].token0Total;    
        }
    }

    /**
        @dev ?????????????????????????????????
     */
    function getClaimFeeRateAndMarket()public view returns (address[] memory claimFeeMarkets,uint256[] memory claimFeeRates){
        uint256 length = _claimFeeRates.length;    
        claimFeeMarkets = new address[](length);    
        claimFeeRates = new uint256[](length);    
        for (uint256 i = 0; i < length; i++) {
            claimFeeMarkets[i] = _claimFeeMarkets[i];        
            claimFeeRates[i] = _claimFeeRates[i];    
        }
    }

   /**
        @dev ??????????????????
     */
    function minerInfo(address account)public view returns (
            uint256 hashrate,    
            uint256 bonus,    
            uint256 out,       
            uint256 rebateTotal,    
            bool isActive,    
            uint256 totalHashrate
        ){
        Miner memory miner = _miners[account];    
        hashrate = miner.hashrate;    
        bonus = viewMinting(account);   
        out = miner.out;    
        rebateTotal = miner.rebateTotal;    
        isActive = _isActive(account);    
        totalHashrate = miner.totalHashrate;
    }

   /**
        @dev ???????????????????????????
     */
    function minerRefer(address account)public view returns (address referee, address[] memory refers){
        Miner memory miner = _miners[account];    
        referee = miner.referee;    
        refers = miner.refers;
    }

   /**
        @dev ???u??????????????????r ???u?????????r?????????
     */
    function _active(address u, address r) private {
        if (!_isActive(u)) {
            require(_isActive(r), "NxPool: r not active");        
            _miners[u].referee = r;       
            _miners[r].refers.push(u);    
        }
    }

   /**
        @dev ??????  

     */
    function deposit(uint256 index,uint256 token0Value,uint256 deadline,address r) public {
        require(_init, "NxPool: operation not allow");
        require(_isAvailableTokenPool(index), "NxPool: illegal token pool");    
        _active(_msgSender(), r); //??????????????????
        TokenPool storage tokenPool = _tokenPools[index];       //????????????tokenpool ????????????
        require(tokenPool.token0 == _usdt, "NxPool: not support token0 now"); //token0?????????usdt
        require(token0Value >= _depositAmountMinLimit &&token0Value <= _depositAmountMaxLimit,"NxPool: unavailable amount");//??????????????????????????????
        IERC20Meta(tokenPool.token0).safeTransferFrom(_msgSender(),address(this),token0Value);//?????????usdt??????????????????
        
        if(_isVIP[msg.sender]==false){                      //??????????????????????????????  ?????????VIP  ???????????????????????????????????????
            _isVIP[msg.sender] = true;
            tokenPool.allUsers.push(msg.sender);
        }
    
        uint256 hashrate = token0Value.mul(125).div(100);   //??????????????? = usdt / 0.8
        tokenPool.hashrate = hashrate.add(tokenPool.hashrate); //???????????????????????????
        tokenPool.token0Total = token0Value.add(tokenPool.token0Total); // ?????????usdt???????????????
        
  
        
        uint256 rebateValue = token0Value.mul(_rebateOcc).div(RATE_PRECISION);//rebateValue = usdt * 200 / 1000    
        
        _rebate(_msgSender(),rebateValue,hashrate,tokenPool.token0); //????????????
        _miners[_msgSender()].hashrate = hashrate.add(_miners[_msgSender()].hashrate);// ???????????????????????????

        uint256 amountP = token0Value.sub(rebateValue); //amountP = usdt - ?????????
        //????????????????????????
        if (_autoSwapFlag && _autoBuyRate > 0) {
            uint256 amountIn = amountP.mul(_autoBuyRate).div(RATE_PRECISION); //amountIn = P * 1000 /1000
            require(_usdt == tokenPool.token0,"NxPool: tokenPool token0 require usdt");       
            _autoSwapAndBurn(tokenPool.token0, _xToken, amountIn, deadline); //???????????????????????????
            //??????????????? 
            if (IERC20Meta(tokenPool.token0).balanceOf(address(this)) > 0) {
                //???usdt?????????????????????market
                IERC20Meta(tokenPool.token0).transfer(_market,IERC20Meta(tokenPool.token0).balanceOf(address(this))); 
            }
        }else{
            // ????????????????????????  ???????????????80???usdt??????_market
            IERC20Meta(tokenPool.token0).transfer(_market, amountP);    
        }
         _pool.hashrate = hashrate.add(_pool.hashrate);//??????????????????????????????
    }

   /**
        @dev ??????
     */
    function claim() public {
        require(!isBlackList(_msgSender()), "NxPool: can not withdraw now, please wait...");       
        uint256 bonus;
        Miner memory miner = _miners[msg.sender];
        //?????????????????????????????? 
        if (_miners[_msgSender()].hashrate > 0) {
            // bonus = ???????????? * ????????? / 10**19         
            bonus = miner.bonus;//?????????????????????
         
            uint256 value = 0;
            uint256 deepth = _claimFeeRates.length;
            for (uint256 i = 0; i < deepth; i++) {
                uint256 fee = bonus.mul(_claimFeeRates[i]).div(RATE_PRECISION);//Fee = bouns * a /  1000          
                value = value.add(fee);            
                IERC20Meta(_xToken).safeTransfer(_claimFeeMarkets[i], fee); //????????????    
            }

            uint256 balance = bonus.sub(value); //??????????????????
            IERC20Meta(_xToken).safeTransfer(_msgSender(), balance);//???????????????????????????
            _miners[_msgSender()].out = _miners[_msgSender()].out.add(bonus); //????????????????????????     
            _miners[_msgSender()].bonus = 0; //??????????????????   
            //rewardDebt = ????????? * ????????? /  10**19
            // _miners[_msgSender()].rewardDebt = _miners[_msgSender()].hashrate.mul(_pool.accBonusPerShare).div(ACC_PRECISION);    
        }
    }


    // ????????????
    function _transfer(address sender,address recipient,uint256 amount) private {
        require(_enableTransfer, "NxPool: require enable transfer");    
        _active(recipient, sender);      
        _updateMiner(sender, amount, true);    
        _updateMiner(recipient, amount, false);    
        emit Transfer(sender, recipient, amount);
    }

    //???????????????    
    function totalSupply() public view virtual override returns (uint256) {
        return _pool.hashrate;
    }

    // ?????????????????????
    function balanceOf(address account)public view virtual override returns (uint256){
        return _miners[account].hashrate;
    }

   //??????
    function _approve(address owner,address spender,uint256 amount ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");    
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;    
        emit Approval(owner, spender, amount);
    }

   
    function name() public view virtual returns (string memory) {
        return _name;
    }

   
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

   
    function decimals() public view virtual returns (uint8) {
        return _decimals;
    }

    //????????????    
    function transfer(address recipient, uint256 amount)public virtual override returns (bool){
        _transfer(_msgSender(), recipient, amount);    
        return true;
    }

    
    function allowance(address owner, address spender) public view virtual override returns (uint256){
        return _allowances[owner][spender];
    }

   
    function approve(address spender, uint256 amount)public virtual override returns (bool){
            _approve(_msgSender(), spender, amount);
            return true;
    }

    //????????????    
    function transferFrom(address sender,address recipient,uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);    
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount,"ERC20: transfer amount exceeds allowance"));    
        return true;
    }

   
    function increaseAllowance(address spender, uint256 addedValue)public virtual returns (bool){
        _approve(_msgSender(),spender,_allowances[_msgSender()][spender].add(addedValue));    
        return true;
    }

   
    function decreaseAllowance(address spender,  uint256 subtractedValue)public virtual returns (bool){
        _approve( _msgSender(), spender,_allowances[_msgSender()][spender].sub(subtractedValue,  "ERC20: decreased allowance below zero"));    
        return true;
    }

    // 
    function market() public view returns (address) {
        return _market;
    }

    function setMarket(address market_) public onlyOwner {
        _market = market_;
    }

    function rebateFee() public view returns (address) {
        return _rebateFee;
    }

    function setRebateFee(address rebateFee_) public onlyOwner {
        _rebateFee = rebateFee_;
    }

    function root() public view returns (address) {
        return _root;
    }

    function setRoot(address root_) public onlyOwner {
        _root = root_;
    }

    function autoSwapFlag() public view returns (bool) {
        return _autoSwapFlag;
    }

    function setAutoSwapFlag(bool autoSwapFlag_) public onlyOwner {
        _autoSwapFlag = autoSwapFlag_;
    }

    //?????????????????????????????????????????????
    function addClaimFeeRateAndFeeMarket(uint256 claimFeeRate,address claimFeeMarket) public onlyOwner {
        _claimFeeRates.push(claimFeeRate);   
         _claimFeeMarkets.push(claimFeeMarket);
    }

    // ???????????????????????????
    function editClaimFeeMarket(uint256 tid,address claimFeeMarket)public onlyOwner{
        require(tid < _claimFeeMarkets.length, "NxPool: unvaliable tid");   
         _claimFeeMarkets[tid] = claimFeeMarket;
    }

    //????????????????????? 
    function editClaimFee(uint256 tid, uint256 claimFeeRate) public onlyOwner {
        require(tid < _claimFeeRates.length, "NxPool: unvaliable tid");    
        _claimFeeRates[tid] = claimFeeRate;
    }

    function init() public view returns (bool) {
        return _init;
    }

    //???????????????
    function initPool(uint256 startTime) public onlyOwner {
        require(!_init, "Pool: operation not allow");    
        _init = true;    
        _pool.startTime = startTime;      
        _pool.lastRewardTime = startTime;
    }

  

    // ???????????????
    function addToken(address token0,address token1) public onlyOwner {
        require(_init, "NxPool: operation not allow"); 
        address[] memory a;   
        TokenPool memory tokenPool = TokenPool({token0: token0, token1: token1,hashrate: 0,token0Total: 0,token1Total: 0,allUsers:a});    
        _tokenPools.push(tokenPool);
    }

  

    function autoBuyRate() public view returns (uint256) {
        return _autoBuyRate;
    }

    // ??????????????????   ???????????????????????????
    function setAutoBuyRate(uint256 autoBuyRate_) public onlyOwner {
        _autoBuyRate = autoBuyRate_;
    }

    function depositAmountLimit()public view returns (uint256 min, uint256 max){
            min = _depositAmountMinLimit;    max = _depositAmountMaxLimit;
    }

   
    function setDepositAmountLimit(uint256 min, uint256 max) public onlyOwner{
        _depositAmountMinLimit = min;    _depositAmountMaxLimit = max;
    }

 






    // // ???????????????????????????
    // function getTokenAmount(uint256 pid, uint256 amount)public view returns (uint256 hashrate, uint256 tokenValue){
    //     require(_isAvailableTokenPool(pid), "NxPool: illegal token pool");    
    //     TokenPool memory tokenPool = _tokenPools[pid]; 
    //     // tokenValue = amount * 1000 / a   
    //     uint256 totalValue = amount.mul(RATE_PRECISION).div(tokenPool.token0Rate);    
    //     tokenValue = _token0MapToken1Amount(tokenPool.token0,tokenPool.token1,(totalValue.sub(amount)).mul(tokenPool.token1Price).div(1e5));
    //     hashrate = totalValue;
    // }

    function getPairInfo() public view returns (
            address pair,    
            address token0,    
            address token1,    
            uint256 reserve0,    
            uint256 reserve1
        ){
            pair = IUniswapFactory(IUniswapRouter02(_router).factory()).getPair(_usdt, _xToken);    
            (uint256 r0, uint256 r1, ) = IUniswapPair(pair).getReserves();
            (token0, reserve0, token1, reserve1) = (IUniswapPair(pair).token0() ==_usdt)? (IUniswapPair(pair).token0(), r0, IUniswapPair(pair).token1(), r1): (IUniswapPair(pair).token1(),r1,IUniswapPair(pair).token0(), r0);
    }

    function addBlackList(address who) public onlyOwner {
        _blackList[who] = true;
    }

    function rmBlackList(address who) public onlyOwner {
        _blackList[who] = false;
    }

    function isBlackList(address who) public view returns (bool) {
        return _blackList[who];
    }

    function slippage() public view returns (uint256) {
        return _slippage;
    }

    function setSlippage(uint256 slippage_) public onlyOwner {
        _slippage = slippage_;
    }

    function rebateOcc() public view returns (uint256) {
        return _rebateOcc;
    }

    function setRebateOcc(uint256 rebateOcc_) public onlyOwner {
        _rebateOcc = rebateOcc_;
    }

    function getEnableTransfer() public view returns (bool) {
        return _enableTransfer;
    }

    function enableTransfer(bool flag) public onlyOwner {
        _enableTransfer = flag;
    }

    function rebateRequireHashrate() public view returns (uint256[] memory) {
        return _rebateRequireHashrate;
    }

    function rebateLevels() public view returns (uint256[] memory) {
        return _rebateLevels;
    }

    function rebateRates() public view returns (uint256[] memory) {
        return _rebateRates;
    }

    // ??????????????? ?????? ???????????? ????????????
    function setReatesInfo(uint256[] memory rh,uint256[] memory rl,uint256[] memory rr) public onlyOwner {
        require(rh.length == rl.length, "NxPool: rh == rl");    
        require(rr.length == rl[rl.length - 1], "NxPool: rr length illegal");    
        _rebateRequireHashrate = rh;    
        _rebateLevels = rl;    
        _rebateRates = rr;
    }

    // ?????????
    function rebateSim(uint256 level, uint256 hashrate)public view returns (
            uint256 index,    
            bool available,    
            uint256 commissionRate
        ){
            require(level > 0, "NxPool: require level > 0");    
            index = _rebateLevelMap(level - 1);    
            if (hashrate >= _rebateRequireHashrate[index]) {
                available = true;        
                commissionRate = _rebateRates[level - 1];    
            } else {
                available = false;        
                commissionRate = 0;    
            }
    }
}
