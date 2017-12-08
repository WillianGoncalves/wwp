require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do

  context 'authenticated user' do

    let!(:user) { Fabricate :user }
    let!(:member) { Fabricate.build :member_admin, user: user }
    let!(:group) { Fabricate :group, members: [member]  }
    let!(:song) { Fabricate :song, group: group }

    before { sign_in user }
    before { assign_group(user, group) }

    describe 'GET #index' do
      let!(:presentation1_song) { PresentationSong.new(song: song, index: 0) }
      let!(:presentation2_song) { PresentationSong.new(song: song, index: 0) }
      let!(:presentation1) { Fabricate :presentation, group: group, presentation_songs: [ presentation1_song ] }
      let!(:presentation2) { Fabricate :presentation, group: group, presentation_songs: [ presentation2_song ] }

      before { get :index, params: { group_id: group.id } }

      it { expect(response).to render_template :index }
      it { expect(assigns(:presentations)).to eq group.presentations }
      it { expect(assigns(:presentations)).to match_array [ presentation1, presentation2 ] }
    end

    describe 'GET #show' do
      let!(:presentation_song) { PresentationSong.new(song: song, index: 0) }
      let!(:presentation) { Fabricate :presentation, group: group, presentation_songs: [ presentation_song ] }

      before { get :show, params: { group_id: group.id, id: presentation.id } }

      it { expect(response).to render_template :show }
      it { expect(assigns(:presentation)).to eq presentation }
    end

    describe 'GET #new' do
      before { get :new, params: { group_id: group.id } }

      it { expect(response).to render_template :new }
      it { expect(assigns(:presentation)).to be_a_new Presentation }
    end

    describe 'GET #edit' do
      let!(:presentation_song) { PresentationSong.new(song: song, index: 0) }
      let!(:presentation) { Fabricate :presentation, group: group, presentation_songs: [ presentation_song ] }

      before { get :edit, params: { group_id: group.id, id: presentation.id } }

      it { expect(response).to render_template :edit }
      it { expect(assigns(:presentation)).to eq presentation }
      it { expect(assigns(:date)).to eq presentation.date_time.strftime("%d/%m/%Y") }
      it { expect(assigns(:time)).to eq presentation.date_time.strftime("%H:%M") }
    end

    describe 'POST #create' do
      context 'valid presentation' do
        let!(:presentation) { { local: 'foo' } }
        let!(:song2) { Fabricate :song, group: group }
        let!(:song3) { Fabricate :song, group: group }
        let!(:songIds) { [ song2.id, song3.id ].join(",") }

        before { post :create, params: { group_id: group.id, presentation: presentation, date: '31/12/2017', time: '12:00', song_ids: songIds } }

        it { expect(response).to redirect_to group_presentations_path(group) }
        it { expect(group.presentations.count).to eq 1 }
        it { expect(assigns(:presentation).date_time).to eq "31/12/2017 12:00" }
        it { expect(assigns(:presentation).songs).to match_array [ song2, song3 ] }
      end

      context 'invalid presentation' do
        let!(:presentation) { { local: '' } }

        before { post :create, params: { group_id: group.id, presentation: presentation, date: '', time: '', song_ids: '' } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :new }
        it { expect(group.presentations.count).to eq 0 }
      end
    end

    describe 'PUT #update' do
      context 'valid presentation' do
        let!(:presentation_song) { PresentationSong.new(song: song, index: 0) }
        let!(:presentation) { Fabricate :presentation, group: group, presentation_songs: [ presentation_song ] }
        let!(:song2) { Fabricate :song, group: group }
        let!(:song3) { Fabricate :song, group: group }
        let!(:valid_presentation) { { local: 'foo' } }
        let!(:songIds) { [ song2.id, song3.id ].join(",") }

        before { put :update, params: { group_id: group.id, id: presentation.id, presentation: valid_presentation, date: '31/12/2017', time: '12:00', song_ids: songIds } }

        it { expect(response).to redirect_to group_presentations_path(group) }
        it { expect(presentation.reload.local).to eq 'foo' }
        it { expect(assigns(:presentation).date_time).to eq "31/12/2017 12:00" }
        it { expect(presentation.songs).to match_array [ song2, song3 ] }
      end

      context 'invalid presentation' do
        let!(:presentation_song) { PresentationSong.new(song: song, index: 0) }
        let!(:presentation) { Fabricate :presentation, group: group, presentation_songs: [ presentation_song ] }
        let!(:invalid_presentation) { { local: '' } }

        before { put :update, params: { group_id: group.id, id: presentation.id, presentation: invalid_presentation, date: '', time: '', song_ids: '' } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :edit }
        it { expect(presentation.reload.date_time).not_to eq '' }
        it { expect(presentation.reload.local).not_to eq 'foo' }
      end
    end

    describe 'DELETE #destroy' do
      let!(:presentation_song) { PresentationSong.new(song: song, index: 0) }
      let!(:presentation) { Fabricate :presentation, group: group, presentation_songs: [ presentation_song ] }

      before { delete :destroy, params: { group_id: group.id, id: presentation.id } }

      it { expect(response).to redirect_to group_presentations_path(group) }
      it { expect(group.presentations.count).to eq 0 }
      it { expect(group.presentations.with_deleted.count).to eq 1 }
    end
  end

end
