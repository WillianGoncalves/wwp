<template>
  <div class="card">
    <p>
      <span class="day">{{ presentation.day }}</span><span class="month"> / {{ presentation.month }}</span>
    </p>
    <div class="presentation-info">
      <div class="presentation-info__subtitle">Hora</div>
      <div class="presentation-info__content">{{ presentation.time }}</div>
    </div>
    <div class="presentation-info">
      <div class="presentation-info__subtitle">Local</div>
      <div class="presentation-info__content">{{ presentation.local }}</div>
    </div>
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
@import '../../../../assets/stylesheets/variables/colors';

.day
  font-size: 3rem

.month
  text-transform: uppercase
  letter-spacing: 2px
  font-size: 0.8rem

.icon
  display: inline-block
  width: 25px

.presentation-info
  margin-top: 2rem

.presentation-info__subtitle
  text-transform: uppercase
  letter-spacing: 3px
  font-family: 'Unica One', cursive
  font-size: 0.8rem
  margin-bottom: 0.5rem

.presentation-info__content
  overflow: hidden
  text-overflow: ellipsis
  white-space: nowrap
</style>
