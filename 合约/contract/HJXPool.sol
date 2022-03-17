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
    address public constant HOLE =address(0x000000000000000000000000000000000000dEaD);//黑洞地址
    uint256 public constant RATE_PRECISION = 1000;    //精度
    address private _xToken;    //奖励代币
    address private _usdt;    //usdt
    address private _router;    //路由地址
    uint256 private _slippage = 200;    //这个参数
    uint256 private _rebateOcc = 200;  //分销扣除usdt的百分之20
    uint256[] private _rebateRequireHashrate = [100, 100, 500, 1000, 3000];// 参与分销需要的债券数量
    uint256[] private _rebateLevels = [1, 2, 3, 13, 23];    // 分销的等级  
    uint256[] private _rebateRates = [150,100,50,40,40,40,40,40,40,40,40,40,40,30,30,30,30,30,30,30,30,30,30];     //分销手续费  一代15 二代10 三代5 四代4 五代3
    bool private _init = false;    // 判断是否已经初始化
    bool private _autoSwapFlag = false;    //自动转化
    address private _root;    //根地址-----貌似没用或者防止创建者自己吃分销奖励
    address private _rebateFee;    // 分销奖励多余的这个usdt接收地址
    address private _market;    // 如果合约不自动回购奖励代币  把usdt转到这个地址
    uint256 private _autoBuyRate = RATE_PRECISION;     // 控制自动买的时候   自动买入多少
    bool private _enableTransfer = true;     // 控制债券能不能转
    uint256[] private _claimFeeRates;    // 提现时几个手续费费率
    address[] private _claimFeeMarkets;    // 提现时几个手续费收款地址和上面的对应
    string private _name;    //补充接口
    string private _symbol;//补充接口   
    uint8 private _decimals;//补充接口 
    mapping(address => mapping(address => uint256)) private _allowances;     // 授权债券的mapping
    uint256 private _depositAmountMinLimit;    // 押金最小限制
    uint256 private _depositAmountMaxLimit;    // 押金最大限制
    mapping(address => bool) private _blackList;    // 是否在黑名单
    mapping (address=>bool) private _isVIP; //是否买入过
    // 池子结构体
    struct Pool {
        uint256 startTime;            // 开始时间
        uint256 hashrate;            // 债券数
        uint256 accBonusPerShare;            // 分红值
        uint256 lastRewardTime;        // 上一次奖励的时间
    }

    // 矿工结构体
    struct Miner {
        uint256 hashrate;            // 债券数
        uint256 bonus;           // 挖矿奖金
        uint256 out;            //提现了多少
        address referee;        // 父类分销
        address[] refers;        // 子类分销
        uint256 rebateTotal;        // 总共的回扣
        uint256 totalHashrate;        //分销债券数量
    }

    // 分销的的结构体
    struct RebateInfo {
        address rebateUser;        // 谁给我收益了
        uint256 rebateTime;        // 当前分销时间
        uint256 rebateAmount;        // 分销金额
        uint256 level;        // 分销等级
        uint256 rebateRate;        // 分销比例
    }

    // 社区池  
    struct TokenPool {   
        address token0;        // usdt的地址 
        address token1;        // 奖励代币的地址
        uint256 hashrate;        // 债券数量
        uint256 token0Total;        // usdt的数量 销毁的
        uint256 token1Total;        // 奖励代币的数量  记录所有用户的奖励代币数量
        address[]  allUsers;          // 所有的用户
    }

    mapping(address => RebateInfo[]) private _rebateInfos;    // 一个地址对应一个分销的结构体数组
    mapping(address => Miner) private _miners;    // 一个地址对应一个矿工结构体
    Pool private _pool;    // 定义一个总池子
    TokenPool[] private _tokenPools;    // 定义一个社区池数组

     
    // 构造函数
    constructor(address router_,address usdt_,address xToken_,address root_,address rebateFee_,address market_) public {
        _usdt = usdt_;    
        _router = router_;    
        _xToken = xToken_;    
        _root = root_;   
        _rebateFee = rebateFee_;    
        _market = market_;  
        // 根据usdt的小数点来控制最小购买和最大购买
        _depositAmountMinLimit =100 *10**(uint256(IERC20Meta(_usdt).decimals()));    
        _depositAmountMaxLimit =20000 *10**uint256(IERC20Meta(_usdt).decimals());
        _name = "Bond DLC";   
        _symbol = "BDC";   
        _decimals = IERC20Meta(_usdt).decimals();     
    }



    
    /** 
        @dev _pool.accBonusPerShare = add 时间 * 区块 * 10**9 / 总债券数量    更新总的奖励数量   更新奖励时间
     */
    function _updateBonusShare() public onlyOwner {
        //require(block.timestamp>=_pool.lastRewardTime + 1 days,"time not enough");
        //总池子里面的债券数量为零 就不动 根据债券总池子的债券数量来分享的
        if (_pool.hashrate == 0) {
            return;
        }
        uint256 dayMint = 9041*10**16; // 时间 * 区块 * 10**9 / 总债券数量
        _pool.accBonusPerShare = dayMint.add(_pool.accBonusPerShare);   //更新总的奖励数量 
        _pool.lastRewardTime = block.timestamp;// 更新奖励时间
        //每个用户的奖励都要更新一下 //遍历所有的社区
        uint256 acc = _pool.accBonusPerShare;
        for(uint256 i= 0; i < _tokenPools.length;i++){
            // 遍历社区所有用户
            TokenPool storage tokenPool = _tokenPools[i];
            for(uint256 j= 0 ; j< tokenPool.allUsers.length;j++){
                address uers = tokenPool.allUsers[j];
                uint256 dayEveryUserReward = _miners[uers].hashrate.mul(acc).div(_pool.hashrate) ;  
                //DAC每日分红的时候不需要转给他们,等他们提现的时候转给他们
                _miners[uers].bonus = dayEveryUserReward.add(_miners[uers].bonus);
                tokenPool.token1Total = dayEveryUserReward.add(tokenPool.token1Total);//记录社区总奖励
            }
        }
    }

    
    /**
        @dev  更新的用户的债券数量   转账的时候调用
     */
    function _updateMiner(address account,uint256 hashrate,bool reverse) private {  
        // 转让的时候用到
        if (reverse) {
            _miners[account].hashrate = _miners[account].hashrate.sub(hashrate);//用户债券数量减掉
        }else {
            _miners[account].hashrate = hashrate.add(_miners[account].hashrate); // 加上这个数量
        }
       
    }

    /**
        @dev 返回购买数量为amount的奖励代币需要多少usdt
     */
    function _getPrice(address t0,address t1,uint256 amount) private view returns (uint256) {
        address pair = IUniswapFactory(IUniswapRouter02(_router).factory()).getPair(t0, t1);//通过接口获取交易所质押池的地址      
        (uint256 r0, uint256 r1, ) = IUniswapPair(pair).getReserves(); // 获取储备量
        (uint256 reserve0, uint256 reserve1) = (IUniswapPair(pair).token0() ==t0) ? (r0, r1): (r1, r0);   // 看下是哪个换哪个
        return IUniswapRouter02(_router).getAmountOut(amount, reserve0, reserve1); //      
    }

   
    /**
        @dev 拿百分之80的usdt去买奖励代币,并且销毁

     */
    function _autoSwapAndBurn(address token0,address token1,uint256 amountIn,uint256 deadline) private returns (uint256) {
        address[] memory paths = new address[](2);
        paths[0] = token0;    
        paths[1] = token1;
        uint256 out = _getPrice(token0, token1, amountIn);//获取交易所的价格    
        uint256 minOut = out.sub(out.mul(_slippage).div(RATE_PRECISION));//out - out * 200 / 1000   扣去百分之20
        IERC20Meta(token0).approve(_router, amountIn); // 把token0的权限批准给了路由地址           
        // 应该是拿百分之80的usdt购买了奖励代币  并且传入了0地址
        uint256[] memory amounts = IUniswapRouter02(_router).swapExactTokensForTokens(amountIn, minOut, paths, HOLE, deadline);    
        return amounts[amounts.length - 1]; //返回了谁的数量
    }

   
   /**
        @dev 确定等级 等级和代数之间的关系

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
        @dev 分销 把25代的奖励都发给父代  多余的分销费用给_rebateFee
    */
    function _rebate(address account,uint256 value,uint256 hashrate,address tokenAddres) private {
        address referee = _miners[account].referee;//推荐人
        uint256 deepth = _rebateLevels.length;   //deepth = 5
        uint256 use = 0;    
        //  i < 25 
        for (uint256 i = 0; i < _rebateLevels[deepth - 1]; i++) {
            if (referee == address(0)) {
                break;        
            }
            uint256 index = _rebateLevelMap(i);  //{i=0->index=0}  {i=1->index=1} {i=2->index=2}
            //如果推荐人的债券适量达到  {500 * 10*18}  {500*10**18} {1000*10**18}
            if (_miners[referee].hashrate >=_rebateRequireHashrate[index].mul(10**uint256(IERC20Meta(tokenAddres).decimals()))){
                //{佣金=value*200/1000} {佣金=value*150/1000} {佣金=value*120/1000} 
                uint256 commission = value.mul(_rebateRates[i]).div(RATE_PRECISION);    
                _miners[referee].rebateTotal = commission.add(_miners[referee].rebateTotal);//父代加上分销奖励            
                use = commission.add(use);            
                IERC20Meta(_usdt).safeTransfer(referee, commission); //把奖励转给父代
                // 分销信息纪律结构对象   
                RebateInfo memory rebateInfo = RebateInfo({
                    rebateUser: account,            
                    rebateTime: block.timestamp,            
                    rebateAmount: commission,            
                    level: i,            
                    rebateRate: _rebateRates[i]
                });
                _rebateInfos[referee].push(rebateInfo);//加入父类的分销        
            }
            //推销债券数量加上
            _miners[referee].totalHashrate = hashrate.add(_miners[referee].totalHashrate);        
            //去找父类的父类
            referee = _miners[referee].referee;   
        }

        uint256 balance = value.sub(use); //看下用了多少  多的就转给_rebateFee
        IERC20Meta(_usdt).safeTransfer(_rebateFee, balance);
    }


    /**
        @dev 推荐人是0地址和账户为根地址的都不是活跃用户 --------这里有问题
     */
    function _isActive(address account ) private view returns (bool) {
        return _miners[account].referee != address(0) || account == _root;
    }

    /**
        @dev 是否为有效的交易池
     */
    function _isAvailableTokenPool(uint256 index) private view returns (bool) {
        return index < _tokenPools.length;
    }

    /**
        @dev 查这个地址的分销信息   返回有多少次分销记录
     */
    function rebateListNum(address account) public view returns (uint256) {
        return _rebateInfos[account].length;
    }

   /**
        @dev 查分销信息
    */
    function rebateInfo(uint256 start,uint256 end,address account)public view returns (
        uint256[] memory levels, 
        address[] memory users,    
        uint256[] memory rebateValues,    
        uint256[] memory times,    
        uint256[] memory rates)
        {
        //获取所存的分销结构液体数组信息
        RebateInfo[] memory logs = _rebateInfos[account];  
        // 判断是否有数据和输入是否有误
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
        // 像是一个个在导入 
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
        @dev 获取用户地址对应的债券数量
     */
    function getHashrates(address account)public view returns (uint256){
        return _miners[account].hashrate;
    }

   /**
        @dev 查询用户的挖矿奖励数量 -------------这里有问题
    */
    function viewMinting(address account) public view returns (uint256) {
        return _miners[account].bonus;
    }

   /**
        @dev 查询总矿池信息
    */
    function pool()public view returns (uint256 hashrate,uint256 acc,uint256 lastRewardTime,uint256 startTime){
        hashrate = _pool.hashrate;    
        acc = _pool.accBonusPerShare;     
        lastRewardTime = _pool.lastRewardTime;    
        startTime = _pool.startTime;
    }

    /**
        @dev 查询社区池信息
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
        @dev 提现收款地址和费率查询
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
        @dev 查询用户信息
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
        @dev 查询用户的分销关系
     */
    function minerRefer(address account)public view returns (address referee, address[] memory refers){
        Miner memory miner = _miners[account];    
        referee = miner.referee;    
        refers = miner.refers;
    }

   /**
        @dev 将u的父类设置为r 将u加入到r的子类
     */
    function _active(address u, address r) private {
        if (!_isActive(u)) {
            require(_isActive(r), "NxPool: r not active");        
            _miners[u].referee = r;       
            _miners[r].refers.push(u);    
        }
    }

   /**
        @dev 购买  

     */
    function deposit(uint256 index,uint256 token0Value,uint256 deadline,address r) public {
        require(_init, "NxPool: operation not allow");
        require(_isAvailableTokenPool(index), "NxPool: illegal token pool");    
        _active(_msgSender(), r); //设置分销关系
        TokenPool storage tokenPool = _tokenPools[index];       //拿出这个tokenpool 引用传递
        require(tokenPool.token0 == _usdt, "NxPool: not support token0 now"); //token0必须是usdt
        require(token0Value >= _depositAmountMinLimit &&token0Value <= _depositAmountMaxLimit,"NxPool: unavailable amount");//买入数量要在范围之类
        IERC20Meta(tokenPool.token0).safeTransferFrom(_msgSender(),address(this),token0Value);//把这个usdt转到合约地址
        
        if(_isVIP[msg.sender]==false){                      //用户是第一次买入的话  则加入VIP  并加入到社区的用户数组中取
            _isVIP[msg.sender] = true;
            tokenPool.allUsers.push(msg.sender);
        }
    
        uint256 hashrate = token0Value.mul(125).div(100);   //债券的数量 = usdt / 0.8
        tokenPool.hashrate = hashrate.add(tokenPool.hashrate); //社区池的债券数加上
        tokenPool.token0Total = token0Value.add(tokenPool.token0Total); // 社区池usdt的数量加上
        
  
        
        uint256 rebateValue = token0Value.mul(_rebateOcc).div(RATE_PRECISION);//rebateValue = usdt * 200 / 1000    
        
        _rebate(_msgSender(),rebateValue,hashrate,tokenPool.token0); //进行分销
        _miners[_msgSender()].hashrate = hashrate.add(_miners[_msgSender()].hashrate);// 矿工的债券数量加上

        uint256 amountP = token0Value.sub(rebateValue); //amountP = usdt - 分销的
        //自动交易打开的话
        if (_autoSwapFlag && _autoBuyRate > 0) {
            uint256 amountIn = amountP.mul(_autoBuyRate).div(RATE_PRECISION); //amountIn = P * 1000 /1000
            require(_usdt == tokenPool.token0,"NxPool: tokenPool token0 require usdt");       
            _autoSwapAndBurn(tokenPool.token0, _xToken, amountIn, deadline); //进行自动交易并销毁
            //如果还有钱 
            if (IERC20Meta(tokenPool.token0).balanceOf(address(this)) > 0) {
                //把usdt从合约里面转到market
                IERC20Meta(tokenPool.token0).transfer(_market,IERC20Meta(tokenPool.token0).balanceOf(address(this))); 
            }
        }else{
            // 自动交易没开的话  就把百分之80的usdt转到_market
            IERC20Meta(tokenPool.token0).transfer(_market, amountP);    
        }
         _pool.hashrate = hashrate.add(_pool.hashrate);//总池子的债券数量加上
    }

   /**
        @dev 提现
     */
    function claim() public {
        require(!isBlackList(_msgSender()), "NxPool: can not withdraw now, please wait...");       
        uint256 bonus;
        Miner memory miner = _miners[msg.sender];
        //有债券的话才可以提现 
        if (_miners[_msgSender()].hashrate > 0) {
            // bonus = 债券数量 * 总奖励 / 10**19         
            bonus = miner.bonus;//加上之前的奖金
         
            uint256 value = 0;
            uint256 deepth = _claimFeeRates.length;
            for (uint256 i = 0; i < deepth; i++) {
                uint256 fee = bonus.mul(_claimFeeRates[i]).div(RATE_PRECISION);//Fee = bouns * a /  1000          
                value = value.add(fee);            
                IERC20Meta(_xToken).safeTransfer(_claimFeeMarkets[i], fee); //收手续费    
            }

            uint256 balance = bonus.sub(value); //扣除了手续费
            IERC20Meta(_xToken).safeTransfer(_msgSender(), balance);//把奖励代币转给用户
            _miners[_msgSender()].out = _miners[_msgSender()].out.add(bonus); //记录用户的提现量     
            _miners[_msgSender()].bonus = 0; //挖矿奖励重置   
            //rewardDebt = 债券数 * 总奖励 /  10**19
            // _miners[_msgSender()].rewardDebt = _miners[_msgSender()].hashrate.mul(_pool.accBonusPerShare).div(ACC_PRECISION);    
        }
    }


    // 转让债券
    function _transfer(address sender,address recipient,uint256 amount) private {
        require(_enableTransfer, "NxPool: require enable transfer");    
        _active(recipient, sender);      
        _updateMiner(sender, amount, true);    
        _updateMiner(recipient, amount, false);    
        emit Transfer(sender, recipient, amount);
    }

    //债券总发行    
    function totalSupply() public view virtual override returns (uint256) {
        return _pool.hashrate;
    }

    // 查用户债券数量
    function balanceOf(address account)public view virtual override returns (uint256){
        return _miners[account].hashrate;
    }

   //授权
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

    //转让债券    
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

    //转让债券    
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

    //增加提现手续费的扣款项目和费率
    function addClaimFeeRateAndFeeMarket(uint256 claimFeeRate,address claimFeeMarket) public onlyOwner {
        _claimFeeRates.push(claimFeeRate);   
         _claimFeeMarkets.push(claimFeeMarket);
    }

    // 更改手续费收款地址
    function editClaimFeeMarket(uint256 tid,address claimFeeMarket)public onlyOwner{
        require(tid < _claimFeeMarkets.length, "NxPool: unvaliable tid");   
         _claimFeeMarkets[tid] = claimFeeMarket;
    }

    //更改提现手续费 
    function editClaimFee(uint256 tid, uint256 claimFeeRate) public onlyOwner {
        require(tid < _claimFeeRates.length, "NxPool: unvaliable tid");    
        _claimFeeRates[tid] = claimFeeRate;
    }

    function init() public view returns (bool) {
        return _init;
    }

    //初始化矿池
    function initPool(uint256 startTime) public onlyOwner {
        require(!_init, "Pool: operation not allow");    
        _init = true;    
        _pool.startTime = startTime;      
        _pool.lastRewardTime = startTime;
    }

  

    // 增加社区池
    function addToken(address token0,address token1) public onlyOwner {
        require(_init, "NxPool: operation not allow"); 
        address[] memory a;   
        TokenPool memory tokenPool = TokenPool({token0: token0, token1: token1,hashrate: 0,token0Total: 0,token1Total: 0,allUsers:a});    
        _tokenPools.push(tokenPool);
    }

  

    function autoBuyRate() public view returns (uint256) {
        return _autoBuyRate;
    }

    // 自动买的费率   可以控制自动买多少
    function setAutoBuyRate(uint256 autoBuyRate_) public onlyOwner {
        _autoBuyRate = autoBuyRate_;
    }

    function depositAmountLimit()public view returns (uint256 min, uint256 max){
            min = _depositAmountMinLimit;    max = _depositAmountMaxLimit;
    }

   
    function setDepositAmountLimit(uint256 min, uint256 max) public onlyOwner{
        _depositAmountMinLimit = min;    _depositAmountMaxLimit = max;
    }

 






    // // 看能买到多少债券么
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

    // 修改分销的 等级 手续费率 达标情况
    function setReatesInfo(uint256[] memory rh,uint256[] memory rl,uint256[] memory rr) public onlyOwner {
        require(rh.length == rl.length, "NxPool: rh == rl");    
        require(rr.length == rl[rl.length - 1], "NxPool: rr length illegal");    
        _rebateRequireHashrate = rh;    
        _rebateLevels = rl;    
        _rebateRates = rr;
    }

    // 查什么
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
