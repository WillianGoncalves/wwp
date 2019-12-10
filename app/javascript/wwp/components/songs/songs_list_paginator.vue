<template>
  <div class="paginator-container">
    <paginate
      v-model="page"
      :page-count="pageCount"
      :container-class="'paginator'"
      :page-link-class="'page-item'"
      :prev-link-class="'prev-next-item'"
      :prev-text="'chevron_left'"
      :next-link-class="'prev-next-item'"
      :next-text="'chevron_right'"
      :no-li-surround="true"
      :click-handler="paginate">
    </paginate>
  </div>
</template>

<script lang="coffee">
import paginate from 'vuejs-paginate'

export default
  props:
    songs:
      type: Array
      required: true
    itemsPerPage:
      type: Number
      default: 1

  components:
    'paginate': paginate

  data: ->
    page: 1

  computed:
    pageCount: ->
      Math.ceil(@songs.length/@itemsPerPage)

  updated: ->
    @paginate()

  methods:
    paginate: ->
      fromItem = (@page - 1) * @itemsPerPage
      toItem = fromItem + @itemsPerPage
      paginatedSongs = @songs.slice(fromItem, toItem)
      @.$emit('paginated', paginatedSongs)

</script>

<style lang="sass">
@import '../../../../assets/stylesheets/variables/colors';
@import '../../../../assets/stylesheets/typography';

.paginator-container
  display: flex
  justify-content: center

.paginator
  display: flex
  align-items: center
  padding: 10px
  border: 1px solid $border-color
  border-radius: 50px
  background: #fff

.page-item
  padding: 0 15px
  outline: 0

  &.active
    color: $secondary-color

.prev-next-item
  font-family: 'Material Icons'
  font-size: 1.2em
  padding: 0 15px
  outline: 0
</style>
