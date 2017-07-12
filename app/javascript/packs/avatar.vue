<template>
  <img :src="url" class="circle tooltipped" data-position="bottom" data-delay="50" :data-tooltip="tooltip"/>
</template>

<script lang="coffee">
export default
  props:
    url:
      type: String
      required: true
    tooltip:
      type: String
      default: undefined

  mounted: ->
    if (@tooltip) then $('.tooltipped').tooltip() else $('img').removeClass('tooltipped')
</script>
