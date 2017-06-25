import Vue from 'vue';
import Groups from './groups/groups.vue';
import Avatar from './avatar.vue';
import Members from './groups/members.vue';

Vue.component('groups', Groups);
Vue.component('avatar', Avatar);
Vue.component('members', Members);

new Vue({
  el: '#app'
});
