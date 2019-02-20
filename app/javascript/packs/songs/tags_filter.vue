<template>
  <div id="tags_container">
    <button type="button" class="btn-flat-bordered tag-filter" v-for="tag in tags" @click="toggleTagFilter(tag.id)" :class="{'inactive': !tagFilterIsActive(tag.id)}">
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
    selectedTags: []

  methods:
    toggleTagFilter: (tagId) ->
      if @tagFilterIsActive(tagId)
        @selectedTags.splice(@selectedTags.indexOf(tagId), 1)
      else
        @selectedTags.push(tagId)
      @updateHiddenValue()

    tagFilterIsActive: (tagId) ->
      @selectedTags.includes(tagId)

    updateHiddenValue: ->
      $('#tags_ids').val(@selectedTags)
</script>

<style scoped lang="sass">
@import '../../../assets/stylesheets/variables/colors';

#tags_container
  display: flex
  flex-wrap: wrap
  justify-content: center

.tag-filter
  margin: 10px
  color: $color
  border-radius: 90px

.inactive
  filter: grayscale(1)
</style>
