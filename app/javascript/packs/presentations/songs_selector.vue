<template>
  <div>
    <div class="row">
      <div class="input-field col s12">
        <i class="material-icons prefix">search</i>
        <input id="search" type="text" v-model="searchFor">
      </div>
    </div>

    <ul class="collection">
      <li class="collection-item" v-for="song in songs">
        {{ song.title }}

        <span v-if="song.author" class="grey-text text-lighten-1 author"> - {{ song.author }}</span>

        <i class="material-icons tiny secondary-content tag" v-for="tag in song.tags" :style="{ color: tag.color }">local_offer</i>
      </li>
    </ul>
  </div>
</template>

<script lang="coffee">
export default
  props:
    groupid:
      type: Number
      required: true

  data: ->
    searchFor: ''
    songs: []

  methods:
    listSongs: ->
      $.get "/groups/#{@groupid}/songs.json", (data) =>
        @songs = @_songs = data

  watch:
    searchFor: ->
      @songs = @_songs.filter (song) =>
        song.title.toLowerCase().includes(@searchFor.toLowerCase())

  created: ->
    @listSongs()

</script>

<style scoped lang="sass?indentedSyntax">
.author
  font-size: 0.7rem

.tag
  margin-top: 6px
</style>
