<template>
  <ul class="collection">
    <draggable v-model="reorderableSongs" @end="reorderSelectedSongs(reorderableSongs)">
      <selected-songs-list-item v-for="song in selectedSongs" :song="song"></selected-songs-list-item>
    </draggable>
  </ul>
</template>

<script lang="coffee">
import { mapState, mapMutations } from 'vuex';
import draggable from 'vuedraggable'
import SelectedSongsListItem from './selected_songs_list_item';

export default
  data: ->
    reorderableSongs: []

  components:
    'draggable': draggable
    'selected-songs-list-item': SelectedSongsListItem

  mounted: ->
    @reorderableSongs = @selectedSongs

  computed: mapState(['selectedSongs'])

  methods: mapMutations(['reorderSelectedSongs'])
</script>
