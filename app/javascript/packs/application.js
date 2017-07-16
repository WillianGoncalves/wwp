import Vue from 'vue';
import Groups from './groups/groups.vue';
import UserGroup from './groups/user_group.vue';
import Group from './groups/group.vue';
import Avatar from './avatar.vue';
import Members from './groups/members.vue';

Vue.component('groups', Groups);
Vue.component('user-group', UserGroup);
Vue.component('group', Group);
Vue.component('avatar', Avatar);
Vue.component('members', Members);

new Vue({
  el: '#app'
});
