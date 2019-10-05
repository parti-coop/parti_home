class SolutionsController < ApplicationController
  SOLUTION = [
    {
      slug: :demos,
      path_text: :solutions_demos_path, 
      title: '기관&middot시민 참여 플랫폼', 
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'samples/home/whatwedo/card1.png' 
    }, { 
      slug: :org,
      path_text: :solutions_org_path,  
      title: '시민자치 커뮤니티', 
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'samples/home/whatwedo/card1.png' 
    }, { 
      slug: :campaign,
      path_text: :solutions_campaign_path,  
      title: '시민주도 캠페인',  
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'samples/home/whatwedo/card1.png' 
    }, { 
      slug: :soft,
      path_text: :solutions_soft_path,  
      title: '디지털 솔루션',  
      subtitle: '일상 곳곳을 민주적으로',
      image_path: 'samples/home/whatwedo/card1.png' 
    }
  ]
  def demos
    @info = SOLUTION[0]
  end

  def org
    @info = SOLUTION[1]
  end

  def campaign
    @info = SOLUTION[2]
  end

  def soft
    @info = SOLUTION[3]
  end
end