<template>
  <div class="row expandable">

    <div class="input-field col s12">
      <i class="material-icons prefix">search</i>
      <input id="search" type="text" v-model="searchFor">
    </div>

    <div class="col s6 m3" v-for="user in users">
      <div class="cell" :key="user.id" @click="$emit('createInvite', user)">
        <avatar :url="user.avatar_url"></avatar>
        <p>
          {{ fullName(user) }}
        </p>
      </div>
    </div>

  </div>
</template>

<script lang="coffee">
export default
  props:
    groupid: String

  data: ->
    searchFor: ''
    users: []

  methods:
    fullName: (user) ->
      "#{user.first_name} #{user.last_name}"

  watch:
    searchFor: ->
      @users = @_users.filter (user) =>
        user.first_name.toLowerCase().includes(@searchFor.toLowerCase()) ||
        user.last_name.toLowerCase().includes(@searchFor.toLowerCase())

  created: ->
    $.get "/groups/#{this.groupid}/candidates", (data) =>
      @users = @_users = data
</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../../assets/stylesheets/modules/colors';

.expandable
  max-height: 500px
  margin-top: 20px
  overflow: auto

.expand-enter-active, .expand-leave-active
  transition: max-height .4s

.expand-enter, .expand-leave-to
  max-height: 0

.cell
  height: 115px
  padding: 10px
  margin: 10px 0
  text-align: center
  cursor: pointer
  background-color: $primary-color
  border: 1px solid $border-color

  p
    margin-bottom: 0

  &:hover
    background-color: darken($primary-color, 5%)

  @media (max-width: 425px)
    height: 148px

  @media (min-width: 768px)
    p
      display: block
      overflow: hidden
      text-overflow: ellipsis
      white-space: nowrap
</style>
