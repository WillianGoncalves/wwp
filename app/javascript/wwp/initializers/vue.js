import Vue from 'vue';
import i18n from '../locales';
import store from './store';

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
import TagsFilter from '../components/songs/tags_filter.vue.erb';
import SongsListPaginator from '../components/songs/songs_list_paginator.vue';
import Member from '../components/groups/members/member.vue';
import GroupPresentation from '../components/groups/group_presentation/group_presentation.vue';
import GroupPresentationSongs from '../components/groups/group_presentation/group_presentation_songs.vue';
import GroupPresentationSongsItem from '../components/groups/group_presentation/group_presentation_songs_item.vue';
import SectionHeading from '../components/section_heading.vue';
import SongPresentation from '../components/songs/song_presentation.vue'
import SnackBar from '../components/snack_bar.vue'
import SongsList from '../components/songs/songs_list.vue';

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
Vue.component('section-heading', SectionHeading)
Vue.component('song-presentation', SongPresentation)
Vue.component('snack-bar', SnackBar)
Vue.component('songs-list', SongsList)

const vm = new Vue({
  i18n,
  store,
  el: '#app',
  data: () => {
    return {
      locale: '',
    }
  },
  mounted() {
    // Get the locale from "data-locale" attribute, in div #app. See application.html.erb.
    this.locale = this.$el.dataset.locale
    const groupId = this.$el.dataset.groupId
    if (groupId) store.dispatch('getCurrentGroup', { groupId })
  },
  methods: {
    showModal: (modalId) => {
      $(modalId).modal();
      $(modalId).modal('open');
    },
  }
});

// The default locale is 'pt-BR'.
// Here, we update the locale according to the one
// passed to the vue instance (vm.locale).
i18n.locale = vm.locale
