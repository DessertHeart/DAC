<template>
  <div class="mask" v-show="isShow" @click="close">
    
  </div>
</template>

<script>
export default {
  name: 'WpSmallTeamProjectMasterPopmask',
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
    }
  },
};
</script>

<style lang="scss" scoped>
  .mask{
    position: fixed;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    background-color: #000;
    opacity: 0.5;
    z-index: 100;
  }
</style>