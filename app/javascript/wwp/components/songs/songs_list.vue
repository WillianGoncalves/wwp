<template>
  <div>
    <songs-list-filter :songs="songs" v-on:filtered="updateFilteredSongs" />

    <div class="collection" v-if="paginatedSongs.length">
      <songs-list-item v-for="song in paginatedSongs" :song="song" />
    </div>

    <songs-list-paginator :songs="filteredSongs" :items-per-page="3" :current-page="1" v-on:paginated="updateList" />

      <div class="center-align" v-if="paginatedSongs.length === 0">
      <p>{{ $t('noResults') }}</p>
    </div>
  </div>
</template>

<script lang="coffee">
import SongsListItem from './songs_list_item.vue';
import SongsListFilter from './songs_list_filter.vue';
import SongsListPaginator from './songs_list_paginator.vue';

export default
  props:
    songs:
      type: Array
      required: true

  data: ->
    filteredSongs: []
    paginatedSongs: []

  components:
    'songs-list-item': SongsListItem
    'songs-list-filter': SongsListFilter
    'songs-list-paginator': SongsListPaginator

  methods:
    updateFilteredSongs: (songs) ->
      @filteredSongs = songs

    updateList: (songs) ->
      @paginatedSongs = songs
</script>
