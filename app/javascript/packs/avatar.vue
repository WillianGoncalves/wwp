<template>
  <img :src="url" class="circle avatar"/>
</template>

<script lang="coffee">
export default
  props: url: String
</script>

<style scoped lang="sass?indentedSyntax">
.avatar
  width: 40px
  height: 40px
</style>
