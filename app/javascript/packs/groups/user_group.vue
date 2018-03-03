<template>
  <div class="col s12 m6">
    <a :href="url">
      <div class="card">
        <p>{{ group.name }}</p>
        <avatar v-for="member in group.members" :key="member.id" :url="member.avatar_url" class="avatar"></avatar>
      </div>
    </a>
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

  computed:
    url: ->
      "/groups/" + @group.id
</script>

<style scoped lang="sass?indentedSyntax">
a
  cursor: pointer
  color: inherit

.avatar
  width: 32px
  margin-right: 10px
</style>
