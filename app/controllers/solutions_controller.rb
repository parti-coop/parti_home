class SolutionsController < ApplicationController

  def demos
    @info = Post::SOLUTIONS_MAP[:demos]
  end

  def org
    @info = Post::SOLUTIONS_MAP[:org]
  end

  def campaign
    @info = Post::SOLUTIONS_MAP[:campaign]
  end

  def soft
    @info = Post::SOLUTIONS_MAP[:soft]
  end
end