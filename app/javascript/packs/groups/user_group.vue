<template>
  <div class="col s12 m6">
    <a :href="url">
      <div class="group-container">
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
@import '../../../assets/stylesheets/modules/_colors';

.group-container
  padding: 10px 20px
  width: 100%
  margin: 10px 0
  border: 1px solid $border-color
  box-shadow: 0 2px 7px #ddd

a
  cursor: pointer
  color: inherit

.avatar
  width: 32px
  margin-right: 10px
</style>
