
// （框架可直接用）APP就是一个json对象，里面定义所有逻辑和待调用的函数 (nodejs代码风格)
App = {
  // 定义两个变量：合约 & web3网络
  web3Provider: null,
  contracts: {},

  // 初始化函数
  init: function() {
    return App.initWeb3();
  },


  // （可直接用）连接Metamask钱包的逻辑，实例化web3对象，依赖为web3.min.js
  initWeb3: async function() {
    // 检查新版MetaMask
    if (window.ethereum) {
      console.info('new metamask version');
      App.web3Provider = window.ethereum;
      try {
        // 请求用户账号授权,await异步调用，若用户未点击，会先继续初始化
        await window.ethereum.enable();
      } catch (error) {
        // 用户拒绝了访问
        console.error("User denied account access")
      }
    }
    // 老版 MetaMask
    else if (window.web3) {
      console.info('old metamask version');
      App.web3Provider = window.web3.currentProvider;
    }
    // 如果没有注入的web3实例，回退到使用Ganache客户端（一个网络提供端口）
    else {
      App.web3Provider = new Web3.providers.HttpProvider('http://127.0.0.1:7545');
    }
      web3 = new Web3(App.web3Provider);

    return App.initContract();
  },


  // 初始化智能合约，依赖jquery.min.js，bootstrap.js，truffle-contract.js
  initContract: function() {
    // jquery $.getJSON用来获取json格式的文件
    // json文件由合约撰写这边生成，直接用即可
    $.getJSON('TutorialToken.json', function(data) {
      // 获取合约实体
      var TutorialTokenArtifact = data;
      // 获取json文件中的合约名词
      App.contracts.TutorialToken = TruffleContract(TutorialTokenArtifact);
      // 配置合约关联的私有链
      App.contracts.TutorialToken.setProvider(App.web3Provider);
      
      return App.getBalances();
    });
  
    console.log('initContract OK');
    return App.bindEvents();
  },


  // 绑定前端的事件，前端事件的触发逻辑在此实现
  bindEvents: function() {
    $(document).on('click', '#transferButton', App.handleTransfer);
  },


  // （可配合实际前端逻辑修改使用）实现转账功能（参考样例，本项目要用到，Jquery语法，可自适应修改）
  handleTransfer: function(event) {
    event.preventDefault();

    // 获取目标账户的地址与转账金额
    var amount = parseInt($('#TTTransferAmount').val());
    var toAddress = $('#TTTransferAddress').val();
    console.log('Transfer ' + amount + ' TT to ' + toAddress);
    // 此变量用来存储实例化的合约
    var tutorialTokenInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }
      // 拿到账户
      var account = accounts[0];
      console.log(account);

        // 通过合约名词实例化智能合约， 还可以通过ABI + address进行实例化
        App.contracts.TutorialToken.deployed().then(function(instance) {
        tutorialTokenInstance = instance;

        // 此处调用合约中对应的转账函数
        return tutorialTokenInstance.transfer(toAddress, amount, {from: account, gas: 100000});
      }).then(function(result) {
        alert('Transfer Successful!');
        return App.getBalances();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  },


  // （可配合实际前端逻辑修改使用）查询余额，更新面板值用到
  getBalances: function() {
    console.log('Getting balances...');

    // 此变量用来存储实例化的合约
    var tutorialTokenInstance;
    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];
      console.log(account);

      App.contracts.TutorialToken.deployed().then(function(instance) {
        tutorialTokenInstance = instance;

        // 此处调用合约中的balanceOf用来实现余额的查询(Jquery语法，可自适应修改)
        return tutorialTokenInstance.balanceOf(account);
      }).then(function(result) {
        console.info(result);
        balance = result.c[0];//result是官方返回的Json格式，c为余额数组
        $('#TTBalance').text(balance);//页面容器显示
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }

};


$(function() {
  $(window).load(function() {
    App.init();
  });
});
