# frozen_string_literal: true

require 'rspec_let_cache/version'
require 'rspec'
module RspecLetCache
  class RspecLetCacheObj
  end

  # Permits to cache block results across tests and improve related tests performance
  # @example
  #   describe "articles index page" do
  #     let_cached(:article_cached) { Article.create!(title: 'sample title') }
  #     let_cached(:page_cached) do
  #       visit articles_path
  #       page
  #     end
  #     before { allow(page_cached).to receive(:reset!) }
  #     it 'includes page title' { expect(page_cached).to have_css('header h1', text: "Articles") }
  #     it 'includes articles' { expect(page_cached).to have_content(article_cached.title) }
  #     it 'includes button to delete article' { expect(page_cached).to have_css('table.articles_table .btn-delete') }
  #     it 'includes button to edit article' { expect(page_cached).to have_css('table.articles_table .btn-edit') }
  #   end
  def let_cache(attr_name, feature: false, after_all: nil, &block)
    var_name = "@#{attr_name}"
    let(attr_name) do
      already_saved = RspecLetCacheObj.instance_variable_defined?(var_name)
      RspecLetCacheObj.instance_variable_set(var_name, instance_exec(&block)) unless already_saved
      RspecLetCacheObj.instance_variable_get(var_name)
    end
    before { allow(page).to receive(:reset!) } if feature # Make capybara page to be reusable
    after(:all) { RspecLetCacheObj.instance_variable_get(var_name)&.send(after_all) if after_all }
    after(:all) { RspecLetCacheObj.remove_instance_variable(var_name) rescue nil } # rubocop:disable Style/RescueModifier
  end
end

RSpec.configure do |config|
  config.extend RspecLetCache
end
