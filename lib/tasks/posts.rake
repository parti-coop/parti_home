namespace :posts do
  desc "미디엄에서 복사 해온 글을 모두 지우고 새로 임포트합니다."
  task import_mediums: :environment do
    include Rails.application.routes.url_helpers

    Dir.glob(Rails.root.join('public/static-assets/images/**/*')).each do |path|
      next if File.directory?(path) or File.extname(path).present?
      FileUtils.mv path, "#{path}.png"
    end

    ActiveRecord::Base.transaction do
      Post.where(source: 'medium').destroy_all
      Dir[Rails.root.join('lib', 'tasks', 'content', '*.md')].each_with_index do |path, index|
        date = File.basename(path)[0..9]
        title = ''
        body = ''
        File.open(path) do |f|
          f.readline
          title = f.readline[2..-1]
          body= f.readlines.join()
        end
        body.gsub!(/\(\/assets\/images\/([^\/]*?)\/([^.]*?)\)/) do |match|
          dir_name = $1
          file_name = $2
          "(/assets/images/#{dir_name}/#{file_name}.png)"
        end
        body.gsub!(/\(\/assets\/images\/([^\/]*?)\/([^.]*?)\.\)/) do |match|
          dir_name = $1
          file_name = $2
          "(/assets/images/#{dir_name}/#{file_name}.png)"
        end
        body.gsub!(/\(\/assets\/images\/([^\/]*?)\/([^\/]*?)\)/) do |match|
          dir_name = $1
          file_name = $2
          file_name.gsub!('*', '')
          "(/static-assets/images/#{dir_name}/#{file_name})"
        end

        post = Post.new(title: title, body: body, published_at: date, source: 'medium')

        first_image_urls = body[/\((\/static-assets\/images\/[^\/]*?\/[^\/]*?)\)/]
        unless first_image_urls.nil?
          post.cover = Pathname.new(Rails.root.join("public#{$1}")).open
        end
        post.save!
        print index
      end
    end
  end
end