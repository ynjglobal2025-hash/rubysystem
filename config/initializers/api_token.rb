# API 토큰 설정
# 실제 운영 시 ENV['API_SECRET_TOKEN'] 환경변수로 관리하세요
RAIL_API_TOKEN = ENV.fetch('API_SECRET_TOKEN', 'ruby-admin-secret-token-2026')
