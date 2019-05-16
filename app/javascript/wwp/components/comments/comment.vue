<template>
  <div class="comment">
    <avatar :url="comment.commenter.avatar_url" class="avatar"></avatar>

    <div class="body">
      <p :contentEditable="editing" :class="{ 'editable': editing }" ref="editable_body">
        {{ comment.body }}
      </p>

      <comment-kebab-menu
        v-if="canEdit"
        class="menu"
        v-on:edit="edit()"
        v-on:cancel="cancel()"
        v-on:save="save()"
        v-on:destroy="destroy()"
        :editing="editing">
      </comment-kebab-menu>
    </div>

    <div class="comment-info">
      {{ comment.commenter.full_name }} - {{ comment.created_at }}
    </div>
  </div>
</template>

<script lang="coffee">
import Avatar from '../avatar.vue'
import CommentKebabMenu from './comment_kebab_menu.vue'

export default
  data: () ->
    editing: false

  components:
    'avatar': Avatar
    'comment-kebab-menu': CommentKebabMenu

  props:
    comment:
      type: Object
      required: true
    canEdit:
      type: Boolean
      required: true

  methods:
    edit: () ->
      @editing = true
      @trimCommentBody()

    reset: () ->
      @$refs.editable_body.innerHTML = @comment.body

    cancel: () ->
      @editing = false
      @reset()

    save: () ->
      body = @trimCommentBody()
      data = comment: body: body

      $.ajax
        url: "/comments/#{@comment.id}"
        type: 'PUT'
        data: JSON.stringify(data)
        dataType: 'json'
        contentType: 'application/json'
      .done () =>
        @editing = false
        @comment.body = body
      .fail (err) =>
        messages = JSON.parse(err.responseText)
        Materialize.toast(messages, 4000)
        @reset()

    destroy: () ->
      @$root.showModal('#deletion_confirmation_modal_' + @comment.id)

    trimCommentBody: () ->
      @$refs.editable_body.innerHTML = @$refs.editable_body.innerHTML.trim()

</script>

<style scoped lang="sass">
@import '../../../../assets/stylesheets/variables/colors';

$body-padding: 15px

.comment
  display: grid
  grid-template-rows: repeat(2, auto)
  grid-template-columns: max-content 1fr
  grid-template-areas: "avatar body" "avatar info"
  grid-row-gap: 10px
  margin: 30px 0

.avatar
  grid-area: avatar
  margin-right: 20px
  height: 50px
  width: 50px

.body
  grid-area: body
  justify-self: left
  display: flex
  position: relative
  padding: $body-padding
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

  p
    align-self: center
    margin: 0
    text-align: justify
    transition: all .2s linear
    &.editable
      align-self: stretch !important
      background: $primary-color
      padding: $body-padding

  .menu
    margin-left: $body-padding

.comment-info
  grid-area: info
  color: $light-text-color
  font-size: 0.8em
</style>
