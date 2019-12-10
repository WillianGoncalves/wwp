<template>
  <div>
    <div class="collection">
      <songs-list-item v-for="song in processedSongs" :song="song" />
    </div>

    <songs-list-paginator :songs="songs" :items-per-page="3" :current-page="1" v-on:paginated="updateList" />
  </div>
</template>

<script lang="coffee">
import SongsListItem from './songs_list_item.vue';
import SongsListPaginator from './songs_list_paginator.vue';

export default
  props:
    songs:
      type: Array
      required: true

  data: ->
    processedSongs: []

  components:
    'songs-list-item': SongsListItem
    'songs-list-paginator': SongsListPaginator

  methods:
    updateList: (songs) ->
      @processedSongs = songs
</script>
