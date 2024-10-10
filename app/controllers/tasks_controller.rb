class TasksController < ApplicationController
    before_action :set_task, only: [:complete]
  
    # GET /tasks
    def index
      @tasks = Task.where(status: false) # แสดงเฉพาะงานที่ยังไม่เสร็จ
      @task = Task.new
    end
  
    # POST /tasks
    def create
      @task = Task.new(task_params)
      @task.status = false # งานใหม่จะถูกสร้างด้วยสถานะยังไม่เสร็จโดยค่าเริ่มต้น
  
      if @task.save
        redirect_to tasks_path, notice: 'สร้างงานเรียบร้อยแล้ว'
      else
        render :index
      end
    end
  
    # PATCH /tasks/:id/complete
    def complete
      @task.update(status: true)
      redirect_to tasks_path, notice: 'ทำเครื่องหมายว่างานเสร็จเรียบร้อยแล้ว'
    end
  
    private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title)
    end
  end
  