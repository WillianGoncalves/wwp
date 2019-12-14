<template>
  <div class="input-field">
    <input id="search" type="text" v-model="textFilter" :placeholder="$t('songs.index.titleOrAuthor')">
  </div>
</template>

<script lang="coffee">
export default
  data: ->
    textFilter: ''

  watch:
    textFilter: ->
      @.$emit('changed')

  methods:
    filter: (songs) ->
      if @textFilter.length == 0
        filteredSongs = songs
      else
        filteredSongs = songs.filter (song) =>
          song.title.toLowerCase().includes(@textFilter.toLowerCase()) ||
              song.author.toLowerCase().includes(@textFilter.toLowerCase())
</script>
