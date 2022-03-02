<template>
  <div id="app">
    <NavTop></NavTop>
    <router-view/>
  </div>
</template>

<script>
import NavTop from '@/components/navTop/NavTop.vue'

export default {
  
  components:{
    NavTop
  }
}
</script>

<style lang="scss" scoped>
  #app{
    background-image: url('@/assets/imgs/bg_img.png');
    height: 100%;
  }
</style>

