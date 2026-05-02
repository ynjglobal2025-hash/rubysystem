Section.destroy_all

Section.create!([
  { title: '프로젝트 기획',     status: :completed,   progress: 100, description: '요구사항 분석 및 기획 완료' },
  { title: 'UI/UX 디자인',      status: :completed,   progress: 100, description: '디자인 시스템 구축 완료' },
  { title: '백엔드 API 개발',   status: :in_progress, progress: 65,  description: 'REST API 개발 진행 중' },
  { title: '프론트엔드 개발',   status: :in_progress, progress: 40,  description: '컴포넌트 개발 진행 중' },
  { title: '모바일 앱 연동',    status: :in_progress, progress: 20,  description: '모바일 동기화 작업 진행 중' },
  { title: '테스트 및 QA',      status: :pending,     progress: 0,   description: '테스트 예정' },
  { title: '배포 및 런칭',      status: :pending,     progress: 0,   description: '배포 예정' }
])

puts "Seed data created: #{Section.count} sections"
