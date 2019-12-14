<template>
  <div>
    <button type="button" class="btn-flat-bordered tag-filter" v-for="tag in tags" @click="toggleTag(tag.id)" :class="{'inactive': !isActive(tag.id)}">
      <i class="material-icons left tiny" :style="{ color: tag.color }">local_offer</i>
      <span>{{ tag.name }}</span>
    </button>
  </div>
</template>

<script lang="coffee">
export default
  props:
    tags:
      type: Array
      required: true

  data: ->
    tagsFilters: []

  watch:
    tagsFilters: ->
      @.$emit('changed')

  methods:
    toggleTag: (tagId) ->
      if @isActive(tagId)
        @tagsFilters.splice(@tagsFilters.indexOf(tagId), 1)
      else
        @tagsFilters.push(tagId)

    isActive: (tagId) ->
      @tagsFilters.includes(tagId)

    filter: (songs) ->
      filteredSongs = songs
      if @tagsFilters.length > 0
        filteredSongs = songs.filter (song) =>
          songTags = song.tags.map (tag) => tag.id
          for tagId in @tagsFilters
            return true if songTags.includes(tagId)
      filteredSongs
</script>

<style scoped lang="sass">
@import '../../../../assets/stylesheets/variables/colors';

.tag-filter
  margin: 10px
  color: $color
  border-radius: 90px

.inactive
  filter: grayscale(1)
</style>
