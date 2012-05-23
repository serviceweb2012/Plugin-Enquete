module EnqueteHelper 
def gera_enquete(pergunta)
	html = %()
	if pergunta
		html <<  "<div class='questions'> "
		html <<  "<h1>enquete</h1>"
		html <<  "<p>#{pergunta.name}</p>"
		html <<  "<div class='sessao'>"
		html <<  "<p class='valor'> #{session[:valor]} </p>"
		html <<	 "</div>"
		html <<  "<form id='edit_question_#{pergunta.id}' class='edit_question' method='post' action='/questions/#{pergunta.id}'>"
		html <<  "<input name='authenticity_token' type='hidden' value='#{form_authenticity_token}' /> <input name='_method' type='hidden' value='put'>"
				  pergunta.aswers.each do |cp|
					html <<  "<p>#{radio_button_tag('value', cp.id)} <span class='answer'>#{cp.name}</span></p>"
				  end
			html <<  "<div class='enquete' id='enquete'>"
			html <<  "<h2>Código de Segurança</h2>"
			html <<  "<span class='captcha'> #{text_field_tag(:captcha,nil,:class => 'input', :id=>'captcha') } </span>"
			html <<  "<h2 class='numero'><span>#{session[:enquete]}</span> </h2>"
			html <<  "</div>"
			html <<  "<label class='inputs'>"
			html <<  "<input type='submit' class='votar' name='vote' value='Votar' />"
			html <<  "</label>" 
			html <<  "</form>"
		html <<  "<label class='inputs'>"
		unless pergunta.nil?
			html <<  button_to_function('Resultados', :class=>'resultado', :onclick=>"window.open('questions/#{pergunta.id}', 'pagina', 'status=no, toolbar=no, location=no, directories=no, resisable=no, scrollbars=yes, top=50%, left=50%, width=710, height=570');")
		end 
		html <<  "</label>"
		html <<  "<span class='clear'>&nbsp;</span>"
		html <<  "</div>"
 end
end
end
