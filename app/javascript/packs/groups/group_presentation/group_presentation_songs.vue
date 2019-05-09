<template>
  <div class="group-presentation-songs">
    <transition name="accordion">
      <div class="expandable" v-if="expanded">
        <group-presentation-songs-item v-for="song in songs" :key="song.index" :song="song"></group-presentation-songs-item>
      </div>
    </transition>
    <button class="toggle" v-on:click="expanded = !expanded" v-bind:class="{ 'toggle-active': expanded }"> <i class="fa fa-chevron-down"></i> </button>
  </div>
</template>

<script lang="coffee">
export default
  props:
    songs:
      type: Array
      required: true
  data: () ->
    expanded: false
</script>

<style scoped lang="sass">
@import '../../../../assets/stylesheets/variables/colors';
@import '../../../../assets/stylesheets/variables/mixins';

$accordion-animation-time: .4s
$flip-animation-time: .5s

.group-presentation-songs
  display: flex
  flex-direction: column

.toggle
  position: relative
  align-self: center
  border: none
  width: 30px
  height: 30px
  border-radius: 50%
  background: $primary-color-light
  i
    transition: transform $flip-animation-time

.toggle-active
  i
    transform: rotateX(180deg)

.expandable
  overflow: hidden
  transition: max-height $accordion-animation-time ease-out
  padding: 0 20px
  @include on-small
    padding: 0

.accordion-enter-active, .accordion-leave-active
  max-height: 500px

.accordion-enter, .accordion-leave-to
  max-height: 0
</style>
