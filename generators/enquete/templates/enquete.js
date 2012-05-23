$(document).ready(function(){
 
    $('.questions p').click(function(){
        var r = $(this).find('input[type=radio]');
        if($(r).is(":checked")) {
            $(r).attr("checked", "");
        } else {
            $(r).attr("checked", "checked");
        }
    });
    
    $(".edit_question").click(function(){
        if ($("input[type=radio]").is(":checked")){
   
            return true;    
        }
        alert("Por favor, selecione uma das alternativas!");
        return false;
       
    });
    
    $(".edit_question").click(function(){
        var capctha = $(".numero span").text();
        var texto  = $(".captcha #captcha").val();
        var valor = $(".valor").text();
        if ($("input[type=radio]").is(":checked")){
            if (capctha == texto && valor == 1) {
                window.open('customer_enquetes/', 'pagina', 'status=no, toolbar=no, location=no, directories=no, resisable=no, scrollbars=no, top=50%, left=50%, width=630, height=400');
             
                return true;    
            }
        }    
     
    });

 
    $('#enquete').hide();
    $('.sessao').hide();
    
    $(".edit_question p").click(function(){
        $('#enquete').fadeIn(500);
    });
	
	$("#enviar").click(function(){
		var nome = $("#nome").val();
		var telefone = $("#phone").val();
		var email = $("#email").val();
		if ((nome == '') || (telefone == '') || (email == '' )){
			alert("Por favor, informe os campos em vermelhos");
			return false;
		}
                return true;
		
	});
	
    
});