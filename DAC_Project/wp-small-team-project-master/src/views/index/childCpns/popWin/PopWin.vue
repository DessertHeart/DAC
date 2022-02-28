<template>
<div class="popwin">
  <div v-show="isShowPop" class="popwin-container">    
    <div class="title">
      <span>75%USDT+25%BNN</span>
      <img @click="closePop" src="./imgs/close.png" alt="">
    </div>
    <div class="header">
      <div class="text">
        <span>USDT</span>
        <span>Balance:0.0000</span>
      </div>
      <div class="imgs">
        <img src="" alt="">
        <img src="" alt="">
      </div>
      <div class="text">
        <span>BNN</span>
        <span>Balance:0.0000</span>
      </div>
    </div>
    <div class="input-container1"> 
      <input type="text">
      <img src="./imgs/plus.png" alt="">
      <input type="text">
    </div>
    <div class="input-container2">
      <div>Inviter</div>
      <input type="text">
    </div>
    <div class="footer">
      <div>
        <span>Live Debenture:</span><span>__.__</span>
      </div>
      <div>
        <span>Hashrate:</span><span>0.000000</span>
      </div>
    </div>
    <div class="btn-container">
      <button class="pop-btn">Approve</button>
    </div>
    
  </div>
  <div class="popwin-mask" @click="closePop" v-show="isShowPop"></div>
</div>
  
</template>

<script>
export default {
  name: 'WpProjectPopwin',
  props:{
    isShow:Boolean
  },
  data() {
    return {
      isShowPop:false,
    };
  },
  watch:{
    isShow:function(){
      this.isShowPop = this.isShow
    }
  },

  mounted() {
    
  },

  methods: {
    closePop(){
      this.isShowPop = false
      this.$emit('update:isShow',false)
    }
  },
};
</script>

<style lang="scss" scoped>
.popwin{
  .popwin-container{
    width: 900px;
    height: 640px;
    background-color: #fff;
    position: fixed;
    left: 510px;
    top: 80px;
    z-index: 101;    
    border-radius: 20px;
    .title{
      font-size: 24px;
      font-weight: bold;
      color: #333333;
      padding: 30px 20px 0 20px;
      display: flex;
      justify-content: space-between;
    }
    .header{
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 65px 40px 0 40px;
      .text{
        display: flex;
        flex-direction: column;
        align-items: center;
        span:nth-child(1){
          font-size: 24px;
          font-weight: bold;
          color: #333333;
        }
        span:nth-child(2){
          font-size: 24px;
          color: #333333;
        }        
      }
      .imgs{
        img{
          width: 80px;
          height: 80px;
        }
      }
    }
    .input-container1{
      padding: 34px 40px 0 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      input{
        width: 300px;
        height: 60px;
        background-color: #f6f6f6;
        border-radius: 8px;
        border: none;
        font-size: 20px;
        color: #cccccc;
      }
    }
    .input-container2{
      padding: 34px 40px 0 40px;
      div{
        font-size: 20px;
        color: #333333;
      }
      input{
        width: 820px;
        height: 60px;
        background-color: #f6f6f6;
        border-radius: 8px;
        border: none;
        font-size: 20px;
        color: #cccccc;
        margin-top: 10px;
      }
    }
    .footer{
      padding: 25px 40px 0 40px;
      &>div{
        margin-top: 15px;
        display: flex;
        justify-content: space-between;
        font-size: 20px;
        color: #333333;
      }
    }
    .btn-container{
      padding: 30px 40px 0 40px;
      .pop-btn{
        width: 820px;
        height: 64px;
        border-radius: 32px;
        background-color: #4092f4;
        border: 1px solid #fff;
        font-size: 24px;
        color: #fff;
      }
    }
    
  }
  .popwin-mask{
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    background-color: #000;
    opacity: 0.5;
    z-index: 100;
  }
}
  
</style>