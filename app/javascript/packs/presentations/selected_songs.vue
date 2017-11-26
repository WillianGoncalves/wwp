<template>
  <ul class="collection">
    <li class="collection-item" v-for="song in songs">
      {{ song.title }}

      <span v-if="song.author" class="grey-text text-lighten-1 author"> - {{ song.author }}</span>

      <a class="secondary-content" @click="$emit('unselectSong', song)" href="#!">
        <i class="material-icons dark-icon tiny">delete</i>
      </a>
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
.author
  font-size: 0.7rem
</style>
