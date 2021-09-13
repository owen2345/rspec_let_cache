# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ArticlesController, type: :controller do
  describe 'when checking response content' do
    render_views
    let_cache(:articles_cached) do
      [Article.create!(title: 'article 1'), Article.create!(title: 'article 2')]
    end
    let_cache(:response_cached) do
      articles_cached
      get :index
      response
    end

    it 'includes first article\'s title' do
      expect(response_cached.body).to include(articles_cached.first.title)
    end

    it 'includes second article\'s title' do
      expect(response_cached.body).to include(articles_cached.second.title)
    end

    describe 'when checking cache status' do
      it 'does not re call server request' do
        expect_any_instance_of(ArticlesController).not_to receive(:index)
        response_cached
      end

      it 'does not recreate articles on DB' do
        response_cached
        expect { articles_cached.first.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
