<template>
  <div class="comment">
    <div class="valign-wrapper" v-if="!showEditForm">
      <avatar :url="comment.commenter.avatar_url"></avatar>

      <div class="body">
        {{ comment.body }}
      </div>

      <button class="btn-floating transparent no-shadow" v-if="currentUserIsCommenter" @click="showCommentMenu = true">
        <i class="material-icons dark-icon">more_vert</i>
      </button>

      <transition name="fade">
        <div class="comment-menu" v-if="currentUserIsCommenter && showCommentMenu">
          <button class="btn-floating transparent no-shadow" @click="showEditForm = true">
            <i class="material-icons dark-icon">edit</i>
          </button>
          <button class="btn-floating transparent no-shadow" @click="openModal()">
            <i class="material-icons dark-icon">delete</i>
          </button>
          <button class="btn-floating transparent no-shadow" @click="showCommentMenu = false">
            <i class="material-icons dark-icon">close</i>
          </button>
        </div>
      </transition>
    </div>

    <div class="right-align" v-if="showEditForm">
      <button class="btn-flat" @click="showEditForm = false">
        <i class="material-icons dark-icon">close</i>
      </button>
    </div>
    <slot name="form" v-if="showEditForm"></slot>
    <slot name="deletion_modal" v-if="currentUserIsCommenter"></slot>
  </div>
</template>

<script lang="coffee">
import Avatar from '../avatar.vue'

export default
  data: () ->
    showEditForm: false
    showCommentMenu: false
  props:
    comment:
      type: Object
      required: true
    currentUser:
      type: Number
      required: true
  components: 'avatar': Avatar
  computed:
    currentUserIsCommenter: () ->
      @currentUser == @comment.commenter.id
  methods:
    openModal: () ->
      partialViewContainer = @$slots.deletion_modal[0]
      modalDiv = partialViewContainer.children[0].elm
      $(modalDiv).modal('open');
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/_colors.scss';

.comment
  margin: 10px 0

.body
  position: relative
  padding: 15px
  border: 1px solid $border-color
  border-radius: 3px
  background-color: $primary-color-light

  &:before
    content: ''
    position: absolute
    top: 18px
    left: -8px
    width: 16px
    height: 16px
    border-color: $border-color
    border-width: 0 0 1px 1px
    border-style: solid
    background-color: $primary-color-light
    transform: rotate(45deg)

.comment-menu > button > i
  font-size: 1rem

.fade-enter-active, .fade-leave-active
  transition: opacity .5s

.fade-enter, .fade-leave-to
  opacity: 0

img
  margin-right: 20px
</style>
