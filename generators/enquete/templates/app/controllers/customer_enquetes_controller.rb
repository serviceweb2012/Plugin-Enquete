class CustomerEnquetesController < ApplicationController  
   def index
     @customer = CustomerEnquete.new

    respond_to do |format|
      format.html {render :layout => false}
      #format.xml  { render :xml => @customers }
    end
  end

  def show
    @customer = CustomerEnquete.find(params[:id])
    respond_to do |format|
      format.html #show.html.erb
      format.xml  { render :xml => @customer }
    end
  end
   
  def new
    @customer = CustomerEnquete.new

    respond_to do |format|
      format.html {render :layout => false}# new.html.erb
      format.xml  { render :xml => @customer }
    end
  end
   
  def create
    @customer = CustomerEnquete.new(params[:customer])
    @customer.question_id = Question.actived?.last.id
    @customer.name = params[:name]
    @customer.email = params[:email]
    @customer.city = params[:city]
    @customer.phone = params[:phone]
 
    respond_to do |format|
      if @customer.save
        flash[:notice] = 'Usuario foi criada com sucesso.'
        format.html {render :layout => false}
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
      else
        format.html { render :layout => false }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end
end