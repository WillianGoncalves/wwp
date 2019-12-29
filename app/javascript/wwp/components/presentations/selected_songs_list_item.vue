<template>
  <li class="collection-item selected-songs-list__item">
    <div class="song-index">{{ songIndex }}</div>

    <div class="song-title">{{ song.title }}</div>

    <div v-if="song.author" class="light-text song-author"><small>{{ song.author }}</small></div>

    <a class="secondary-content delete-song" @click="selectOrUnselectSong(song)" href="#!">
      <i class="material-icons dark-icon tiny">delete</i>
    </a>
  </li>
</template>

<script lang="coffee">
import { mapState, mapMutations } from 'vuex';

export default
  props:
    song:
      type: Object
      required: true

  computed: {
    mapState(['selectedSongs'])...,
    songIndex: ->
      @selectedSongs.indexOf(@song) + 1
  }

  methods: mapMutations(['selectOrUnselectSong'])
</script>

<style scoped lang="sass">
@import '../../../../assets/stylesheets/variables/mixins';

.selected-songs-list__item
  display: grid
  grid-template-areas: "index title author actions"
  grid-template-columns: auto auto 1fr auto

  &:hover
    cursor: grab
  &:active
    cursor: grabbing

  .song-index
    grid-area: index

  .song-title
    grid-area: title
    margin-right: 10px
    overflow: hidden
    text-overflow: ellipsis
    white-space: nowrap

  .song-author
    grid-area: author
    &:before
      content: '-'
      margin-right: 10px

  .delete-song
    grid-area: actions

@include on-small
  .selected-songs-list__item
    display: grid
    grid-template-areas: "index title actions" "index author actions"

    .song-index
      align-self: center

    .song-author
      &:before
        content: ''
        margin-right: 0

    .delete-song
      align-self: center
      justify-self: end
</style>
