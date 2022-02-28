<template>
  <div class="menu-container">
    <el-drawer
      @close="closeMenu"
      :visible.sync="drawer"
      direction='ltr'
      :with-header="false">
      
      <div class="menu-top">
        <h3>Address</h3>
        <p>2122233111111111132555555555556666666666666666666666666666666666</p>
        <div>
          <img src="./icons/success.png" alt="">
          <span>Connected</span>
        </div>
      </div>
      <div class="menu-list">
        <ul>
          <li @click="goTo(item.isOuter,item.path)" v-for="(item,index) in ulDatas" :key="index"><img :src="item.iconSrc" alt=""><span>{{item.text}}</span><img class="arrow" src="./icons/goto_icon.png" alt=""></li>
        </ul>
      </div>
    </el-drawer>
  </div>
</template>

<script>
export default {
  name: 'WpProjectMenu',
  props:{
    isShow:Boolean
  },
  data() {
    return {
      drawer:false,
      ulDatas:[
        {iconSrc:require('./icons/poor_icon.png'),text:'Poor',path:'/index',isOuter:false},
        {iconSrc:require('./icons/swap_icon.png'),text:'Swap',path:'https://pancakeswap.finance/',isOuter:true},
        {iconSrc:require('./icons/markets_icon.png'),text:'Markets'},
        {iconSrc:require('./icons/chain_icon.png'),text:'Chain'},
        {iconSrc:require('./icons/dao_icon.png'),text:'Dao'},
        {iconSrc:require('./icons/community_icon.png'),text:'Community'},
        {iconSrc:require('./icons/auditReport_icon.png'),text:'Audit Report'},
        {iconSrc:require('./icons/node_icon.png'),text:'Node'},
        {iconSrc:require('./icons/share_icon.png'),text:'Share'},
        {iconSrc:require('./icons/contribution_icon.png'),text:'Contribution'},
        {iconSrc:require('./icons/aboutDao_icon.png'),text:'About Dao'},
        {iconSrc:require('./icons/help_icon.png'),text:'Help'},
      ]
    };
  },
  watch:{
    isShow:function(){
      this.drawer = this.isShow
    }
  },

  mounted() {
    
  },

  methods: {
    closeMenu(){
      this.$emit('update:isShow',false)
    },
    goTo(isOuter,path){
      console.log(isOuter,path);
      if(isOuter){
        window.location.href = path;
      }else{
        this.$router.push({
          path
        })
      }
    }
  },
};
</script>

<style lang="scss" scoped>
  .menu-container{
    ::v-deep .el-drawer__open .el-drawer.ltr{
      width: 400px !important;
    }
    .menu-top{
      width: 360px;
      margin: 10px auto;
      background-color: #4092f4;
      border-radius: 10px;
      h3{
        font-size: 24px;
        color: #fff;
        font-weight: bold;
        padding: 15px 0 0 20px;
      }
      p{
        padding: 18px 20px;
        word-break: break-all;
        font-size: 20px;
        color: #ccc;
      }
      div{
        display: flex;
        justify-content: flex-start;
        align-items: center;
        padding: 12px 20px;
        span{
          padding-left: 20px;
          font-size: 24px;
          color: #03ffe4;
        }
      }
    }
    .menu-list{
      padding: 14px 35px 0 35px;
      ul>li{
        display: flex;
        align-items: center;
        padding-bottom: 10px;
        .arrow{
          margin-left: auto;
        }
        span{
          padding-left: 16px;
          font-size: 24px;
          color: #4092f4;
        }
      }
      ul>li:hover{
        cursor: pointer;
      }
    }
  }
</style>