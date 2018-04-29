class AccountsController < ApplicationController
  def index
    if params[:update_all]
      redirect_to(accounts_path) and return unless params[:ids]
      params[:ids].each do |i|
        account = Account.find i
        account.update "#{params[:type]}": params[:value]
      end
      redirect_to accounts_path
    elsif params[:order]
      @accounts = Account.where(user_id: session['user_id']).order("#{params['type']}": params[:value]).page(params[:page])
    else
      @accounts = Account.where(user_id: session['user_id']).order(:ip).page(params[:page])
    end
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
    redirect_to edit_account_path(account)
  end

  def destroy
    account = Account.find_by id: params[:id]
    account.delete
    redirect_to accounts_path
  end

  def copy
    acc = Account.find params[:id]
    acc.id = nil
    @account = Account.new
    @account.assign_attributes acc.attributes
    render :new
  end

  private
  def account_params
    params.require(:account).permit :id, :litecoin, :ethereum, :bitcoin_cash, :bitcore, :blackcoin,
      :dashcoin, :peercoin, :primecoin, :anticaptcha_api_key, :_2captcha_api_key, :potcoin, :kb3coin, :info,
     :ip, :email, :username, :password, :cheapcaptcha_api_key, :bitcoin, :dogecoin, :list, :status
  end
end
