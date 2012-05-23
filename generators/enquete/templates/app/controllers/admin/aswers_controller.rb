class Admin::AswersController < ApplicationController
  layout 'admin'
  before_filter :authorize
  before_filter :load_questions, :only => [:new, :edit, :create, :update]

   def index
     @aswers = Aswer.paginate(:page => params[:page], 
                            :conditions => ["name LIKE ?", "%#{params[:search]}%"], :per_page => session[:per_page],:order => "#{$order} #{$ordem}")
     @count = @aswers.length

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @aswers }
     end
   end

   def show
     @aswer = Aswer.find(params[:id])
     respond_to do |format|
       format.html { render :layout => 'show' }
       format.xml  { render :xml => @aswer }
     end
   end

   def new
     @aswer = Aswer.new

     respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @aswer }
     end
   end

   def edit
     @aswer = Aswer.find(params[:id])
   end

   def create
     @aswer = Aswer.new(params[:aswer])

     respond_to do |format|
       if @aswer.save
         flash[:notice] = 'Aswer foi criada com sucesso.'
         format.html { redirect_to(new_admin_aswer_path) }
         format.xml  { render :xml => @aswer, :status => :created, :location => @aswer }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @aswer.errors, :status => :unprocessable_entity }
       end
     end
   end

   def update
     @aswer = Aswer.find(params[:id])
     url = admin_aswers_path+"?search=#{params[:search]}"

     respond_to do |format|
       if @aswer.update_attributes(params[:aswer])
         flash[:notice] = 'Aswer foi atualizada com sucesso.'
         format.html { redirect_to(url) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @aswer.errors, :status => :unprocessable_entity }
       end
     end
   end

   def destroy
     @aswer = Aswer.find(params[:id])
     @aswer.destroy

     respond_to do |format|
       format.html { redirect_to(admin_aswers_url) }
       format.xml  { head :ok }
     end
   end
   
   
   def delete_image
    url = request.referer
    modelo = Aswer.find(params[:id])
    nomeImagem = modelo.image_file_name

    modelo.delete_image("#{RAILS_ROOT}/public/images/#{modelo.class.to_s.downcase.pluralize}",nomeImagem)
    modelo.update_attributes(:image_file_name => nil, 
                           :image_content_type => nil,
                           :image_file_size => nil)
    
    redirect_to url
   end

   protected
  def load_questions        
		@questions = Question.find(:all, :select => "id, name", :order => "name ASC").collect { |c| [c.name, c.id ] }
	end
end