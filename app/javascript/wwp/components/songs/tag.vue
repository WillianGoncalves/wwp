<template>
  <i class="material-icons tiny" :style="style" :title="tag.name">local_offer</i>
</template>

<script lang="coffee">
export default
  props:
    tag:
      type: Object
      required: true

  computed:
    style: () ->
      color: @tag.color.code
</script>
