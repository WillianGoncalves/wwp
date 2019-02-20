<template>
  <ul class="collection">
    <li class="collection-item song-option" v-for="song in songs" @click="$emit('selectSong', song)">
      {{ song.title }}

      <span v-if="song.author" class="light-text"><small> - {{ song.author }}</small></span>

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

<style scoped lang="sass">
@import '../../../assets/stylesheets/variables/colors';
.collection-item
  cursor: pointer
  &:hover
    background: $primary-color-dark

.tag
  margin-top: 6px
</style>
