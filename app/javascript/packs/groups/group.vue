<template>
  <div class="col s12 m6">
    <div class="container">
      <p>{{ group.name }}</p>
      <avatar v-for="member in group.members" :key="member.id" :url="member.avatar_url" class="avatar"></avatar>

      <button class="btn enter-button" @click="sendJoinRequest">Entrar</button>
    </div>
  </div>
</template>

<script lang="coffee">
import Avatar from '../avatar.vue'

export default
  props:
    group:
      type: Object
      required: true

  components: 'avatar': Avatar

  methods:
    sendJoinRequest: ->
      $.post "/groups/#{@group.id}/join_requests", { join_request: accepted: null }
      .done (data) =>
        Materialize.toast(data, 4000)
      .fail (err) =>
        messages = JSON.parse(err.responseText)
        Materialize.toast(messages, 4000)
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/_colors';

.container
  position: relative
  padding: 10px 20px
  width: 100%
  margin: 10px 0
  border: 1px solid $border-color
  box-shadow: 0 2px 7px #ddd

.enter-button
  position: absolute
  right: 20px
  top: 20px

.avatar
  width: 32px
  margin-right: 10px
</style>
