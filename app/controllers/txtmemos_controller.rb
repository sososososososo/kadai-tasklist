class TxtmemosController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    #@tasks = Task.all
    @txtmemos = Txtmemo.order(created_at: :desc).all.page(params[:page]).per(5)
  end
  
  def show
   # p params
   # raise
    #@txtmemo = Txtmemo.find_by(id: params[:user_id])
    #@txtmemo = Txtmemo.find_by(id: session[:txtmemo_id])
  end

  def new
    @txtmemo = Txtmemo.new
  end

  def create
    #@txtmemo = Txtmemo.new(task_params)
    #@txtmemo.user = User.find_by(id: session[:user_id])
    
    @txtmemo = current_user.txtmemos.build(txtmemo_params)
    
    #p @txtmemo
    #raise
    
    if @txtmemo.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @txtmemo
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
    #@txtmemo = Txtmemo.find_by(params[:id])
  end

  def update
    #@txtmemo = Txtmemo.new(task_params)
    #@txtmemo.user = User.find_by(id: session[:user_id])
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
    redirect_to user_path(current_user.id)
  end
  
  
  private
  def task_params
    params.require(:txtmemo).permit(:id, :content, :status)
  end
  
  def set_task
    @txtmemo = Txtmemo.find_by(id: params[:id])
  end
  
  def txtmemo_params
    params.require(:txtmemo).permit(:id, :content, :status)
  end
end
