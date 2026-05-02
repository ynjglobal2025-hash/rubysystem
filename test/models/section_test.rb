require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test 'in_progress sections are included in mobile sync scope' do
    section = Section.create!(title: '진행 중 섹션', status: :in_progress, progress: 50)
    assert_includes Section.for_mobile_sync, section,
      'for_mobile_sync 스코프가 in_progress 섹션을 포함해야 합니다'
  end

  test 'completed sections are included in mobile sync scope' do
    section = Section.create!(title: '완료 섹션', status: :completed, progress: 100)
    assert_includes Section.for_mobile_sync, section
  end

  test 'pending sections are excluded from mobile sync scope' do
    section = Section.create!(title: '대기 섹션', status: :pending, progress: 0)
    assert_not_includes Section.for_mobile_sync, section,
      'for_mobile_sync 스코프는 pending 섹션을 제외해야 합니다'
  end

  test 'valid section saves successfully' do
    section = Section.new(title: '테스트', status: :pending, progress: 0)
    assert section.valid?
  end

  test 'section requires title' do
    section = Section.new(status: :pending)
    assert_not section.valid?
    assert_includes section.errors[:title], "can't be blank"
  end
end
