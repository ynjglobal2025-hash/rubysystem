module Admin
  class SectionsController < ApplicationController
    before_action :set_section, only: [:show, :edit, :update, :destroy]

    def index
      @sections = Section.all.order(updated_at: :desc)
      @in_progress_count = Section.in_progress.count
      @completed_count   = Section.completed.count
      @pending_count     = Section.pending.count
    end

    def show; end

    def new
      @section = Section.new
    end

    def edit; end

    def create
      @section = Section.new(section_params)
      if @section.save
        redirect_to admin_section_path(@section), notice: '섹션이 생성되었습니다.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @section.update(section_params)
        redirect_to admin_section_path(@section), notice: '섹션이 업데이트되었습니다.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @section.destroy
      redirect_to admin_sections_path, notice: '섹션이 삭제되었습니다.'
    end

    private

    def set_section
      @section = Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:title, :description, :status, :progress)
    end
  end
end
