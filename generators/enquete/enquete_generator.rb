class EnqueteGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory(File.join('db/', 'migrate'))
      
       m.file 'enquete.js', 'public/javascripts/enquete.js'
	   m.file 'enquete.css', 'public/stylesheets/enquete.css'
      #copia estrutura mvc
      src = File.join(File.dirname(__FILE__), "templates", "app")
      dest = destination_path('.')
      FileUtils.cp_r src, dest
 
      #copia estrutura public
      src = File.join(File.dirname(__FILE__), "templates", "public")
      dest = destination_path('.')
      FileUtils.cp_r src, dest
	   
      #cria migracao
	  m.file 'db/create_questions.rb', "db/migrate/#{(Time.now).strftime("%Y%m%d%H%M%S")}_create_questions.rb"
      m.file 'db/create_aswers.rb', "db/migrate/#{(Time.now + 1.seconds).strftime("%Y%m%d%H%M%S")}_create_aswers.rb"
      m.file 'db/create_customer_enquetes.rb', "db/migrate/#{(Time.now + 2.seconds).strftime("%Y%m%d%H%M%S")}_create_customer_enquetes.rb"
      m.file 'db/agrupar_menu_enquete.rb', "db/migrate/#{(Time.now + 3.seconds).strftime("%Y%m%d%H%M%S")}_agrupar_menu_enquete.rb"
      
      add_rotas
      add_application
      add_ptbr
      #add_application_layout
    end
  end
  protected
  def add_rotas
		path = destination_path('config/routes.rb')
		content = File.read(path)
    
		sentinel = "map.resources :questions"
		if existing_content_in_file(content, sentinel)
			env = "ActionController::Routing::Routes.draw do |map|"
			gsub_file 'config/routes.rb', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\nmap.resources :customer_enquetes\nmap.resources :questions\nmap.resources :aswers"
			end
		end
    
    sentinel = "admin.resources :questions"
		if existing_content_in_file(content, sentinel)
			env = "map.namespace :admin do |admin|"
			gsub_file 'config/routes.rb', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\nadmin.resources :questions\nadmin.resources :aswers\nadmin.resources :customer_enquetes"
			end
		end
	end
  
  def add_ptbr
		path = destination_path('config/locales/pt-BR.yml')
		content = File.read(path)
    
		sentinel = "question:"
		if existing_content_in_file(content, sentinel)
			env = " models:"
			gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        question:\n            one: \"Pergunta\"\n            other: \"Perguntas\""
			end
      gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        aswer:\n            one: \"Resposta\"\n            other: \"Resposta\""
			end
      gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        customerenquete:\n            one: \"Usuario\"\n            other: \"Usuarios\""
			end
			env = " attributes:"
			gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        question:\n            name: \"Nome\"\n            cadastro: \"Deseja cadastrar o usuário que votar nesta enquete\"\n            situation: \"Situação\""
      end
      gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        aswer:\n            name: \"Nome\"\n            question_id: \"Questão\"\n            quant: \"Quantidade\""
      end
       gsub_file 'config/locales/pt-BR.yml', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n        customerenquete:\n            name: \"Nome\"\n            email: \"Email\"\n            phone: \"Telefone\"\n            city: \"Cidade\"\n            situation: \"Situação\"\n            question_id: \"Enquete\""
      end
		end
    
  end
    
  def add_application
		path = destination_path('app/controllers/application.rb')
		content = File.read(path)
    
		sentinel = "def load_enquete"
		if existing_content_in_file(content, sentinel)
			env = "class ApplicationController < ActionController::Base"
			gsub_file 'app/controllers/application.rb', /(#{Regexp.escape(env)})/mi do |match|
        "#{match}\n\n\n\t\tdef load_enquete\n\t\t\tvalor = 1000+rand(901)\n\n\t\t\tsession[:enquete] = valor\n\t\t\tsession[:valor] = 0\n\t\tunless Question.actived?.last.nil?\n\t\t\tif Question.actived?.last.cadastro == true\n\t\t\tsession[:valor] = 1\n\t\t\tend\n\t\tend\n\t\tend"
			end
		end
	end
  
  def existing_content_in_file(content, er)
    match = /(#{Regexp.escape(er)})/mi
    match = match.match(content)
    match.nil?
  end
  
  def gsub_file(relative_destination, regexp, *args, &block)
    path = destination_path(relative_destination)
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end
	
  
end
