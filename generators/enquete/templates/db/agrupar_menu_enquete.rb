class AgruparMenuEnquete < ActiveRecord::Migration
  def self.up
     m = Menu.find_or_create_by_name("Enquete",:position => 7, :adm => true)
    Menu.transaction do 
       
      s = m.sub_menus.create!(:menu_id => m.id, :name => "Cadastrar Pergunta", :url => "/admin/questions/novo", 
          :title => "Clique aqui para cadastrar um(a) novo(a) pergunta", :position => 0) rescue nil
      s1 = m.sub_menus.create!(:menu_id => m.id, :name => "Listar Pergunta", :url => "/admin/questions", 
          :title => "Clique aqui para listar os(as) pergunta", :position => 1, :separator => true) rescue nil
        
      s2 = m.sub_menus.create!(:menu_id => m.id, :name => "Listar Usuarios Enquete", :url => "/admin/customer_enquetes", 
          :title => "Clique aqui para listar os(as) Usuarios", :position => 3) rescue nil
    end
    
  end

  def self.down
    Menu.delete_all
  end
end
