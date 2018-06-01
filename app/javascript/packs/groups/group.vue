<template>
  <div class="card">
    <p>{{ group.name }}</p>
    <avatar v-for="member in group.members" :key="member.id" :url="member.avatar_url" class="avatar"></avatar>

    <button class="btn enter-button" @click="sendJoinRequest">Entrar</button>
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
.enter-button
  position: absolute
  right: 20px
  top: 20px

.avatar
  width: 32px
  margin-right: 10px
</style>
