<template>
  <div class="comment">
    <div class="main-content" v-if="!showEditForm">
      <slot name="showView"></slot>

      <button class="btn-floating transparent no-shadow" v-if="showOptions" @click="showEditForm = true">
        <i class="material-icons dark-icon">edit</i>
      </button>
    </div>

    <div class="right-align" v-if="showEditForm">
      <button class="btn-flat" @click="showEditForm = false">
        <i class="material-icons dark-icon">close</i>
      </button>
    </div>

    <slot name="form" v-if="showEditForm"></slot>
  </div>
</template>

<script lang="coffee">
export default
  data: () ->
    showEditForm: false
    showCommentMenu: false
  props:
    showOptions:
      type: Boolean
      required: true
</script>

<style scoped lang="sass?indentedSyntax">
.comment
  margin: 10px 0

.main-content i
  font-size: 1rem
</style>
