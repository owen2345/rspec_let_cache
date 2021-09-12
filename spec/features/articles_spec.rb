require 'rails_helper'
RSpec.describe 'Articles Page', js: true do
  describe 'index page' do
    let(:articles_cached) do
      [Article.create!(title: 'article 1'), Article.create!(title: 'article 2')]
    end
    let_cache(:page_cached) do
      visit articles_path
      page.clone
    end

    it 'includes first article' do
      puts "@@@@@@@@@@@1#{page_cached.html}"
      # expect(page_cached).to have_content(include(articles_cached[0].title))
    end

    it 'includes second article' do
      puts "@@@@@@@@@@@2#{page_cached.html}"
      # expect(page_cached).to have_content(include(articles_cached[1].title))
    end

    xit 'includes button to delete' do
      page.html
      expect(page_cached).to have_css('#articles_table .edit_button')
    end

    xdescribe 'when checking server calls' do
      it 'does not re call server request' do
        expect_any_instance_of(ArticlesController).not_to receive(:index)
        page_cached
      end
    end
  end
end
