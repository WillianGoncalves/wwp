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
      :click-handler="clickHandler">
    </paginate>
  </div>
</template>

<script lang="coffee">
import paginate from 'vuejs-paginate'

export default
  props:
    pageCount:
      type: Number
      required: true
    currentPage:
      type: Number
      required: true
      default: 1

  components:
    'paginate': paginate

  data: ->
    page: @currentPage

  methods:
    clickHandler: (page) ->
      $('#page').val(page)
      $('#songs_list_form').submit()
</script>
