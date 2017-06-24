<template>
  <div class="col s12 m6">
    <div class="card">
      <div class="card-content">
        <span class="card-title">{{ group.name }}</span>
        <avatar v-for="member in group.members" :key="member.id" :url="member.avatar_url" class="avatar"></avatar>
      </div>

      <div class="card-action">
        <a href="#" class="btn btn-flat">Entrar</a>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
import Avatar from '../avatar.vue'

export default
  props: group: Object
  components: 'avatar': Avatar
</script>

<style scoped lang="sass?indentedSyntax">
.avatar
  margin-right: 10px
</style>
