SOURCE_FILES = ['classification/**/*.rb']

# =======================
# = Documentation tasks =
# =======================
begin
  require 'yard'
  require 'yard/rake/yardoc_task'
  
  YARD::Rake::YardocTask.new :doc do |t|
    t.files   = SOURCE_FILES
    t.options = ['--output-dir', File.join('build', 'doc'),
                 '--readme', 'README.markdown']
  end

rescue LoadError
  desc 'You need the `yard` gem to generate documentation'
  task :documentation
end

desc 'Removes all build producs'
task :clobber do
  `rm -rf #{File.expand_path(File.join( File.dirname(__FILE__), 'build' ))}`
end
