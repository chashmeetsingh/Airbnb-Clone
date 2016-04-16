class PetsController < ApplicationController
  add_flash_types :error, :success
  before_action :authenticate_user!

  def index
    @pets = current_user.pets
  end

  def add
    if create_pet(params)
      redirect_to pets_index_url, success: 'Successfully Added Pet'
    else
      redirect_to pets_index_url, error: 'Error adding!'
    end
  end

  def remove
    if delete_pet(params[:pet_id])
      redirect_to pets_index_url, success: "Pet data successfully removed"
    else
      redirect_to pets_index_url, error: "Error deleting dog"
    end
  end

  def api
    if create_pet(params)
      pet = current_user.pets.last
      render json: {
        message: 'created',
        pet_name: pet.name,
        pet_id: pet.id
      }, status: 200
    else
      render json: {
        message: 'error creating'
      }, status: 400
    end
  end

  private

  def create_pet(params)
    pet = Pet.new(
      name: params[:name],
      year: params[:year],
      month: params[:month],
      gender: params[:gender],
      pet_type: params[:pet],
      size: params[:size],
      description: params[:description],
      user: current_user
    )
    pet.save
  end

  def delete_pet(id)
    Pet.find(id).destroy
  end
end
