namespace :mambo do
  namespace :support do
    desc 'Update the license in all files from LICENSE file and add the encoding to ruby files'
    task :update_files do
      path = File.join('.', 'LICENSE')
      if File.exist?(path)
        license_text = File.read(path)
        ruby_encoding = " -*- encoding : utf-8 -*- \n"

        require 'mmcopyrights'
        MM::Copyrights.process('.', 'rb', '#-', ruby_encoding + license_text)
        MM::Copyrights.process('.', 'haml', '//-', license_text)
        MM::Copyrights.process('.', 'js', '//-', license_text)
      else
        puts "No LICENSE file at #{path}.  Aborting update_files."
      end
    end

    desc 'add magic_encoding comments'
    task :add_encoding do
      `bundle exec magic_encoding`
    end

    desc 'remove magic_encoding comments'
    task :remove_encoding do
      files = Dir.glob(File.join('.', '**', '*.rb'))
      files.each do |file_path|
        file_text = File.read(file_path)
        file_text.gsub!(/^.*encoding : utf-8*$/, '')
        File.open(file_path, "w") {|file| file.puts file_text}
      end
    end

    desc 'update version' 
    task :update_version do
      spec_path = Dir.glob("*.gemspec").first
      raise("No gemspec.  Aborting") unless spec_path
      spec = Gem::Specification.load(spec_path)
      version_s = spec.version.to_s
      revision_number = spec.version.to_s.gsub(/.*\..*\./, '').to_i
      new_version_s = version_s.gsub(revision_number.to_s, (revision_number + 1).to_s)

      file_path = "lib/#{spec.name.gsub('mambo-','')}/version.rb"
      version_file_text = File.read(file_path)
      File.open(file_path, "w") {|file| file.puts version_file_text}

      `git commit -am "Update version to #{new_version_s}"`
    end

    desc 'update licenses and encodings, modify gem version, and commit to git'
    task :prepare_gem do
      `bundle exec rake mambo:support:remove_encoding`
      `bundle exec rake mambo:support:update_files`
      `bundle exec rake mambo:support:update_version`
    end

    desc 'pull and bundle gem'
    task :update_gem do
      `git pull origin && bundle install`
    end

    desc 'use local version of mambo gems - use MAMBO_LOCAL, MAMBO_DEV, and MAMBO_PUBLIC in your Gemfile to use this task'
    task :mambo_local do
      file_path = "Gemfile"
      gemfile_text = File.read(file_path)
      gemfile_text.gsub!(/^#(gem.*MAMBO_LOCAL.*$)/, '\1')
      gemfile_text.gsub!(/^(gem.*MAMBO_DEV.*$)/, '#\1')
      gemfile_text.gsub!(/^(gem.*MAMBO_PUBLIC.*$)/, '#\1')
      File.open(file_path, "w") {|file| file.puts gemfile_text}
      puts gemfile_text
    end

    desc 'use git version of mambo gems - use MAMBO_LOCAL, MAMBO_DEV, and MAMBO_PUBLIC in your Gemfile to use this task'
    task :mambo_dev do
      file_path = "Gemfile"
      gemfile_text = File.read(file_path)
      gemfile_text.gsub!(/^(gem.*MAMBO_LOCAL.*$)/, '#\1')
      gemfile_text.gsub!(/^#(gem.*MAMBO_DEV.*$)/, '\1')
      gemfile_text.gsub!(/^(gem.*MAMBO_PUBLIC.*$)/, '#\1')
      File.open(file_path, "w") {|file| file.puts gemfile_text}
      puts gemfile_text
    end


    desc 'use published version of mambo gems - use MAMBO_LOCAL, MAMBO_DEV, and MAMBO_PUBLIC in your Gemfile to use this task'
    task :mambo_public do
      file_path = "Gemfile"
      gemfile_text = File.read(file_path)
      gemfile_text.gsub!(/^(gem.*MAMBO_LOCAL.*$)/, '#\1')
      gemfile_text.gsub!(/^(gem.*MAMBO_DEV.*$)/, '#\1')
      gemfile_text.gsub!(/^#(gem.*MAMBO_PUBLIC.*$)/, '\1')
      File.open(file_path, "w") {|file| file.puts gemfile_text}
      puts gemfile_text
    end

    desc 'prepare all mambo gems'
    task :prepare_mambo_gems do
      gem_dirs = Dir.glob(File.join(File.expand_path('~'), 'mambo', 'gems', '*'))

      gem_dirs.each do |dir|
        puts "Preparing #{dir}"
        Dir.chdir(dir) do 
          task = Rake::Task['mambo:support:prepare_gem']
          task.reenable
          task.invoke
        end
      end
    end

    desc 'bundle install all mambo gems'
    task :update_mambo_gems do
      gem_dirs = Dir.glob(File.join(File.expand_path('~'), 'mambo', 'gems', '*'))

      gem_dirs.each do |dir|
        puts "Updating #{dir}"
        Dir.chdir(dir) do 
          task = Rake::Task['mambo:support:update_gem']
          task.reenable
          task.invoke
        end
      end
    end
  end
end

