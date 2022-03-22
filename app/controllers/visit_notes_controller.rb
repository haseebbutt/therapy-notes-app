class VisitNotesController < ApplicationController
  def index 
    visit_notes = VisitNote.includes(:patient, :observations).order(created_at: :desc)
    render json: visit_notes, status: 200
  end

  def create
    visit_note = VisitNote.new(visit_note_params)

    observation_params["observations"].each do |observation|
      visit_note.observations.build(observation)
    end

    if visit_note.save
      render json: visit_note, status: 200
    else
      render json: errors.full_messages
    end
  end

  def update
    visit_note = VisitNote.find(params[:id])

    observation_params["observations"].each do |observation|
      update_observation = Observation.find(observation['id'])
      update_observation.update(observation)
    end

    if visit_note.update(visit_note_params)
      render json: visit_note, status: 200
    else
      render json: errors.full_messages
    end
  end

  def destroy
    visit_note = VisitNote.find(params[:id])

    if visit_note.destroy
      render json: { message: 'Visit note was successfully deleted.'}
    else
      render json: { message: errors.full_messages, status: :unprocessable_entity }
    end
  end

  private

  def visit_note_params
    params.require(:visit_note).permit(:title, :description, :patient_id)
  end

  def observation_params
    params.permit(observations: [[ :id, :title, :body, :result ]])
  end

end