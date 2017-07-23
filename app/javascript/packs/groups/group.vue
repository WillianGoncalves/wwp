<template>
  <div class="col s12 m6">
    <div class="card">
      <div class="card-content">
        <span class="card-title">{{ group.name }}</span>
        <avatar v-for="member in group.members" :key="member.id" :url="member.avatar_url" class="avatar"></avatar>
      </div>

      <div class="card-action">
        <button class="btn-flat" @click="sendJoinRequest">Entrar</button>
      </div>
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
.avatar
  margin-right: 10px
</style>
