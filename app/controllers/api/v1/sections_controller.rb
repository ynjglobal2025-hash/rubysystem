module Api
  module V1
    class SectionsController < BaseController

      # GET /api/v1/sections
      def index
        @sections = Section.all.order(updated_at: :desc)
        response.set_header('X-Total-Count', @sections.count.to_s)
        render json: { sections: sections_json(@sections) }
      end

      # GET /api/v1/sections/:id
      def show
        @section = Section.find(params[:id])
        render json: { section: section_json(@section) }
      end

      # GET /api/v1/sections/sync
      # 모바일 앱에서 주기적으로 호출하는 동기화 엔드포인트
      # BUG FIX: in_progress 섹션이 누락되던 문제 수정 (in_progress + completed 모두 반환)
      def sync
        since = params[:since].present? ? Time.parse(params[:since]) : nil

        @sections = if since
          Section.for_mobile_sync.where('updated_at > ?', since)
        else
          Section.for_mobile_sync
        end

        render json: {
          sections:  sections_json(@sections),
          synced_at: Time.current.iso8601,
          total:     @sections.count
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
