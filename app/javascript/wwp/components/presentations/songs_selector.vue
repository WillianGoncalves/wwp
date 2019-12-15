<template>
  <div>
    <input type="hidden" name="song_ids" id="song_ids" :value="selectedSongsIds" multiple="multiple">

    <transition name="fade" mode="out-in" @enter="initTabs">
      <button type="button" class="btn-floating" @click="showSelector = true" v-if="!showSelector">
        <i class="fa fa-music"></i>
      </button>

      <div v-if="showSelector" class="main-content">
        <button type="button" class="btn-flat menu-item right" @click="showSelector = false">
          <i class="material-icons dark-icon">done</i>
        </button>

        <div class="row">
          <div class="col s12">
            <ul class="tabs">
              <li class="tab col s6"><a href="#all" class="active">{{ $t('presentations.new.all') }}</a></li>
              <li class="tab col s6"><a href="#selected">{{ $t('presentations.new.selected') }} <span class="selectedCounter">{{ selectedSongs.length }}</span></a></li>
            </ul>
          </div>

          <div id="all" class="col s12">
            <songs-list :songs="songs" :on-select-song="selectOrUnselectSong"></songs-list>
          </div>

          <div id="selected" class="col s12">
            <selected-songs />
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script lang="coffee">
import { mapState, mapMutations } from 'vuex';
import M from 'materialize-css';
import SelectedSongs from './selected_songs.vue';
import SongOptions from './song_options.vue';

export default
  props:
    songs:
      type: Array
      required: true
    presentationSongs:
      type: Array

  data: ->
    showSelector: false
    filterBy: 'text'

  mounted: ->
    @setSelectedSongs(@presentationSongs) if @presentationSongs

  computed: {
    mapState(['selectedSongs'])...,
    selectedSongsIds: ->
      @selectedSongs.map (song) => song.id
  }

  components:
    'selected-songs': SelectedSongs
    'song-options': SongOptions

  methods: {
    mapMutations(['selectOrUnselectSong', 'setSelectedSongs'])...,

    initTabs: ->
      tabs = document.querySelectorAll('.tabs')
      M.Tabs.init(tabs)
  }
</script>

<style scoped lang="sass">
@import '../../../../assets/stylesheets/variables/colors';

.main-content
  border: 1px solid $border-color
  padding: 15px

.tag-filter
  margin: 10px
  color: $color
  border-radius: 90px

.menu-item
  padding: 0 1rem

.selectedCounter
  margin-left: 10px
  font-weight: bold

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
