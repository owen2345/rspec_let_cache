require "rspec_let_cache/version"
# require "rspec_let_cache/railtie"
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
  #     it 'includes page title' { expect(page_cached).to have_css('header h1', text: "Articles") }
  #     it 'includes articles' { expect(page_cached).to have_content(article_cached.title) }
  #     it 'includes button to delete article' { expect(page_cached).to have_css('table.articles_table .btn-delete') }
  #     it 'includes button to edit article' { expect(page_cached).to have_css('table.articles_table .btn-edit') }
  #   end
  def let_cache(attr_name, &block)
    var_name = "@#{attr_name}"
    let(attr_name) { RspecLetCacheObj.instance_variable_get(var_name) }
    # after(:all) { RspecLetCacheObj.remove_instance_variable(var_name) }
    before do
      # unless RspecLetCacheObj.instance_variable_defined?(var_name)
      old_value = RspecLetCacheObj.instance_variable_get(var_name)
      puts "@@@@@@@@@@@@beforeeee: #{old_value.inspect}"
      unless old_value
        value = instance_exec(&block)
        RspecLetCacheObj.instance_variable_set(var_name, value)
      end
    end
  end
end

RSpec.configure do |config|
  config.extend RspecLetCache
end
