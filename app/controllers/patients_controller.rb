class PatientsController < ApplicationController
  def index
    patients = Patient.all.order(created_at: :desc)
    render json: patients, status: 200
  end

  def create
    patient = Patient.new(patient_params)
    
    if patient.save
      render json: patient, status: 200
    else
      render json: errors.full_messages
    end
  end

  def update
    patient = Patient.find(params[:id])

    if patient.update(patient_params)
      render json: patient, status: 200
    else
      render json: errors.full_messages
    end
  end

  def destroy
    patient = Patient.find(params[:id])

    if patient.destroy
      render json: { message: 'Patient was successfully deleted.'}
    else
      render json: { message: errors.full_messages, status: :unprocessable_entity }
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name)
  end
end