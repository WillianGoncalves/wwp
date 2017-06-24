<template>
  <a :href="url">
    <div class="col s12 m6">
      <div class="card">
        <div class="card-content">
          <span class="card-title">{{ group.name }}</span>
          <avatar v-for="member in group.members" :url="member.avatar_url" class="avatar"></avatar>
        </div>
      </div>
    </div>
  </a>
</template>

<script lang="coffee">
import Avatar from '../avatar.vue'

export default
  props: group: Object
  components: 'avatar': Avatar
  computed:
    url: ->
      "/groups/" + this.group.id
</script>

<style scoped lang="sass?indentedSyntax">
a
  cursor: pointer
  color: inherit

.avatar
  margin-right: 10px
</style>
