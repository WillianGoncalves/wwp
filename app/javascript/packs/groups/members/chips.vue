<template>
  <div v-if="users.length > 0">
    <div class="chip" v-for="(user, index) in users">
      {{ fullName(user) }}
      <i class="material-icons" @click="$emit('removeMember', index)">close</i>
    </div>

    <button class="btn-floating" @click="$emit('save')"><i class="material-icons">done</i></button>
  </div>
</template>

<script lang="coffee">
export default
  props:
    users:
      type: Array
      required: true

  methods:
    fullName: (user) ->
      "#{user.first_name} #{user.last_name}"
</script>

<style scoped lang="sass?indentedSyntax">
.chip
  margin-top: 20px

  i
    float: right
    padding-left: 8px
    font-size: 16px
    line-height: 32px
    cursor: pointer
</style>
