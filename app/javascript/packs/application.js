import Vue from 'vue';
import Groups from './groups/groups.vue';
import Avatar from './avatar.vue';

Vue.component('groups', Groups);
Vue.component('avatar', Avatar);

new Vue({
  el: '#app'
});
