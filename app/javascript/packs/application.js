import Vue from 'vue';
import UserGroup from './groups/user_group.vue';
import Group from './groups/group.vue';
import Avatar from './avatar.vue';
import Members from './groups/members.vue';
import Tag from './songs/tag.vue';
import TagColorPicker from './tags/tag_color_picker.vue';
import Comment from './comments/comment.vue';

Vue.component('user-group', UserGroup);
Vue.component('group', Group);
Vue.component('avatar', Avatar);
Vue.component('members', Members);
Vue.component('tag', Tag);
Vue.component('tag-color-picker', TagColorPicker);
Vue.component('comment', Comment);

new Vue({
  el: '#app',
  methods: {
    showModal: (modalId) => {
      $(modalId).modal();
      $(modalId).modal('open');
    }
  }
});
