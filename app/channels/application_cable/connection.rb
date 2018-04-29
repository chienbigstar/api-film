module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :ip

    def connect
      if user = User.find_by_id(cookies[:user_id])
        self.current_user = user
        self.ip = cookies[:ip]
      else
        reject_unauthorized_connection
      end
    end
  end
end
