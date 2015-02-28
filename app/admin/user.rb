ActiveAdmin.register User do

  menu priority: 2
  
  permit_params :name, :email, :password, group_ids: []

  # index page of User Administration
  index do
    selectable_column
    # id_column
    column :email
    column "Signed In", :sign_in_count, :sortable => :sign_in_count do |user|
      pluralize user.sign_in_count, 'time'
    end
    column "Last Login", :last_sign_in_at, :sortable => :last_sign_in_at do |user|
      user.last_sign_in_at ? "#{time_ago_in_words user.last_sign_in_at} ago" : "Never"
    end
    column :groups do | user |
      ul do
        user.groups.each do |g|
          li link_to g.name, admin_group_path(g)
        end ? nil : nil
      end
    end
    actions
  end

  # show page of User Administration
  show do
    attributes_table do
      # row :name
      row :email
      row "Signed In", :sign_in_count do |user|
        pluralize user.sign_in_count, 'time'
      end
      row "Last Login", :last_sign_in_at do |user|
        user.last_sign_in_at ? "#{time_ago_in_words user.last_sign_in_at} ago" : "Never"
      end
      row :last_sign_in_ip
      row :failed_attempts
    end
  end
  
  controller do
    def scoped_collection
      User.includes(:groups)   # includes User / Brand models in listing products
    end
  end
  
  sidebar 'Group Memberships', :only => :show do
    ul do
      user.groups.each do |g|
        li link_to g.name, admin_group_path(g)
      end ? nil : nil
    end
  end

  # edit and create page of User Administration
  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :password, as: :password
      f.input :groups, as: :select, multiple: false, collection: Group.all
    end
    f.actions
  end
end
