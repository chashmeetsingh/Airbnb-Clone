class DogController < ApplicationController
  add_flash_types :error, :success
  before_action :authenticate_user!

  def index
    @dogs = current_user.dogs
  end

  def add
    if create_dog(params)
      redirect_to dog_index_url, success: 'Successfully Added Dog'
    else
      redirect_to dog_index_url, error: 'Error adding!'
    end
  end

  def remove
    if delete_dog(params[:dog_id])
      redirect_to dog_index_url, success: "Dog data successfully removed"
    else
      redirect_to dog_index_url, error: "Error deleting dog"
    end
  end

  def api
    if create_dog(params)
      dog = current_user.dogs.last
      render json: {
        message: 'created',
        dog_name: dog.name,
        dog_id: dog.id
      }, status: 200
    else
      render json: {
        message: 'error creating'
      }, status: 400
    end
  end

  private

  def create_dog(params)
    dog = Dog.new(
      name: params[:name],
      year: params[:year],
      month: params[:month],
      gender: params[:gender],
      breed: params[:breed],
      size: params[:size],
      description: params[:description],
      user: current_user
    )
    dog.save
  end

  def delete_dog(id)
    Dog.find(id).destroy
  end
end
