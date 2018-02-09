<template>
  <ul class="collection">
    <draggable v-model="selectedSongs" @end="$emit('updateSongsOrder', selectedSongs)">
      <li class="collection-item" v-for="song in selectedSongs">
        <span class="song-index">{{ indexOf(song) }}</span>
        {{ song.title }}

        <span v-if="song.author" class="light-text"><small> - {{ song.author }}</small></span>

        <a class="secondary-content" @click="$emit('unselectSong', song)" href="#!">
          <i class="material-icons dark-icon tiny">delete</i>
        </a>
      </li>
    </draggable>
  </ul>
</template>

<script lang="coffee">
import draggable from 'vuedraggable'

export default
  props:
    songs:
      type: Array
      required: true
  data: ->
    selectedSongs: @songs
  components:
    'draggable': draggable
  methods:
    indexOf: (song) ->
      @selectedSongs.indexOf(song) + 1
</script>

<style scoped lang="sass?indentedSyntax">
.collection-item
  &:hover
    cursor: grab
  &:active
    cursor: grabbing
</style>
