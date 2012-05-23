class AswersController < ApplicationController  
   def index
     @aswers = Aswer.all

     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @aswers }
     end
   end

   def show
     @aswer = Aswer.find(params[:id])
     respond_to do |format|
       format.html #show.html.erb
       format.xml  { render :xml => @aswer }
     end
   end
end