<template>
  <div class="col s12 m6 offset-m3 presentation_song_card">
    <div class="ps-index valign-wrapper">
      <b>{{ presentationSong.index }}</b>
    </div>

    <div class="ps-info">
      <p class="ps-title">
        <b>{{ presentationSong.title }}</b>

        <span class="tags">
          <tag v-for="tag in presentationSong.tags" :key="tag.id" :tag="tag"></tag>
        </span>
      </p>

      <p class="ps-author">
        {{ presentationSong.author }}
      </p>
    </div>

    <div class="ps-tone valign-wrapper">
      <b>{{ presentationSong.tone }}</b>
    </div>
  </div>
</template>

<script lang="coffee">
export default
  props:
    presentationSong:
      type: Object
      required: true
</script>

<style scoped lang="sass">
@import '../../../assets/stylesheets/variables/colors';

.presentation_song_card
  display: flex
  margin-bottom: 5px
  border: 1px solid $border-color
  border-radius: 3px

.ps-index, .ps-tone 
  padding: 5px 30px

.ps-info 
  padding: 5px 0

.ps-index, .ps-tone 
  font-size: 1.5rem

.ps-info 
  width: 100%

.tags i
  margin-left: 10px
</style>
