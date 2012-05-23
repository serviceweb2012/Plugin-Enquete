class Admin::CustomerEnquetesController < ApplicationController
  layout 'admin'
  before_filter :authorize

   def index
     @question = Question.actived?.last
	  if @question
       @customer_enquetes = CustomerEnquete.paginate(:page => params[:page], 
                            :conditions => ["name LIKE ? and question_id = ?", "%#{params[:search]}%", @question.id], :per_page => session[:per_page],:order => "#{$order} #{$ordem}")
     @count = @customer_enquetes.length
     else
       @customer_enquetes = []
       @count = 0
     end
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @customer_enquetes }
     end
   end

   def show
     @customer_enquete = CustomerEnquete.find(params[:id])
     respond_to do |format|
       format.html { render :layout => 'show' }
       format.xml  { render :xml => @customer_enquete }
     end
   end

   def new
     @customer_enquete = CustomerEnquete.new

     respond_to do |format|
       format.html # new.html.erb
       format.xml  { render :xml => @customer_enquete }
     end
   end

   def edit
     @customer_enquete = CustomerEnquete.find(params[:id])
   end

   def create
     @customer_enquete = CustomerEnquete.new(params[:customer_enquete])

     respond_to do |format|
       if @customer_enquete.save
         flash[:notice] = 'CustomerEnquete foi criada com sucesso.'
         format.html { redirect_to(new_admin_customer_enquete_path) }
         format.xml  { render :xml => @customer_enquete, :status => :created, :location => @customer_enquete }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @customer_enquete.errors, :status => :unprocessable_entity }
       end
     end
   end

   def update
     @customer_enquete = CustomerEnquete.find(params[:id])
     url = admin_customer_enquetes_path+"?search=#{params[:search]}"

     respond_to do |format|
       if @customer_enquete.update_attributes(params[:customer_enquete])
         flash[:notice] = 'CustomerEnquete foi atualizada com sucesso.'
         format.html { redirect_to(url) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @customer_enquete.errors, :status => :unprocessable_entity }
       end
     end
   end

   def destroy
     @customer_enquete = CustomerEnquete.find(params[:id])
     @customer_enquete.destroy

     respond_to do |format|
       format.html { redirect_to(admin_customer_enquetes_url) }
       format.xml  { head :ok }
     end
   end
   
   
   def delete_image
    url = request.referer
    modelo = CustomerEnquete.find(params[:id])
    nomeImagem = modelo.image_file_name

    modelo.delete_image("#{RAILS_ROOT}/public/images/#{modelo.class.to_s.downcase.pluralize}",nomeImagem)
    modelo.update_attributes(:image_file_name => nil, 
                           :image_content_type => nil,
                           :image_file_size => nil)
    
    redirect_to url
   end

   protected
end