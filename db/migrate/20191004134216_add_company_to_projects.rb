class AddCompanyToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :company, foreign_key: true
  end
end
