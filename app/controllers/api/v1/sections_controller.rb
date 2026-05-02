module Api
  module V1
    class SectionsController < ApplicationController
      # 모바일에서 호출하는 전체 목록 (모든 상태 포함)
      def index
        @sections = Section.all.order(updated_at: :desc)
        render json: sections_json(@sections)
      end

      def show
        @section = Section.find(params[:id])
        render json: section_json(@section)
      end

      # 모바일 동기화 전용 엔드포인트
      # BUG FIX: 이전에는 completed 상태만 반환하여 in_progress 섹션이 모바일에 표시되지 않았음
      # 수정: in_progress + completed 상태를 모두 포함하여 반환
      def sync
        since = params[:since].present? ? Time.parse(params[:since]) : nil

        @sections = if since
          Section.for_mobile_sync.where('updated_at > ?', since)
        else
          Section.for_mobile_sync
        end

        render json: {
          sections:   sections_json(@sections),
          synced_at:  Time.current.iso8601,
          total:      @sections.count
        }
      end

      private

      def sections_json(sections)
        sections.map { |s| section_json(s) }
      end

      def section_json(section)
        {
          id:           section.id,
          title:        section.title,
          description:  section.description,
          status:       section.status,
          progress:     section.progress,
          started_at:   section.started_at&.iso8601,
          completed_at: section.completed_at&.iso8601,
          updated_at:   section.updated_at.iso8601,
          created_at:   section.created_at.iso8601
        }
      end
    end
  end
end
