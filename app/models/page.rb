class Page < ApplicationRecord
  enum coin: [:bitcoin, :dogecoin]
end
