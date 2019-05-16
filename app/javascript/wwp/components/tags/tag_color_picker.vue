<template>
  <div class="colors-container">
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

<style scoped lang="sass">
@import '../../../../assets/stylesheets/variables/colors';

.colors-container
  display: flex
  flex-direction: row
  justify-content: center
  flex-wrap: wrap

.color
  position: relative
  display: inline-block
  width: 30px
  height: 30px
  margin: 10px
  border-radius: 25px
  cursor: pointer

.active-color
  &:before
    content: ''
    position: absolute
    top: -5px
    left: -5px
    width: 40px
    height: 40px
    border: 1px solid darken($border-color, 15%)
    border-radius: 25px
</style>
