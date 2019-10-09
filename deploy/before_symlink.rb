run "rm -rf #{config.release_path}/public/uploads"
run "ln -nfs #{config.shared_path}/public/uploads #{config.release_path}/public/uploads"
