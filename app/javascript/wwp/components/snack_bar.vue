<template>
  <transition name="fade">
  <div class="card" :class="typeClass" v-if="openned">
    <div class="content">
      <slot></slot>
    </div>
    <button type="button" @click="close" class="btn-floating-transparent btn-floating-sm">
      <i class="tiny material-icons">close</i>
    </button>
  </div>
  </transition>
</template>

<script lang="coffee">
export default
  props:
    type:
      type: String
      default: 'notice'
  data: () ->
    openned: true
  methods:
    close: () ->
      @openned = false

  computed:
    typeClass: () ->
      'snack-bar--' + @type
</script>

<style scoped lang="sass">
@import '../../../assets/stylesheets/variables/colors';

.card
  display: flex
  &.snack-bar--alert
    background: $alert-background-color
  &.snack-bar--error
    background: $error-background-color

.content
  flex: 1
  align-self: center

.fade-enter-active, .fade-leave-active
  transition: opacity .5s

.fade-enter, .fade-leave-to
  opacity: 0
</style>
