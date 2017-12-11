class AccountsController < ApplicationController
  def index
    @accounts = Account.where(user_id: session['user_id']);
  end

  def new
    @account = Account.new
  end

  def create
    Account.create account_params.merge({user_id: session['user_id']})
    redirect_to accounts_path
  end

  def edit
    @account = Account.find_by id: params[:id]
  end

  def update
    account = Account.find_by id: params[:id]
    account.update account_params
    redirect_to accounts_path
  end

  def destroy
    account = Account.find_by id: params[:id]
    account.delete
    redirect_to accounts_path
  end

  private
  def account_params
    params.require(:account).permit :id, :ip, :email, :username, :password, :api_key, :bitcoin, :dogecoin, :list
  end
end
