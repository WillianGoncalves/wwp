<template>
  <div class="card center-align">
    <avatar :url="user.avatar.url" class="avatar"></avatar>
    <p>{{ fullName(user) }}</p>
    <p class="email">{{ user.email }}</p>
  </div>
</template>

<script lang="coffee">
export default
  props:
    user:
      type: Object
      required: true

  methods:
    fullName: (user) ->
      "#{user.first_name} #{user.last_name}"
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../assets/stylesheets/modules/colors';
.avatar
  margin: 10px 0
p
  margin: 5px 0
.email
  color: lighten($color, 20%)
</style>
