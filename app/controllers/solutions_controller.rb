class SolutionsController < ApplicationController
  Solution::DICTIONARY.each do |solution_slug, solution_info|
    define_method(solution_slug) do
      @slug = solution_slug
      @info = solution_info

      prepare_meta_tags(title: @info[:title], description: @info[:seo_desc], url: send(:"solutions_#{@slug}_url"))
    end
  end

  def soft
    @slug = Platform::INFO[:slug]
    @info = Platform::INFO

    prepare_meta_tags(title: @info[:title], description: @info[:seo_desc], url: send(:"solutions_soft_url"))
  end
end