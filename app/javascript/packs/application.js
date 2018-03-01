import Vue from 'vue';
import UserGroup from './groups/user_group.vue';
import Group from './groups/group.vue';
import Avatar from './avatar.vue';
import Members from './groups/members.vue';
import Tag from './songs/tag.vue';
import TagColorPicker from './tags/tag_color_picker.vue';
import Comment from './comments/comment.vue';
import SongsSelector from './presentations/songs_selector.vue';
import PresentationSongCard from './presentations/presentation_song_card.vue';
import PresentationCard from './presentations/presentation_card.vue';

Vue.component('user-group', UserGroup);
Vue.component('group', Group);
Vue.component('avatar', Avatar);
Vue.component('members', Members);
Vue.component('tag', Tag);
Vue.component('tag-color-picker', TagColorPicker);
Vue.component('comment', Comment);
Vue.component('songs-selector', SongsSelector);
Vue.component('presentation-song-card', PresentationSongCard);
Vue.component('presentation-card', PresentationCard);

new Vue({
  el: '#app',
  methods: {
    showModal: (modalId) => {
      $(modalId).modal();
      $(modalId).modal('open');
    }
  }
});
