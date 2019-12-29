<template>
  <div :class="[isSelected ? 'selected' : '', 'songs-list__item', 'collection-item']">
    <div class="song">
      {{ song.title }}
    </div>

    <div class="author">
      <span class="light-text" v-if="song.author"><small>{{ song.author }}</small></span>
    </div>

    <div class="light-text tone">{{ song.tone }}</div>

    <div class="tags">
      <tag v-for="tag in song.tags" :tag="tag"></tag>
    </div>
  </div>
</template>

<script lang="coffee">
export default
  props:
    song:
      type: Object
      required: true

  computed:
    isSelected: ->
      songsIds = @$store.state.selectedSongs.map (song) => song.id
      songsIds.includes(@song.id)
</script>

<style scoped lang="sass">
@import '../../../../assets/stylesheets/variables/mixins';
@import '../../../../assets/stylesheets/variables/colors';

.songs-list__item
  display: grid !important
  grid-template-columns: auto 1fr auto auto
  grid-template-areas: "song author tags tone"
  grid-column-gap: 10px
  &:hover
    cursor: pointer
    background: $primary-color-dark
  &.selected
    .song
      color: $secondary-color

@include on-small
  .songs-list__item
    grid-template-columns: 1fr auto
    grid-template-rows: 1fr 1fr
    grid-template-areas: "song tone" "author tags"

.song
  grid-area: song
  overflow: hidden
  text-overflow: ellipsis
  white-space: nowrap

.author
  grid-area: author

.tags
  grid-area: tags
  align-self: center

.tone
  grid-area: tone
  text-align: right
</style>
