<template>
  <div>
    <div class="row">
      <div class="input-field col s12">
        <i class="material-icons prefix">search</i>
        <input id="search" type="text" v-model="searchFor">
      </div>
    </div>

    <div class="row scrollable">
      <div class="col s6 m3" v-for="user in users">
        <div class="card center-align" :key="user.id" @click="$emit('userSelected', user)">
          <avatar :url="user.avatar_url"></avatar>
          <p>
            {{ fullName(user) }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">
export default
  props:
    groupid:
      type: Number
      required: true

  data: () ->
    searchFor: ''
    users: []

  methods:
    fullName: (user) ->
      "#{user.first_name} #{user.last_name}"

    listUsers: ->
      $.get "/groups/#{@groupid}/candidates", (data) =>
        @users = @_users = data

  watch:
    searchFor: ->
      @users = @_users.filter (user) =>
        user.first_name.toLowerCase().includes(@searchFor.toLowerCase()) ||
        user.last_name.toLowerCase().includes(@searchFor.toLowerCase())

  created: ->
    @listUsers()

</script>

<style scoped lang="sass?indentedSyntax">
@import '../../../../assets/stylesheets/modules/colors';

.scrollable
  max-height: 300px
  overflow: auto

.card
  p
    margin-bottom: 0

  &:hover
    background-color: darken($primary-color, 5%)
    cursor: pointer

  @media (max-width: 425px)
    height: 148px

  @media (min-width: 768px)
    p
      display: block
      overflow: hidden
      text-overflow: ellipsis
      white-space: nowrap
</style>
