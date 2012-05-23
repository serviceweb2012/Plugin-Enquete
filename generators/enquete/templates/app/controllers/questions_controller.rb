class QuestionsController < ApplicationController
  
  # after_filter :teste, :only => [:update]
  def index
    @questions = Question.all

    respond_to do |format|
      format.html {render :layout => false}# index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  def show
    @question = Question.find(params[:id])
    @ultima = Aswer.last(:order => "updated_at DESC")
    @total_votos = 0;
    @question.aswers.each do |cp|
      @total_votos += cp.quant
    end

    @porct = []
    @question.aswers.each_with_index  do |c, index|
      @porct[index] =  format("%.2f",(c.quant.to_f/@total_votos)*100)

    end

    respond_to do |format|
      format.html {render :layout => false}#show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  def update
    #@question = Question.find(params[:id])
   
    
    url = request.referer      
    if session[:enquete] == params[:captcha].to_i
      @aswer = Aswer.find(params[:value])
      @aswer.quant += 1
      session[:aswer] = @aswer.id
      respond_to do |format|
        if @aswer.save
          flash[:notice] = 'Votação enviada com sucesso!'
          format.js
          format.html { redirect_to(url) } 
          
        else
          flash[:notice] = 'Ocorreu um erro na sua votação!'
          format.html { redirect_to(url) }
          format.js
          
        end
      end
    else
      respond_to do |format|
        flash[:notice] = 'Código de segurança inválido! Por favor, tente novamente.'
        format.html { redirect_to(url) } 
        format.js
      end
    end
  end
  

end