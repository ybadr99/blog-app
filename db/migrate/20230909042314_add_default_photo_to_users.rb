class AddDefaultPhotoToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :photo, "https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=826&t=st=1694233262~exp=1694233862~hmac=23b6ce65f35f6e4d8faba3da0d2bfc3894c9e39a06abca94d87e10797210e985"

  end
end
