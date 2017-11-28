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
      let!(:presentation1) { Fabricate :presentation, group: group, songs: [song] }
      let!(:presentation2) { Fabricate :presentation, group: group, songs: [song] }

      before { get :index, params: { group_id: group.id } }

      it { expect(response).to render_template :index }
      it { expect(assigns(:presentations)).to eq group.presentations }
    end

    describe 'GET #show' do
      let!(:presentation) { Fabricate :presentation, group: group, songs: [song] }

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
      let!(:presentation) { Fabricate :presentation, group: group, songs: [song] }

      before { get :edit, params: { group_id: group.id, id: presentation.id } }

      it { expect(response).to render_template :edit }
      it { expect(assigns(:presentation)).to eq presentation }
    end

    describe 'POST #create' do
      context 'valid presentation' do
        let!(:presentation) { { local: 'foo' } }

        before { post :create, params: { group_id: group.id, presentation: presentation, date: '31/12/2017', time: '12:00', song_ids: [ song.id.to_s ] } }

        it { expect(response).to redirect_to group_presentations_path(group) }
        it { expect(group.presentations.count).to eq 1 }
      end

      context 'invalid presentation' do
        let!(:presentation) { { local: '' } }

        before { post :create, params: { group_id: group.id, presentation: presentation, date: '', time: '', song_ids: [ song.id ] } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :new }
        it { expect(group.presentations.count).to eq 0 }
      end
    end

    describe 'PUT #update' do
      context 'valid presentation' do
        let!(:presentation) { Fabricate :presentation, group: group, songs: [ song ] }
        let!(:valid_presentation) { { date_time: Date.current, local: 'foo', song_ids: [ song.id ] } }

        before { put :update, params: { group_id: group.id, id: presentation.id, presentation: valid_presentation } }

        it { expect(response).to redirect_to group_presentations_path(group) }
        it { expect(presentation.reload.local).to eq 'foo' }
      end

      context 'invalid presentation' do
        let!(:presentation) { Fabricate :presentation, group: group, songs: [ song ] }
        let!(:invalid_presentation) { { date_time: nil, local: '', song_ids: [] } }

        before { put :update, params: { group_id: group.id, id: presentation.id, presentation: invalid_presentation } }

        it { expect(response).to have_http_status :bad_request }
        it { expect(response).to render_template :edit }
        it { expect(presentation.reload.local).not_to eq 'foo' }
      end
    end

    describe 'DELETE #destroy' do
      let!(:presentation) { Fabricate :presentation, group: group, songs: [ song ] }

      before { delete :destroy, params: { group_id: group.id, id: presentation.id } }

      it { expect(response).to redirect_to group_presentations_path(group) }
      it { expect(group.presentations.count).to eq 0 }
      it { expect(group.presentations.with_deleted.count).to eq 1 }
    end
  end

end
