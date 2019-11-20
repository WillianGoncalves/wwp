<template>
  <div>
    <div class="right-align">
      <button class="btn-floating" @click="showUsers = !showUsers" :class="{'close-button': showUsers}"><i class="material-icons">add</i></button>
    </div>

    <chips :users="new_members" v-on:removeMember="removeMember" v-on:save="save"></chips>

    <transition name="fade">
      <div v-if="showUsers">
        <div class="row">
          <div class="input-field col s12">
            <i class="material-icons prefix">search</i>
            <input id="search" type="text" v-model="searchFor">
          </div>
        </div>

        <div class="row" id="candidates">
          <div class="col s12 m4" v-for="candidate in candidates">
            <user-card :user="candidate" @click.native="addMember(candidate)"></user-card>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script lang="coffee">
import Chips from './members/chips.vue';
import UserCard from './user_card.vue';

export default
  props:
    groupId:
      type: Number
      required: true

  data: () ->
    searchFor: ''
    showUsers: false
    new_members: []
    candidates: []

  components:
    'chips': Chips
    'user-card': UserCard

  methods:
    addMember: (user) ->
      if (!@new_members.includes(user)) then @new_members.push user

    removeMember: (index) ->
      @new_members.splice(index, 1)

    listUsers: ->
      $.get "/groups/#{@groupId}/candidates", (data) =>
        @candidates = @_candidates = data

    save: ->
      data = @new_members.map (user) -> { user_id: user.id }
      $.ajax
        url: "/groups/#{@groupId}/members"
        type: 'POST'
        data: JSON.stringify(members: data)
        dataType: 'json'
        contentType: 'application/json'
      .done ->
        location.reload()

  watch:
    searchFor: ->
      @candidates = @_candidates.filter (user) =>
        user.first_name.toLowerCase().includes(@searchFor.toLowerCase()) ||
        user.last_name.toLowerCase().includes(@searchFor.toLowerCase())

  created: ->
    @listUsers()
</script>

<style scoped lang="sass">
.card
  cursor: pointer

.close-button
  transform: rotate(45deg)
  transition-duration: .2s

.fade-enter-active, .fade-leave-active
  transition: opacity .2s

.fade-enter, .fade-leave-to
  opacity: 0

#candidates
  height: 300px
  overflow: auto
</style>
