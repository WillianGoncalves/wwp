import Vue from 'vue';
import UserGroup from './groups/user_group.vue';
import Group from './groups/group.vue';
import Avatar from './avatar.vue';
import Members from './groups/members.vue';
import Tag from './songs/tag.vue';
import TagColorPicker from './tags/tag_color_picker.vue';

Vue.component('user-group', UserGroup);
Vue.component('group', Group);
Vue.component('avatar', Avatar);
Vue.component('members', Members);
Vue.component('tag', Tag);
Vue.component('tag-color-picker', TagColorPicker);

new Vue({
  el: '#app'
});
