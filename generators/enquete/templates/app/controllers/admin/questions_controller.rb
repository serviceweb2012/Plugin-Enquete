class Admin::QuestionsController < ApplicationController
  layout 'admin'
  before_filter :authorize

  def index
    @questions = Question.paginate(:page => params[:page], 
      :conditions => ["name LIKE ?", "%#{params[:search]}%"], :per_page => session[:per_page],:order => "#{$order} #{$ordem}")
    @count = @questions.length

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  def show
    @question = Question.find(params[:id])
    @total_votos = 0;
    @question.aswers.each do |cp|
      @total_votos += cp.quant
    end
    
    respond_to do |format|
      format.html { render :layout => 'show' }
      format.xml  { render :xml => @question }
    end
  end

  def new
    @question = Question.new
    @question.aswers.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        flash[:notice] = 'Pergunta foi criada com sucesso.'
        format.html { redirect_to(new_admin_question_path) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @question = Question.find(params[:id])
    url = admin_questions_path+"?search=#{params[:search]}"

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Pergunta foi atualizada com sucesso.'
        format.html { redirect_to(url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(admin_questions_url) }
      format.xml  { head :ok }
    end
  end
   
   
  def delete_image
    url = request.referer
    modelo = Question.find(params[:id])
    nomeImagem = modelo.image_file_name

    modelo.delete_image("#{RAILS_ROOT}/public/images/#{modelo.class.to_s.downcase.pluralize}",nomeImagem)
    modelo.update_attributes(:image_file_name => nil, 
      :image_content_type => nil,
      :image_file_size => nil)
    
    redirect_to url
  end

  protected
end