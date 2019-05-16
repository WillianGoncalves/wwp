<template>
  <div class="section-title" :class="{'bordered': bordered}">
    <slot></slot>
  </div>
</template>

<script lang="coffee">
export default
  props:
    bordered:
      type: Boolean
</script>

<style scoped lang="sass">
@import '../../../assets/stylesheets/variables/colors';

.section-title
  display: flex
  justify-content: center
  padding-bottom: 10px
  margin: 3em 0 1em 0
  text-transform: uppercase
  letter-spacing: 3px
  font-family: 'Unica One', cursive;
  font-size: 1rem

  &.bordered
    border-bottom: 1px
    border-bottom-color: $border-color
    border-bottom-style: solid
</style>
