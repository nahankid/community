ActiveAdmin.register Group do
  menu priority: 4

  permit_params :name, :description, :parent, user_ids: [], manager_ids: [], child_ids: []

  sortable tree: true, sorting_attribute: :ancestry, collapsible: true, start_collapsed: true

  index as: :sortable do
    config.filters = false
    label :name
    actions
  end
      
  index do
    selectable_column
    column :name
    column :users do | group |
      group.users.count
    end
    column :parent
    column :children do | group |
      ul do
        group.children.each do |m|
          li link_to m.name, admin_group_path(m)
        end ? nil : nil
      end
    end
    actions
  end

  # show page of Group Administration
  show do
    attributes_table do
      # row :name
      row :parent
      row "Subgroups", :children do |group|
        ul do
          group.children.each do |m|
            li link_to m.name, admin_group_path(m)
          end ? nil : nil
        end
      end
    end
  end

  sidebar 'Group Members', :only => :show do
    ul do
      group.users.each do |m|
        li link_to m.name, admin_user_path(m)
      end ? nil : nil
    end
  end

  form do |f|
    f.inputs "Group" do
      f.input :name
      f.input :users, as: :select, multiple: false, collection: User.all
      # f.input :parent, as: :select, multiple: false, collection: Group.where.not(id: f.object.id)
      # f.input :children, as: :select, multiple: false, collection: Group.where.not(id: f.object.id)
    end
    f.actions
  end
  
  filter :name
  # filter :users
  filter :parent
  filter :children
end
