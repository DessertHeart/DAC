<template>
  <div class="Dao">
    <div class="top">
      <div class="title">
        <img src="" alt="">
        <div>
          <div>DAO</div>
          <div>LAUNCHER</div>
        </div>
      </div>
      <div class="divider"></div>
      <div class="main">
        <div>
          <p>Token Contract</p>
          <p>Debenture Address</p>
          <p>Open Source Status</p>
          <p>Total Issue</p>
          <p>BDCHold Address</p>
        </div>
        <div>
          <p>0xeA47...3b0A72>></p>
          <p>0xeA47...3b0A72>></p>
          <p>Open Sourced</p>
          <p>1,500,000,000</p>
          <p>Get>></p>
        </div>
      </div>
    </div>
    <div class="bottom">
      <div class="title">
        <div>
          <p class="text1">Liquidity Pool</p>
          <p class="text2">$615.450</p>
        </div>
        <button>Lock Query</button>
      </div>
      <div class="main">
        <div class="content1">
          <div>
            <img src="" alt=""><span>USDT</span>
            <p>307720.1004</p>
          </div>
          <div>
            <img src="" alt=""><span>DLC</span>
            <p>15980.1004</p>
          </div>
        </div>
        <div class="divider mt16"></div>
        <div class="content2">
          <div>
            <p>Daily Production/DLC</p>
            <p>151</p>
          </div>
          <div>
            <p>Pool Contract/DLC</p>
            <p>2093094.4076</p>
          </div>
        </div>
        <div class="divider"></div>
        <div class="content3">
          <div>
            <p>Circulation/DLC</p>
            <p>3727.5652</p>
          </div>
          <div>
            <p>Destroyed Quantity/DLC</p>
            <p>3178.0270</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'WpSmallTeamProjectMasterDao',

  data() {
    return {
      
    };
  },

  mounted() {
    
  },

  methods: {
    
  },
};
</script>

<style lang="scss" scoped>
  .Dao{
    .top{
      padding: 0 55px;
      margin: 0 auto;
      width: 1210px;
      height: 320px;
      background-color: #4092f5;
      border-radius: 10px;
      .title{
        padding-top: 15px;
        display: flex;
        align-items: center;
        img{
          width: 80px;
          height: 80px;
        }
      }
      .divider{
        margin-top: 15px;
        height: 1px;
        background-color: rgba(255,255,255,0.5);
      }
      .main{
        display: flex;
        justify-content: space-between;
        padding-top: 10px;
        div:nth-child(1){
          font-weight: bold;
        }
        div>p{
          height: 35px;
          line-height: 35px;
          color: #fff;
        }
        div:nth-child(2)>p{
          text-align: right;
        }
      }
    }
    .bottom{
      padding-top: 40px;
      width: 1320px;
      height: 420px;
      margin: 0 auto;
      margin-top: 40px;
      background-image: url('@/assets/imgs/index_bg3.png');
      background-size: contain;
      background-repeat: no-repeat;
      .title{
        margin: 0 auto;
        width: 1180px;
        height: 110px;
        background-color: #4092f5;
        border-radius: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        div{
          padding-left: 20px;
          .text1{
            font-size: 20px;
            font-weight: bold;
            color: #fff;
            height: 50px;
            line-height: 50px;
          }
          .text2{
            font-size: 30px;
            font-weight: bold;
            color: #fff;
            height: 50px;
            line-height: 50px;
          }
        }      
        button{
          margin-right: 20px;
          width: 140px;
          height: 40px;
          background-color: #4092f5;
          font-size: 20px;
          color: #fff;
          border: 1px solid #36a8f8;
          border-radius: 20px;
        }  
      }
      .main{
        width: 1100px;
        margin: 0 auto;
        padding-top: 40px;
        .content1,.content2,.content3{
          padding: 0 30px;
        }
        .content1{
          display: flex;
          justify-content: space-between;
          img{
            width: 40px;
            height: 40px;
          }
          span{
            display: inline-block;
            font-size: 24px;
            padding-left: 15px;
            transform: translateY(-50%);
          }
          p{
            padding-top: 10px;
            font-weight: bold;
            font-size: 20px;
          }
        }
        .content2,.content3{
          display: flex;
          justify-content: space-between;
          padding-top: 10px;
          div>p{
            text-align: center;
          }
          div>p:nth-child(2){
            font-weight: bold;
            height: 30px;
            line-height: 30px;
          }
        }
        .divider{
          height: 1px;
          background-color: #94c2f9;
        }
      }
    }
  }
</style>