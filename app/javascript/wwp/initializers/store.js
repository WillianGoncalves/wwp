import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';

Vue.use(Vuex)

const state = {
  currentGroup: { tags: [] },
  selectedSongs: []
}

const mutations = {
  setCurrentGroup(state, group) {
    state.currentGroup = group
  },
  selectOrUnselectSong(state, song) {
    const { selectedSongs } = state
    if (selectedSongs.includes(song)) {
      const index = selectedSongs.indexOf(song)
      selectedSongs.splice(index, 1)
    } else {
      selectedSongs.push(song)
    }
  },
  setSelectedSongs(state, selectedSongs) {
    state.selectedSongs = selectedSongs
  },
  reorderSelectedSongs(state, reorderedSongs) {
    state.selectedSongs = reorderedSongs
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
