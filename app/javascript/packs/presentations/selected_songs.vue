<template>
  <ul class="collection">
    <li class="collection-item" v-for="song in songs" @click="$emit('unselectSong', song)">{{ song.title }}</li>
  </ul>
</template>

<script lang="coffee">
export default
  props:
    songs:
      type: Array
      required: true
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/_colors.scss';

.collection-item
  cursor: pointer
  &:hover
    background: $primary-color-dark
</style>
