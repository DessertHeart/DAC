<template>
  <div class="pop-withdraw" v-show="isShow">
    <div class="img-container">
      <img @click="close" src="../imgs/close.png" alt="">
    </div>    
    <h3>Please enter the withdrawal amount</h3>
    <input type="text">
    <div class="tip">Please enter less than the number of rewards you have in the pool</div>
    <div class="btns">
      <button @click="close">Cancel</button>
      <button @click="handle">Determine</button>
    </div>    
  </div>
</template>

<script>
export default {
  name: 'WpSmallTeamProjectMasterPopwithdraw',
  props:{
    isShow:Boolean
  },
  data() {
    return {
      
    };
  },

  mounted() {
    
  },

  methods: {
    close(){
      this.$emit('update:isShow',false)
    },
    handle(){
      //处理提交
      this.close();
    }
  },
};
</script>

<style lang="scss" scoped>
.pop-withdraw{
  padding: 20px 40px;
  width: 900px;
  background-color: #fff;
  position: fixed;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
  z-index: 101;    
  border-radius: 20px;
  .img-container{
    height: 30px;
    img{
      float: right;
    }
    img:hover{
      cursor: pointer;
    }
  }
  h3{
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    color: #333;
  }
  input{
    margin-top: 40px;
    width: 100%;
    height: 50px;
    background-color: #f6f6f6;
    border-radius: 8px;
    border: none;
    font-size: 20px;
    color: #ccc;
  }
  .tip{
    padding-top: 10px;
    color: #999;
  }
  .btns{
    display: flex;
    justify-content: space-between;
    padding-top: 50px;
    button{
      width: 300px;
      height: 50px;
      border-radius: 30px;
    }
  }
}
</style>