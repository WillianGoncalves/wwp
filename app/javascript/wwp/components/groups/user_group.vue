<template>
  <a :href="url" class="group">
    <div class="card">
      <p class="group__name">{{ group.name }}</p>
      <avatar v-for="member in group.members" :key="member.id" :url="member.avatar_url" class="group__member"></avatar>
    </div>
  </a>
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

<style scoped lang="sass">
a
  cursor: pointer
  color: inherit

.group__member
  width: 32px
  margin-right: 10px
</style>
