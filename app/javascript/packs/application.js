import Vue from 'vue';
import Groups from './groups/groups.vue';
import Group from './groups/group.vue';

Vue.component('groups', Groups);
Vue.component('group', Group);

new Vue({
  el: '#app'
});
