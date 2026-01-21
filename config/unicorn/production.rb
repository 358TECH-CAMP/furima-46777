# 1. プロジェクトのルートディレクトリ(/var/www/furima-46777)を指すように設定
app_path = File.expand_path('../../../../', __FILE__)

# 2. アプリケーションサーバの性能を決定する
worker_processes 1

# 3. 自動デプロイ環境(current)と手動デプロイ環境の両方で動くように設定
working_directory "#{app_path}/current" rescue working_directory app_path

# 4. Unicornの起動に必要なファイルの設置場所を指定
pid "#{app_path}/shared/tmp/pids/unicorn.pid" rescue pid "#{app_path}/tmp/pids/unicorn.pid"

# 5. ポート番号ではなく、ソケット通信（.sock）を指定
listen "#{app_path}/shared/tmp/sockets/unicorn.sock" rescue listen "#{app_path}/tmp/sockets/unicorn.sock"

# 6. ログを記録するファイルを指定
stderr_path "#{app_path}/shared/log/unicorn.stderr.log" rescue stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log" rescue stdout_path "#{app_path}/log/unicorn.stdout.log"

# 7. Railsアプリケーションの応答を待つ上限時間を設定
timeout 60

# --- 以下、応用的な設定 ---
preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true
check_client_connection false
run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  if run_once
    run_once = false
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end