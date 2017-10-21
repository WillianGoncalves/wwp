require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  let!(:user) { Fabricate :user }
  let!(:member) { Fabricate.build :member_admin, user: user }
  let!(:group) { Fabricate :group, members: [member]  }

  before { sign_in user }
  before { assign_group(user, group) }

  describe 'GET #index' do
    let!(:tag1) { Fabricate :tag, group: group }
    let!(:tag2) { Fabricate :tag, group: group }

    before { get :index, params: { group_id: group.id } }

    it { expect(response).to render_template :index }
    it { expect(assigns(:tag)).to be_a_new Tag }
    it { expect(assigns(:tags)).to eq group.tags }
  end

  describe 'GET #edit' do
    let!(:tag) { Fabricate :tag, group: group }

    before { get :edit, params: { group_id: group.id, id: tag.id } }

    it { expect(response).to render_template :edit }
    it { expect(assigns(:tag)).to eq tag }
  end

  describe 'POST #create' do
    let!(:color) { Fabricate :color }

    context 'with valid tag' do
      let!(:tag) { { name: 'foo', color_id: color.id } }

      before { post :create, params: { group_id: group.id, tag: tag } }

      it { expect(response).to redirect_to group_tags_path(group) }
      it { expect(group.tags.count).to eq 1 }
    end

    context 'with invalid tag' do
      let!(:tag) { { name: '', color_id: '' } }

      before { post :create, params: { group_id: group.id, tag: tag } }

      it { expect(response).to have_http_status :bad_request }
      it { expect(response).to render_template :index }
      it { expect(group.tags.count).to eq 0 }
    end
  end

  describe 'PUT #update' do
    let!(:color1) { Fabricate :color, name: 'red' }
    let!(:color2) { Fabricate :color, name: 'blue' }

    context 'with valid tag' do
      let!(:tag) { Fabricate :tag, color: color1, group: group  }
      let!(:valid_tag) { { name: 'foo', color_id: color2.id } }

      before { put :update, params: { group_id: group.id, id: tag.id, tag: valid_tag } }

      it { expect(response).to redirect_to group_tags_path(group) }
      it { expect(tag.reload.name).to eq 'foo' }
      it { expect(tag.reload.color).to eq color2 }
    end

    context 'with invalid tag' do
      let!(:tag) { Fabricate :tag, color: color1, group: group }
      let!(:invalid_tag) { { name: '', color_id: nil } }

      before { put :update, params: { group_id: group.id, id: tag.id, tag: invalid_tag } }

      it { expect(response).to have_http_status :bad_request }
      it { expect(response).to render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    let!(:tag) { Fabricate :tag, group: group }

    before { delete :destroy, params: { group_id: group.id, id: tag.id } }

    it { expect(response).to redirect_to group_tags_path }
    it { expect(group.tags.count).to eq 0 }
  end
end
