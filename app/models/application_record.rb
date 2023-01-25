class ApplicationRecord < ActiveRecord::Base
  
# データベースのテーブルを用意しない場合に記述  
  self.abstract_class = true
  
end
