<template>
  <div>
    <div class="main-menu">
      <button class="btn-floating-transparent btn-floating-sm kebab" @click="toggleMenu()" v-if="!editing">
        <i class="material-icons">more_vert</i>
      </button>

      <div class="popup" :class="{ 'popup-visible': showMenu }">
        <button class="btn-floating btn-floating-sm" @click="enterEditingMode()">
          <i class="material-icons">edit</i>
        </button>

        <button class="btn-floating-danger btn-floating-sm" @click="destroy()">
          <i class="material-icons">delete</i>
        </button>
      </div>
    </div>

    <div class="editing-menu" v-if="editing">
      <button class="btn-floating-transparent btn-floating-sm delayed" @click="leaveEditingMode()">
        <i class="material-icons">close</i>
      </button>

      <button class="btn-floating btn-floating-sm delayed" @click="save()">
        <i class="material-icons">done</i>
      </button>
    </div>
  </div>
</template>

<script lang="coffee">
export default
  data: () ->
    showMenu: false

  props:
    editing:
      type: Boolean
      required: true
      default: false

  methods:
    toggleMenu: () ->
      @showMenu = !@showMenu

    enterEditingMode: () ->
      @$emit('edit')
      @showMenu = false

    leaveEditingMode: () -> 
      @$emit('cancel')

    save: () ->
      @$emit('save')

    destroy: () ->
      @$emit('destroy')
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/variables/colors';

.main-menu
  display: flex
  flex-direction: column
  align-items: center
  position: relative

.editing-menu
  display: flex
  flex-direction: column

.popup
  display: flex
  position: absolute
  top: -6px
  left: 30px
  visibility: hidden
  button
    margin: 5px
    animation: scaleOut .3s
.popup-visible
  visibility: visible
  button
    animation: scaleIn .1s

@keyframes scaleIn
  from { transform: scale(0) }
  to { transform: scale(1) }

@keyframes scaleOut
  from { transform: scale(1) }
  to { transform: scale(0) }
</style>
