<template>
  <div class="navTop-container">
    <div class="img-container">
      <img src="./imgs/menu.png" @click="isShowMenu = true" alt="">
      <img src="./imgs/en.png" alt="">
    </div>  

    <Menu :isShow.sync="isShowMenu" ></Menu>  
  </div>
</template>

<script>
import Menu from '@/components/menu/Menu.vue'

export default {
  name: 'WpProjectNavtop',
  components:{
    Menu
  },
  data() {
    return {
      isShowMenu:false
    };
  },

  mounted() {
    
  },

  methods: {
    
  },
};
</script>

<style lang="scss" scoped>
  .navTop-container{
    .img-container{
      width: 1320px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      padding: 16px 0;
      img:hover{
        cursor: pointer;
      }
    }
  }
</style>