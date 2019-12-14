import Vue from 'vue';
import Vuex from 'vuex';
//import axios from 'axios';
const axios = require('axios');

Vue.use(Vuex)

const state = {
  currentGroup: { tags: [] }
}

const mutations = {
  setCurrentGroup(state, group) {
    state.currentGroup = group
  }
}

const actions = {
  getCurrentGroup({ commit }, { groupId }) {
    axios.get(`/groups/${ groupId }.json`)
      .then((response) => {
        commit('setCurrentGroup', response.data)
      })
  }
}

const getters = {
  tags: state => state.currentGroup.tags
}

export default new Vuex.Store({
  state,
  mutations,
  actions,
  getters
})
