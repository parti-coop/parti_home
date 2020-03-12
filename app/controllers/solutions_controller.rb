class SolutionsController < ApplicationController
  Solution::DICTIONARY.each do |solution_slug, solution_info|
    define_method(solution_slug) do
      @slug = solution_slug
      @info = solution_info
    end
  end

  def soft
    @slug = Platform::INFO[:slug]
    @info = Platform::INFO
  end
end