<template>
  <div>
    <div class="header">
      {{ title }}
      <button class="btn-floating transparent no-shadow right" @click="expand = !expand" :class="{ 'arrow-down': !expand }"><i class="material-icons dark-icon">expand_less</i></button>
    </div>

    <transition name="expand">
      <div class="row expandable" v-if="expand">
        <slot></slot>
      </div>
    </transition>
  </div>
</template>

<script lang="coffee">
export default
  props:
    title:
      type: String
      required: true

  data: ->
    expand: true
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/colors';

.header
  padding: 10px 0
  margin-bottom: 10px

.expandable
  max-height: 500px
  overflow: hidden

.expand-enter-active, .expand-leave-active
  transition: max-height .4s

.expand-enter, .expand-leave-to
  max-height: 0

.arrow-down
  transform: rotate(180deg)
  transition-duration: .2s
</style>
