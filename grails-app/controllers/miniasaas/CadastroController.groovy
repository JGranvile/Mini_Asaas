package miniasaas

import grails.converters.JSON

class CadastroController {

    def index() {
    }


    // Ação para lidar com a submissão do formulário
    def save() { 
        println(params)
        flash.message = "Cadastro realizado com Sucesso"
        redirect(action: "index")
    }

    def fillAddress(){
        try{
            // def cep = request.JSON.cep
            def cep = params.cep
            def url = "https://viacep.com.br/ws/${cep}/json/"
            
            // Faça a chamada para a API ViaCEP
            def response = new URL(url).getText()
            render([response:response, success: true] as JSON)

            
        } catch(Exception ex){
            render([success: false] as JSON)
        }
        
    }

}
    
