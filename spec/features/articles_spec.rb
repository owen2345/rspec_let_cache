# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Articles Page' do
  describe 'index page' do
    let_cache(:articles_cached) do
      [Article.create!(title: 'article 1'), Article.create!(title: 'article 2')]
    end
    let_cache(:page_cached) do
      articles_cached
      visit articles_path
      page
    end
    before { allow(page_cached).to receive(:reset!) }

    describe 'when checking page content' do
      it 'includes first article' do
        expect(page_cached).to have_content(articles_cached.first.title)
      end

      it 'includes second article' do
        expect(page_cached).to have_content(articles_cached.second.title)
      end

      it 'includes button to delete' do
        expect(page_cached).to have_css('#articles_table .edit_button')
      end
    end

    describe 'when checking cache status' do
      it 'does not re call server request' do
        expect_any_instance_of(ArticlesController).not_to receive(:index)
        page_cached
      end

      it 'does not recreate articles on DB' do
        articles_cached
        expect { articles_cached.first.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
