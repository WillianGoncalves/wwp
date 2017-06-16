<template>
  <div class="row">
    <group v-for="group in groups" :group="group" :key="group.id"></group>
  </div>    
</template>

<script lang="coffee">
import Group from './group.vue'

export default
  props: groups: Array
  components: 'group': Group
</script>

<style scoped lang="sass?indentedSyntax">
</style>
