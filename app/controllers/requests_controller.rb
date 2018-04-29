class RequestsController < ApplicationController
  def new
    pass = params[:password]
    account = Account.where(ip: params[:ip]).first

    user = User.find account.user_id
    if user.password != pass 
      render inline: 'window.alert("sai pass");' and return
    end

    if account.off?
      result = ''
      result += Slot.find_by(key: :variables).value
      result += 'delete $pages;'
      result += 'delete $this;'
      result += '$pages={};'

      result += '$this={};'
      Standard.all.each do |c|
        result += "$this['#{c.key}']= #{c.value};"
      end

      result += Slot.find_by(key: :run_loop).value

      render :inline => result

      return
    end

    result = ''
    result += "$email='#{account.email}';"
    result += "$cheapcaptcha_api_key='#{account.cheapcaptcha_api_key}';"
    result += "$anticaptcha_api_key='#{account.anticaptcha_api_key}';"
    result += "$_2captcha_api_key='#{account._2captcha_api_key}';"
    result += "$username='#{account.username}';"
    result += "$pass='#{account.password}';"
    result += "$wallet_bitcoin='#{account.bitcoin}';"
    result += "$wallet_dogecoin='#{account.dogecoin}';"

    result += "$wallet_litecoin='#{account.litecoin}';"
    result += "$wallet_ethereum='#{account.ethereum}';"
    result += "$wallet_bitcoin_cash='#{account.bitcoin_cash}';"
    result += "$wallet_blackcoin='#{account.blackcoin}';"
    result += "$wallet_dashcoin='#{account.dashcoin}';"
    result += "$wallet_peercoin='#{account.peercoin}';"
    result += "$wallet_primecoin='#{account.primecoin}';"
    result += "$wallet_potcoin='#{account.potcoin}';"
    result += "$wallet_kb3coin='#{account.kb3coin}';"

    list = Account.where(ip: params[:ip]).first
    if list
      result += Slot.find_by(key: :variables).value

      result += 'delete $pages;'
      result += 'delete $this;'

      result += '$pages={};'
      list = list.list.split(',').map{|p| p.to_i}
      pages = Page.where("id in (?)", list).where(status: :on).order :id
      pages.each do |p|
        result += "$pages['#{p.name}']={code: #{p.content}, time: #{p.time}, id: #{p.id}};"
      end


      result += '$this={};'
      Standard.all.each do |c|
        result += "$this['#{c.key}']= #{c.value};"
      end

      result += Slot.find_by(key: :run_loop).value

      render :inline => result
    else
      render html: 'error'
    end
  end

  def update
    pass = params[:password] || nil
    account = Account.where(ip: params[:ip]).first

    user = User.find account.user_id
    if user.password != pass 
      (render inline: 'window.close();' and return)
    end

    if account.off?
      result = ''
      result += 'delete $pages;'
      result += '$pages={};'

      render :inline => result

      return
    end

    result = ''
    result += "$email='#{account.email}';"
    result += "$cheapcaptcha_api_key='#{account.cheapcaptcha_api_key}';"
    result += "$anticaptcha_api_key='#{account.anticaptcha_api_key}';"
    result += "$_2captcha_api_key='#{account._2captcha_api_key}';"
    result += "$username='#{account.username}';"
    result += "$pass='#{account.password}';"
    result += "$wallet_bitcoin='#{account.bitcoin}';"
    result += "$wallet_dogecoin='#{account.dogecoin}';"

    result += "$wallet_litecoin='#{account.litecoin}';"
    result += "$wallet_ethereum='#{account.ethereum}';"
    result += "$wallet_bitcoin_cash='#{account.bitcoin_cash}';"
    result += "$wallet_blackcoin='#{account.blackcoin}';"
    result += "$wallet_dashcoin='#{account.dashcoin}';"
    result += "$wallet_peercoin='#{account.peercoin}';"
    result += "$wallet_primecoin='#{account.primecoin}';"
    result += "$wallet_potcoin='#{account.potcoin}';"
    result += "$wallet_kb3coin='#{account.kb3coin}';"

    list = Account.where(ip: params[:ip]).first
    if list

      result += 'delete $pages;'
      result += 'delete $this;'
      # result += Settings.variables
      result += '$pages={};'
      list = list.list.split(',').map{|p| p.to_i}
      pages = Page.where("id in (?)", list).where(status: :on).order :id
      pages.each do |p|
        result += "$pages['#{p.name}']={code: #{p.content}, time: #{p.time}, id: #{p.id}};"
      end


      result += '$this={};'
      Standard.all.each do |c|
        result += "$this['#{c.key}']= #{c.value};"
      end

      render :inline => result
    else
      render html: 'error'
    end
  end

  def report
    if params[:type] == 'no_balance'
      page = Page.find_by id: params[:id]
      page.off!
      page.save

      render html: 'iimDisplay("report done")'
    end
  end

  def data
    type = params[:type]
    if(type == 'baymack')
      data = '{' +  Settings.baymack + '}'
      # data = data + Slot.find_by(key: :baymack).value + '}'
     render inline: "$datas['data_baymack'] = #{data};"
    else
      redner inline: ''
    end
  end

  def add_data
    # type = params[:type]
    # if(type == 'baymack' && params[:ip] = 'lvc_home')
    #   slot = Slot.find_by(key: :baymack)
    #   data = slot.value
    #   data = data + ',' + params[:value]
    #   slot.update value: data
    # end
    render inline: ''
  end
end
