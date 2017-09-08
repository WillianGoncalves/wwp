<template>
  <div>
    <div v-for="color in colors" class="color" :style="{ background: color.code }" @click="selectColor(color.id, $event)" :class="{ 'active-color': isDefaultColor(color.id) }">
    </div>
  </div>
</template>

<script lang="coffee">
export default
  props: ['defaultColor']

  data: () ->
    colors: []
  
  methods:
    listColors: () ->
      $.get '/colors', (data) =>
        @colors = data

    selectColor: (colorId, event) ->
      $('.color.active-color').removeClass 'active-color'
      $(event.currentTarget).toggleClass 'active-color'
      $('#tag_color_id').val colorId

    isDefaultColor: (colorId) ->
      colorId == parseInt(@defaultColor)

  created: ->
    @listColors()    
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/colors';

.color
  position: relative
  display: inline-block
  width: 30px
  height: 30px
  margin-right: 20px

.active-color
  &:before
    content: ''
    position: absolute
    top: -5px
    left: -5px
    width: 40px
    height: 40px
    border: 1px solid $border-color
</style>
