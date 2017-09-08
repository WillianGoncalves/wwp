require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  let!(:user) { Fabricate :user }

  before { sign_in user }

  describe 'GET #index' do
    before { get :index }

    it { expect(response).to render_template :index }
  end

  describe 'GET #edit' do
    let!(:tag) { Fabricate :tag }

    before { get :edit, params: { id: tag.id } }

    it { expect(response).to render_template :edit }
  end

  describe 'POST #create' do
    let!(:color) { Fabricate :color }

    context 'with valid tag' do
      let!(:tag) { { name: 'foo', color_id: color.id } }

      before { post :create, params: { tag: tag } }

      it { expect(response).to redirect_to tags_path }
      it { expect(Tag.all.count).to eq 1 }
    end

    context 'with invalid tag' do
      let!(:tag) { { name: '', color_id: '' } }

      before { post :create, params: { tag: tag } }

      it { expect(response).to have_http_status :bad_request }
      it { expect(response).to render_template :index }
      it { expect(Tag.all.count).to eq 0 }
    end
  end

  describe 'PUT #update' do
    let!(:color1) { Fabricate :color }
    let!(:color2) { Fabricate :color }

    context 'with valid tag' do
      let!(:tag) { Fabricate :tag, color: color1 }
      let!(:valid_tag) { { name: 'foo', color_id: color2.id } }

      before { put :update, params: { id: tag.id, tag: valid_tag } }

      it { expect(response).to redirect_to tags_path }
      it { expect(tag.reload.name).to eq 'foo' }
      it { expect(tag.reload.color).to eq color2 }
    end

    context 'with invalid tag' do
      let!(:tag) { Fabricate :tag, color: color1 }
      let!(:invalid_tag) { { name: '', color_id: nil } }

      before { put :update, params: { id: tag.id, tag: invalid_tag } }

      it { expect(response).to have_http_status :bad_request }
      it { expect(response).to render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    let!(:tag) { Fabricate :tag }

    before { delete :destroy, params: { id: tag.id } }

    it { expect(response).to redirect_to tags_path }
    it { expect(Tag.count).to eq 0 }
  end
end
