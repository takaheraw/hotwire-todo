class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_organization.tasks.ordered
  end

  def show
    @line_item_dates = @task.line_item_dates.includes(:line_items).ordered
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_organization.tasks.build(task_params)
    if @task.save
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: 'task was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'task was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: 'task was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'task was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'task was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'task was successfully destroyed.' }
    end
  end

  private

  def set_task
    @task = current_organization.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
