module Mobile
  class SectionsController < ApplicationController
    layout 'mobile'

    def index
      @sections = Section.all.order(updated_at: :desc)
      @in_progress = Section.in_progress.order(updated_at: :desc)
      @completed   = Section.completed.order(updated_at: :desc)
      @pending     = Section.pending.order(updated_at: :desc)
    end

    def show
      @section = Section.find(params[:id])
    end
  end
end
