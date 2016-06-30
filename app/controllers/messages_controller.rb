class MessagesController < ApplicationController
  before_action :set_message, only:[:edit, :update, :destroy]
  
  def index
    @message = Message.new #Messageモデルのオブジェクトの初期化
    @messages = Message.all #すべて取り出す。
  end
  
  def create
 #   binding.pry
    @message = Message.new(message_params)
    if @message.save
    redirect_to root_path, notice: 'メッセージを保存しました。'
   # redirect_to 'http://www.google.co.jp/'
    else
   #メッセージが保存できなかった場合
     @messages = Message.all
     flash.now[:alert] ="メッセージの保存に失敗しました。"
     render 'index'
    end
  end
  
  def edit
  end
  
  def update
    if @message.update(message_params)
      #保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました。'
    else
      render 'edit'
    end
  end
  
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
  end
  
  private
  def message_params
    params.require(:message).permit(:name,:body)
  end
  
  def set_message
   @message = Message.find(params[:id])
  end
  ##ここまで
end
