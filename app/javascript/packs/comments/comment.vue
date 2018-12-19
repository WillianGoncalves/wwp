<template>
  <div>
    <div class="comment">
      <avatar :url="comment.commenter.avatar_url" class="avatar"></avatar>

      <div class="body">
        <p :contentEditable="editing" :class="{ 'editable-body': editing }" ref="editable_body">
          {{ comment.body }}
        </p>

        <div class="menu">
          <button class="btn-floating btn-floating-sm" v-if="canEdit && !editing" @click="edit()">
            <i class="material-icons">edit</i>
          </button>

          <button class="btn-floating-transparent btn-floating-sm" v-if="editing" @click="cancel()">
            <i class="material-icons">close</i>
          </button>

          <button class="btn-floating btn-floating-sm" v-if="editing" @click="save()">
            <i class="material-icons">done</i>
          </button>

          <button class="btn-floating-danger btn-floating-sm" v-if="editing" @click="cancel()">
            <i class="material-icons">delete</i>
          </button>
        </div>
      </div>

      <div class="comment-info">
        {{ comment.commenter.full_name }} - {{ comment.created_at }}
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
import Avatar from '../avatar.vue'

export default
  data: () ->
    editing: false

  components: 'avatar': Avatar

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

    cancel: () ->
      @editing = false
      @$refs.editable_body.innerHTML = @comment.body

    save: () ->
      @comment.body = @trimCommentBody()
      data = comment: body: @comment.body

      $.ajax
        url: "/comments/#{@comment.id}"
        type: 'PUT'
        data: JSON.stringify(data)
        dataType: 'json'
        contentType: 'application/json'
      .done () =>
        @editing = false

    trimCommentBody: () ->
      @$refs.editable_body.innerHTML = @$refs.editable_body.innerHTML.trim()

</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/variables/colors';

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
  .menu
    display: flex
    flex-direction: column
    margin-left: $body-padding
    button:not(:last-child)
      margin-bottom: 10px

.editable-body
  align-self: stretch !important
  background: $primary-color
  padding: $body-padding

.comment-info
  grid-area: info
  color: $light-text-color
  font-size: 0.8em
</style>
