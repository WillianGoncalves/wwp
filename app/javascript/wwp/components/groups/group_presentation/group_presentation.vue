<template>
  <div class="presentation card">
    <div class="presentation-info">
      <div class="presentation-date"> <i class="fa fa-calendar"></i> <span>{{ presentation.date }}</span> </div>
      <div class="presentation-time"> <i class="fa fa-clock-o"></i> <span>{{ presentation.time }}</span> </div>
      <div class="presentation-local"> <i class="fa fa-map-marker"></i> <span>{{ presentation.local }}</span> </div>
    </div>
    <group-presentation-songs :songs="presentation.songs"></group-presentation-songs>
  </div>
</template>

<script lang="coffee">
export default
  props:
    presentation:
      type: Object
      required: true
</script>

<style scoped lang="sass">
@import '../../../../../assets/stylesheets/variables/colors';

.presentation
  background-color: $primary-color-light
  padding: 20px 30px
  z-index: 0

.presentation-info
  margin-bottom: 20px
  div
    display: grid
    align-items: baseline
    grid-template-columns: 32px 1fr
    grid-column-gap: 10px
    padding: 5px 0
    i
      justify-self: center
</style>
