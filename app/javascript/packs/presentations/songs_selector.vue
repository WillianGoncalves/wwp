<template>
  <div>
    <selected-songs :songs="selectedSongs" v-on:unselectSong="unselectSong" v-on:updateSongsOrder="updateSongsOrder" v-if="selectedSongs.length > 0"></selected-songs>

    <transition name="fade" mode="out-in">
      <button type="button" class="btn-floating" @click="showSelector = true" v-if="!showSelector">
        <i class="fa fa-music"></i>
      </button>

      <div v-if="showSelector" class="main-content">
        <div>
          <button type="button" class="btn-flat menu-item waves-effect" @click="filterBy = 'text'">
            <i class="material-icons dark-icon">title</i>
          </button>
          <button type="button" class="btn-flat menu-item waves-effect" @click="filterBy = 'tags'">
            <i class="material-icons dark-icon">local_offer</i>
          </button>
          <button type="button" class="btn-flat menu-item right" @click="showSelector = false">
            <i class="material-icons dark-icon">done</i>
          </button>
        </div>

        <transition name="slide-fade" mode="out-in">
          <div class="input-field" v-if="filterBy == 'text'" key="textFilter">
            <i class="material-icons prefix">search</i>
            <input id="search" type="text" v-model="textFilter">
          </div>

          <div v-else key="tagsFilter">
            <button type="button" class="btn-flat-bordered tag-filter" v-for="tag in tags" @click="toggleTagFilter(tag.id)" :class="{'inactive': !tagFilterIsActive(tag.id)}">
              <i class="material-icons left tiny" :style="{ color: tag.color }">local_offer</i>
              <span>{{ tag.name }}</span>
            </button>
          </div>
        </transition>

        <song-options :songs="songs" v-on:selectSong="selectSong"></song-options>
      </div>
    </transition>
  </div>
</template>

<script lang="coffee">
import SelectedSongs from './selected_songs.vue';
import SongOptions from './song_options.vue';

export default
  props:
    groupid:
      type: Number
      required: true

  data: ->
    textFilter: ''
    songs: []
    tags: []
    tagsFilter: []
    selectedSongs: []
    showSelector: false
    filterBy: 'text'

  components:
    'selected-songs': SelectedSongs
    'song-options': SongOptions

  methods:
    listSongs: ->
      $.get "/groups/#{@groupid}/songs.json", (data) =>
        @songs = @_songs = data
        @loadPresentationSongs()

    listTags: ->
      $.get "/groups/#{@groupid}/tags.json", (data) =>
        @tags = data

    toggleTagFilter: (tagId) ->
      if @tagFilterIsActive(tagId)
        @tagsFilter.splice(@tagsFilter.indexOf(tagId), 1)
      else
        @tagsFilter.push(tagId)

    tagFilterIsActive: (tagId) ->
      @tagsFilter.includes(tagId)

    selectSong: (song) ->
      return if @selectedSongs.includes(song)
      @selectedSongs.push(song)
      @updateHiddenValue()

    unselectSong: (song) ->
      index = @selectedSongs.indexOf(song)
      @selectedSongs.splice(index, 1)
      @updateHiddenValue()

    updateHiddenValue: ->
      stringIds = @selectedSongs.map((song) => song.id)
      $('#song_ids').val(stringIds)

    updateSongsOrder: (reorderedSongs) ->
      @selectedSongs = reorderedSongs
      @updateHiddenValue()

    loadPresentationSongs: ->
      hiddenContent = $('#song_ids').val()
      return if hiddenContent.length == 0
      songIds = hiddenContent.split(',').map ((id) => parseInt(id))
      for songId in songIds
        for song in @_songs
          if song.id == songId
            @selectedSongs.push(song)
            break

  watch:
    textFilter: ->
      @songs = @_songs.filter (song) =>
        song.title.toLowerCase().includes(@textFilter.toLowerCase())

    tagsFilter: ->
      if @tagsFilter.length == 0
        @songs = @_songs
      else
        @songs = @_songs.filter (song) =>
          tagIds = song.tags.map (tag) => tag.id
          for tagId in @tagsFilter
            return true if tagIds.includes(tagId)

  created: ->
    @listSongs()
    @listTags()

</script>

<style scoped lang="sass">
@import '../../../assets/stylesheets/variables/colors';

.main-content
  border: 1px solid $border-color
  padding: 15px

.tag-filter
  margin: 10px
  color: $color
  border-radius: 90px

.inactive
  filter: grayscale(1)

.menu-item
  padding: 0 1rem

.fade-enter-active, .fade-leave-active
  transition: opacity .2s

.fade-enter, .fade-leave-to
  opacity: 0

.slide-fade-enter-active
  transition: all .1s ease

.slide-fade-leave-active
  transition: all .1s cubic-bezier(1.0, 0.5, 0.8, 1.0)

.slide-fade-enter, .slide-fade-leave-to
  transform: translateX(10px)
  opacity: 0
</style>
