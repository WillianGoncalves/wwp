<template>
  <i class="material-icons" :style="style" :title="tag.name">local_offer</i>
</template>

<script lang="coffee">
export default
  props:
    tag:
      type: Object
      required: true

  data: ->
    style:
      color: @tag.color.code
</script>

<style scoped lang="sass?indentedSyntax">
.bullet
  width: 10px
  height: 10px
  border-radius: 90px

i
  font-size: 1em
</style>
