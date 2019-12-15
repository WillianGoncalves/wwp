<template>
  <div>
    <songs-list-filter v-on:changed="filter" ref="textFilter"></songs-list-filter>
    <songs-list-tags-filter :tags="tags" v-on:changed="filter" ref="tagsFilter"></songs-list-tags-filter>
  </div>
</template>

<script lang="coffee">
import { mapGetters } from 'vuex';
import SongsListFilter from './songs_list_filter.vue';
import SongsListTagsFilter from './songs_list_tags_filter.vue';

export default
  props:
    songs:
      type: Array
      required: true

  components:
    'songs-list-filter': SongsListFilter
    'songs-list-tags-filter': SongsListTagsFilter

  computed: mapGetters(['tags'])

  mounted: ->
    @filter()

  methods:
    filter: ->
      filteredSongs = @$refs.textFilter.filter(@songs)
      filteredSongs = @$refs.tagsFilter.filter(filteredSongs)
      @.$emit('filtered', filteredSongs)
</script>
