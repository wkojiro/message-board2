class MessagesController < ApplicationController
  def index
    @message = Message.new #Messageモデルのオブジェクトの初期化
    @messages = Message.all #すべて取り出す。
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
    redirect_to root_path, notice: 'メッセージを保存しました。'
   # redirect_to 'http://www.google.co.jp/'
    else
   #メッセージが保存できなかった場合
     @message = Message.all
     flash.now[:alert] ="メッセージの保存に失敗しました。"
     render 'index'
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:name,:body)
  end
  ##ここまで
end
