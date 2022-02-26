<template>
  <div class="index-container">
    <div class="search">
      <input type="text" placeholder="Enter the coin to search for" />
    </div>
    <div class="mid">
      <div class="mid-left">
        <span class="rt-text">Information</span>
        <div class="center-content">
          <span class="text1">Mining(DAC)</span>
          <span class="text2">0.0000000</span>
          <button class="info_btn">Withdraw</button>
        </div>
      </div>
      <div class="mid-right">
        <div>
          <span>0.0000</span>
          <span>Hashrate</span>
        </div>
        <div>
          <span>0.0000</span>
          <span>Hashrate</span>
        </div>
        <div>
          <span>0.0000</span>
          <span>Hashrate</span>
        </div>
      </div>
    </div>
    <div class="footer">
      <div class="top">
        <span>
          75%USDT+25%BNN
        </span>
        <button @click="isShowPop = true">Exchange</button>
      </div>
      <div class="center">
        <div class="header">
          <img src="" alt="">
          <img src="" alt="">
          <span>USDT/BNN</span>
        </div>
        <div class="divider"></div>
        <div class="main">
          <div>
            <span>Destroy</span>
            <span>373958.01/124652.61</span>
          </div>
          <div>
            <span>Proportion</span>
            <span>1:1,00</span>
          </div>
          <div>
            <span>Hashrate</span>
            <span>4986410.68</span>
          </div>
        </div>
      </div>
      <div class="bottom">
        <div>Contract Address</div>
        <div>1121221212122255</div>
      </div>
    </div>
    <PopWin :isShow.sync='isShowPop'></PopWin>
  </div>
</template>

<script>
import PopWin from './childCpns/popWin/PopWin.vue'

export default {
  name: "WpProjectIndex",
  components:{
    PopWin
  },
  data() {
    return {
      isShowPop:false,//弹窗开关
    };
  },

  mounted() {},

  methods: {},
};
</script>

<style lang="scss" scoped>
.index-container {
  .search {
    width: 1320px;
    margin: 0 auto;
    input {
      width: calc(100% - 140px);
      height: 70px;
      border: 2px solid rgba(39, 204, 255, 0.76);
      border-radius: 10px;
      background-image: url("./imgs/search.png");
      background-repeat: no-repeat;
      background-position: 70px 20px;
      padding-left: 140px;
      font-size: 24px;
    }
    input:focus {
      outline: none;
      border: 2px solid rgba(39, 204, 255, 0.76);
    }
    ::-webkit-input-placeholder {
      color: #999999;
      font-family: "Microsoft Yahei";
      font-size: 24px;
    }
  }
  .mid{
    padding-top: 20px;
    width: 1320px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    .mid-left{
      position: relative;
      width: 33%;
      height: 337px;
      background-image: url('./imgs/index_bg1.png');
      background-size: contain;
      background-repeat: no-repeat;
      .rt-text{
        position: absolute;
        top: 3%;
        right: 5%;
        font-size: 18px;
        color: #ffffff;
      }
      .center-content{
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: space-evenly;
        .text1{
          font-size: 30px;
          color: #333333;
          font-weight: bold;
        }
        .text2{
          font-size: 60px;
          color:#4092f4;
          font-weight: bold;
        }
        .info_btn{
          width: 45%;
          height: 40px;
          border: 1px solid #27ccff;
          border-radius: 20px;
          background-color: #4092f4;
          font-size: 24px;
          font-weight: bold;
          color: #fff;
        }
      }
    }
    .mid-right{
      display: flex;
      width: 67%;
      justify-content: flex-end;
      div{
        width: 233px;
        height: 337px;
        margin-left: 50px;
        background-image: url('./imgs/index_bg2.png');
        background-repeat: no-repeat;
        background-size: contain;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: space-between;
        span:nth-child(1){
          margin-top: 125px;
          font-size: 36px;
          font-weight: bold;
          color: #fff;
        }
        span:nth-child(2){
          font-size: 24px;
          color: #333333;
        }
      }      
    }
  }
  .footer{
    width: 1320px;
    height: 420px;
    margin: 0 auto;
    margin-top: 20px;
    background-image: url('./imgs/index_bg3.png');
    background-repeat: no-repeat;
    background-size: contain;
    .top{
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 32px 70px;
      span{
        font-size: 24px;
        font-weight: bold;
        color: #333333;
      }
      button{
        width: 150px;
        height: 40px;
        background-color: #4092f4;
        border: 1px #27ccff solid;
        border-radius: 20px;
        font-size: 20px;
        color: #fff;
      }
    }
    .center{
      width: 1240px;
      height: 216px;
      margin: 0 auto;
      background-color: #4092f4;
      border-radius: 10px;
      box-sizing: border-box;
      padding: 0 30px;
      .header{
        padding: 20px 0;
        display: flex;
        align-items: center;
        img{
          width: 36px;
          height: 36px;
        }
        span{
          margin-left: 15px;
          font-size: 18px;
          font-weight: bold;
          color: #fff;
        }
      }
      .divider{
        width: 1180px;
        height: 1px;
        background-color: rgba(255,255,255,0.5);
      }
      .main{
        display: flex;
        justify-content: space-between;
        div{
          height: 110px;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          span:nth-child(1){
            font-size: 18px;
            font-weight: bold;
            color: #fff;
            margin-top: 20px;
          }
          span:nth-child(2){
            font-size: 16px;
            color: #fff;
          }
        }
      }
    }
    .bottom{
      width: 1240px;
      margin: 0 auto;
      padding: 40px 0 0 30px;
      div{
        font-size: 16px;
        color: #999999;
      }
    }
  }
}
</style>