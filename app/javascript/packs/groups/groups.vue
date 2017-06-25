<template>
  <div>
    <div class="header">
      {{ title }}
      <button class="btn-floating btn-flat waves-effect waves-light right" @click="expand = !expand" :class="{ 'arrow-down': !expand }"><i class="material-icons dark-icon">expand_less</i></button>
    </div>
    <transition name="expand">
      <div class="row expandable" v-if="expand">
        <user-group v-if="redirecttogroup" v-for="group in groups" :group="group" :key="group.id"></user-group>
        <group v-if="!redirecttogroup" v-for="group in groups" :group="group" :key="group.id"></group>
      </div>
    </transition>
  </div>
</template>

<script lang="coffee">
import Group from './group.vue'
import UserGroup from './user_group.vue'

export default
  props:
    groups: Array
    title: String
    redirecttogroup: String
  data: ->
    expand: true
  components:
    'group': Group
    'user-group': UserGroup
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
