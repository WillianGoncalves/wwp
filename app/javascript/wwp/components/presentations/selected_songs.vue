<template>
  <ul class="collection">
    <draggable v-model="reorderableSongs" @end="reorderSelectedSongs(reorderableSongs)">
      <li class="collection-item" v-for="song in selectedSongs">
        <span class="song-index">{{ indexOf(song) }}</span>
        {{ song.title }}

        <span v-if="song.author" class="light-text"><small> - {{ song.author }}</small></span>

        <a class="secondary-content" @click="selectOrUnselectSong(song)" href="#!">
          <i class="material-icons dark-icon tiny">delete</i>
        </a>
      </li>
    </draggable>
  </ul>
</template>

<script lang="coffee">
import { mapState, mapMutations } from 'vuex';
import draggable from 'vuedraggable'

export default
  data: ->
    reorderableSongs: []

  components:
    'draggable': draggable

  mounted: ->
    @reorderableSongs = @selectedSongs

  computed: mapState(['selectedSongs'])

  methods: {
    mapMutations(['selectOrUnselectSong', 'reorderSelectedSongs'])...,

    indexOf: (song) ->
      @selectedSongs.indexOf(song) + 1
  }
</script>

<style scoped lang="sass">
.collection-item
  &:hover
    cursor: grab
  &:active
    cursor: grabbing
</style>
