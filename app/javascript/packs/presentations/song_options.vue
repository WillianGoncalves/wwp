<template>
  <ul class="collection">
    <li class="collection-item song-option" v-for="song in songs" @click="$emit('selectSong', song)">
      {{ song.title }}

      <span v-if="song.author" class="grey-text text-lighten-1 author"> - {{ song.author }}</span>

      <i class="material-icons tiny secondary-content tag" v-for="tag in song.tags" :style="{ color: tag.color }">local_offer</i>
    </li>
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

.author
  font-size: 0.7rem

.collection-item
  cursor: pointer
  &:hover
    background: $primary-color-dark
</style>
