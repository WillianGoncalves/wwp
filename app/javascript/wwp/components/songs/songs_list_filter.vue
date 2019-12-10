<template>
  <div>
    <div class="input-field">
      <input id="search" type="text" v-model="textFilter">
    </div>
  </div>
</template>

<script lang="coffee">
export default
  props:
    songs:
      type: Array
      required: true

  data: ->
    textFilter: ''

  mounted: ->
    @filter()

  watch:
    textFilter: ->
      @filter()

  methods:
    filter: ->
      if @textFilter.length == 0
        filteredSongs = @songs
      else
        filteredSongs = @songs.filter (song) =>
          song.title.toLowerCase().includes(@textFilter.toLowerCase()) ||
          song.author.toLowerCase().includes(@textFilter.toLowerCase())
      @.$emit('filtered', filteredSongs)
</script>
