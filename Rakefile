SOURCE_FILES = FileList['classification/**/*.rb', 'controller/*.rb'].to_a

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
  task :doc
end

# =======================
# = Code review tasks =
# =======================
begin
  require 'metric_fu'
  MetricFu::Configuration.run do |config|
    # Deactivated: saikuro, stats, rcov
    config.metrics  = [:churn, :flog, :flay, :reek, :roodi]
    config.graphs   = [:flog, :flay, :reek, :roodi, :rcov]
    config.flay     = { :dirs_to_flay => ['controller', 'lib'],
                        :minimum_score => 100  } 
    config.flog     = { :dirs_to_flog => ['controller', 'lib']  }
    config.reek     = { :dirs_to_reek => ['controller', 'lib']  }
    config.roodi    = { :dirs_to_roodi => ['controller', 'lib'] }
    config.churn    = { :start_date => "1 year ago", :minimum_churn_count => 10}
    config.rcov     = { :environment => 'test',
                        :test_files => ['test/**/*_test.rb', 
                                        'spec/**/*_spec.rb'],
                        :rcov_opts => ["--sort coverage", 
                                       "--no-html", 
                                       "--text-coverage",
                                       "--no-color",
                                       "--profile",
                                       "--rails",
                                       "--exclude /gems/,/Library/,spec"]}
    config.graph_engine = :bluff
  end
rescue LoadError
  desc 'You need the metric_fu gem'
  task :metrics
end
