<template>
  <div class="song">
    <span class="song-index">{{ song.index }}</span>
    <span class="song-title">{{ song.title }}</span>
    <span class="song-author light-text"><small>{{ song.author }}</small></span>
  </div>
</template>

<script lang="coffee">
export default
  props:
    song:
      type: Object
      required: true
</script>

<style scoped lang="sass">
@import '../../../../../assets/stylesheets/variables/colors';

.song
  display: grid
  grid-template-columns: auto 1fr
  grid-template-areas: "index title" "index author"
  align-items: center
  padding: 10px 0
  border-top: 1px solid $border-color
.song-index
  grid-area: index
  padding: 0 10px
.song-title
  grid-area: title
.song-author
  grid-area: author
</style>
