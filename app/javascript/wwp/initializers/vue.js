import Vue from 'vue';
import UserGroup from '../components/groups/user_group.vue';
import Group from '../components/groups/group.vue';
import Avatar from '../components/avatar.vue';
import Candidates from '../components/groups/candidates.vue';
import Tag from '../components/songs/tag.vue';
import TagColorPicker from '../components/tags/tag_color_picker.vue';
import Comment from '../components/comments/comment.vue';
import CommentKebabMenu from '../components/comments/comment_kebab_menu.vue';
import SongsSelector from '../components/presentations/songs_selector.vue';
import PresentationSongCard from '../components/presentations/presentation_song_card.vue';
import PresentationCard from '../components/presentations/presentation_card.vue';
import UserCard from '../components/groups/user_card.vue';
import TagsFilter from '../components/songs/tags_filter.vue';
import SongsListPaginator from '../components/songs/songs_list_paginator.vue';
import Member from '../components/groups/members/member.vue';
import GroupPresentation from '../components/groups/group_presentation/group_presentation.vue';
import GroupPresentationSongs from '../components/groups/group_presentation/group_presentation_songs.vue';
import GroupPresentationSongsItem from '../components/groups/group_presentation/group_presentation_songs_item.vue';
import SectionTitle from '../components/section_title.vue';
import SongPresentation from '../components/songs/song_presentation.vue'

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
Vue.component('section-title', SectionTitle)
Vue.component('song-presentation', SongPresentation)

const replaceHtml = (element, content) => {
  const Component = Vue.extend({});
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

