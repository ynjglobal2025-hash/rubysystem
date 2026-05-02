Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 모바일 앱(React Native, Flutter 등)에서 오는 요청 허용
    origins '*'

    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['X-Total-Count']
  end
end
