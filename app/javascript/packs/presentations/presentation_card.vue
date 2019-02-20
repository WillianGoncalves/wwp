<template>
  <div class="card">
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

<style scoped lang="sass">
@import '../../../assets/stylesheets/variables/colors';

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
