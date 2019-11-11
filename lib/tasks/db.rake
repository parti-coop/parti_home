include ActionView::Helpers::SanitizeHelper

namespace :branchdb do
  desc 'master브랜치 DB를 복사하여 현재 브랜치DB를 만듭니다'
  task 'create' => :environment do
    project_name = 'parti_home'
    branch = `git rev-parse --abbrev-ref HEAD`.strip rescue nil
    if branch.blank?
      puts '브랜치 이름을 알수 없습니다.'
      next
    end

    if branch == "master"
      puts 'master 브랜치입니다.'
      next
    end

    branch = branch.gsub('/', '_')

    local_env = YAML.load_file("#{Rails.root}/local_env.yml").dig(Rails.env) || {}

    created_result = system("mysql -u#{local_env.dig('database', 'username')} -p#{local_env.dig('database', 'password')} -e 'create database `#{project_name}_development_#{branch}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;'")

    unless created_result
      puts "DB 생성에 실패했습니다. : #{$?}"
      next
    end
    puts "DB 생성했습니다. : #{project_name}_development_#{branch}"

    copy_result = system("mysqldump -u#{local_env.dig('database', 'username')} -p#{local_env.dig('database', 'password')} #{project_name}_development_master | mysql -u#{local_env.dig('database', 'username')} -p#{local_env.dig('database', 'password')} #{project_name}_development_#{branch}")

    puts(copy_result ? "DB를 복사했습니다. : #{$?}" : "DB를 복사하지 못했습니다. : #{$?}")
  end

  desc '현재 브랜치DB를 삭제합니다'
  task 'remove' => :environment do
    project_name = 'parti_home'
    branch = `git rev-parse --abbrev-ref HEAD`.strip rescue nil
    if branch.blank?
      puts '브랜치 이름을 알수 없습니다.'
      next
    end

    if branch == "master"
      puts 'master 브랜치입니다.'
      next
    end

    branch = branch.gsub('/', '_')

    local_env = YAML.load_file("#{Rails.root}/local_env.yml").dig(Rails.env) || {}

    created_result = system("mysql -u#{local_env.dig('database', 'username')} -p#{local_env.dig('database', 'password')} -e 'drop database `#{project_name}_development_#{branch}`'")

    unless created_result
      puts "DB 삭제에 실패했습니다. : #{$?}"
      next
    end
    puts "DB 삭제했습니다. : #{project_name}_development_#{branch}"
  end
end