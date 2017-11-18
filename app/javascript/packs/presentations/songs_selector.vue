<template>
  <div>
    <div class="row">
      <div class="input-field col s12">
        <i class="material-icons prefix">search</i>
        <input id="search" type="text" v-model="searchFor">
      </div>

      <div class="col s12">
        <button type="button" class="btn white tag-filter" v-for="tag in tags" @click="toggleTagFilter(tag.id)" :class="{'inactive': !tagFilterIsActive(tag.id)}">
          <i class="material-icons tiny" :style="{ color: tag.color }">local_offer</i>
          <span>{{ tag.name }}</span>
        </button>
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
    tags: []
    filterByTags: []

  methods:
    listSongs: ->
      $.get "/groups/#{@groupid}/songs.json", (data) =>
        @songs = @_songs = data

    listTags: ->
      $.get "/groups/#{@groupid}/tags.json", (data) =>
        @tags = data

    toggleTagFilter: (tagId) ->
      if @tagFilterIsActive(tagId)
        @filterByTags.splice(@filterByTags.indexOf(tagId), 1)
      else
        @filterByTags.push(tagId)

      if @filterByTags.length == 0
        @songs = @_songs
      else
        @songs = @_songs.filter (song) =>
          tagIds = song.tags.map (tag) => tag.id
          for tagId from @filterByTags
            if tagIds.includes(tagId)
              return true

    tagFilterIsActive: (tagId) ->
      @filterByTags.includes(tagId)

  watch:
    searchFor: ->
      @songs = @_songs.filter (song) =>
        song.title.toLowerCase().includes(@searchFor.toLowerCase())

  created: ->
    @listSongs()
    @listTags()

</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/_colors.scss';

.author
  font-size: 0.7rem

.tag
  margin-top: 6px

.tag-filter
  display: inline-flex
  margin: 10px
  color: $color
  border-radius: 90px

  span
    margin-left: 10px

.inactive
  filter: grayscale(1)
</style>
