class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    #@tasks = Task.all
    @txtmemos = Txtmemo.order(created_at: :desc).all.page(params[:page]).per(5)
  end
  
  def show
    @txtmemo = Txtmemo.find_by(id: params[:id])
  end

  def new
    @txtmemo = Txtmemo.new
  end

  def create
    @txtmemo = Txtmemo.new(task_params)
    @txtmemo.user = User.find_by(id: session[:user_id])
    if @txtmemo.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @txtmemo
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    @txtmemo = Txtmemo.new(task_params)
    @txtmemo.user = @current_user
    if @txtmemo.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @txtmemo
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @txtmemo = Txtmemo.find(params[:id])
    @txtmemo.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  
  private
  def task_params
    params.require(:txtmemo).permit(:content, :status)
  end
  
  def set_task
    @txtmemo = Txtmemo.find_by(id: params[:txtmemo_id])
  end
  
end