<template>
  <div class="presentation-card">
    <p>
      <span class="day">{{ presentation.day }}</span><span class="month"> / {{ presentation.month }}</span>
    </p>
    <p><span class="center-align icon"><i class="fa fa-clock-o"></i></span> {{ presentation.time }}</p>
    <p><span class="center-align icon"><i class="fa fa-map-marker"></i></span> {{ presentation.local }}</p>
  </div>
</template>

<script lang="coffee">
export default
  props:
    presentation:
      type: Object
      required: true
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/_colors';

.presentation-card
  padding: 10px 20px
  width: 100%
  margin: 10px 0
  border: 1px solid $border-color
  border-radius: 10px
  box-shadow: 0 2px 7px #ddd

  .day 
    font-size: 3rem

  .month
    text-transform: uppercase
    letter-spacing: 2px
    font-size: 0.7rem

  .icon
    display: inline-block
    width: 25px
</style>
