import Vue from 'vue';
import UserGroup from './groups/user_group.vue';
import Group from './groups/group.vue';
import Avatar from './avatar.vue';
import Candidates from './groups/candidates.vue';
import Tag from './songs/tag.vue';
import TagColorPicker from './tags/tag_color_picker.vue';
import Comment from './comments/comment.vue';
import CommentKebabMenu from './comments/comment_kebab_menu.vue';
import SongsSelector from './presentations/songs_selector.vue';
import PresentationSongCard from './presentations/presentation_song_card.vue';
import PresentationCard from './presentations/presentation_card.vue';
import UserCard from './groups/user_card.vue';
import TagsFilter from './songs/tags_filter.vue';
import SongsListPaginator from './songs/songs_list_paginator.vue';
import Member from './groups/members/member.vue';
import GroupPresentation from './groups/group_presentation/group_presentation.vue';
import GroupPresentationSongs from './groups/group_presentation/group_presentation_songs.vue';
import GroupPresentationSongsItem from './groups/group_presentation/group_presentation_songs_item.vue';

Vue.component('user-group', UserGroup);
Vue.component('group', Group);
Vue.component('avatar', Avatar);
Vue.component('candidates', Candidates);
Vue.component('tag', Tag);
Vue.component('tag-color-picker', TagColorPicker);
Vue.component('comment', Comment);
Vue.component('songs-selector', SongsSelector);
Vue.component('presentation-song-card', PresentationSongCard);
Vue.component('presentation-card', PresentationCard);
Vue.component('user-card', UserCard);
Vue.component('tags-filter', TagsFilter);
Vue.component('songs-list-paginator', SongsListPaginator);
Vue.component('comment-kebabk-menu', CommentKebabMenu);
Vue.component('member', Member)
Vue.component('group-presentation', GroupPresentation)
Vue.component('group-presentation-songs', GroupPresentationSongs)
Vue.component('group-presentation-songs-item', GroupPresentationSongsItem)

var replaceHtml = function(element, content) {
  var Component = Vue.extend({});
  new Component({
    template: content
  }).$mount(element);
};

new Vue({
  el: '#app',
  methods: {
    showModal: (modalId) => {
      $(modalId).modal();
      $(modalId).modal('open');
    },
    replaceHtml: (element, content) => replaceHtml(element, content)
  }
});
