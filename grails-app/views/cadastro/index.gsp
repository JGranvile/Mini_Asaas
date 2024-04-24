<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="">
    <title>Formulário de Cadastro</title>
    <style>
        /* Estilos para a caixa colorida */
        .background-box {
            background-color: #0030b9; /* Cor de fundo da caixa */
            padding: 30px; /* Espaçamento interno da caixa */
            border-radius: 10px; /* Borda arredondada */
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); /* Sombra suave */
            width: 475px; /* Largura da caixa */
            height: auto; /* Altura automática para ajustar ao conteúdo */
            display: flex;
            justify-content: center;
            align-items: center; /* Centraliza verticalmente */
            margin: 0 auto; /* Centraliza horizontalmente */
        }
        body{
            color: #f1f5fb;
        }
        /* Estilos para os campos do formulário */
        .form-field {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        /* Estilos para os rótulos do formulário */
        label {
            font-weight: bold;
            color: #f1f5fb;
        }

        /* Estilos para o botão de enviar */
        input[type="submit"] {
            width: 100%;
            background-color: #0198ff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }
        
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="background-box"> 
        <g:form name="Cadastro" controller="cadastro" action="save" >
            <img src="${resource(dir: 'images', file: 'logo.png')}" alt="Logo" style="width: 50%; height: auto;">
            <h1 style= "color: #f1f5fb"> Formulário de Cadastro </h1>
            <label for="nome">Nome:</label><br>
            <g:textField name="nome" class="form-field"/><br>
            
            <label for="cpf">CPF:</label><br>
            <g:textField name="cpf" class="form-field"/><br>
            
            <label for="telefone">Telefone:</label><br>
            <g:textField name="telefone" class="form-field"/><br>
            
            <label for="cep">CEP:</label><br>
            <g:textField name="cep" class="form-field" onchange="fillAddress();"/><br>
            
            <label for="estado">Estado:</label><br>
            <g:textField name="estado" class="form-field"/><br>

            <label for="cidade">Cidade:</label><br>
            <g:textField name="cidade" class="form-field"/><br>

            <label for="bairro">Bairro:</label><br>
            <g:textField name="bairro" class="form-field"/><br>

            <label for="rua">Rua:</label><br>
            <g:textField name="rua" class="form-field"/><br>

            <label for="numero">Número:</label><br>
            <g:textField name="numero" class="form-field"/><br>

            <label for="complemento">Complemento:</label><br>
            <g:textField name="complemento" class="form-field"/><br>
            
            <input type="submit" value="Enviar">
        </g:form>
    </div>

    <script>
    function fillAddress() {
        var cep = document.getElementsByName('cep')[0].value;
        if (cep.length == 8) {
            fetchAddress(cep);
        }
    }

    function fetchAddress(cep) {
        var headers = new Headers();
            headers.append("X-Requested-With", "XMLHttpRequest");
            // headers.append("content-type", "application/json");

        var formData = new FormData();
            formData.append("cep", cep);

        var obj= {
            method: "POST",
            headers,
            body: formData
        } 
        new FormData()
        fetch('/cadastro/fillAddress', obj)
            .then(response => response.json())
            .then(response => {
                if(!response.success) return
                var data = JSON.parse(response.response)

                document.getElementsByName('estado')[0].value = data.uf;
                document.getElementsByName('cidade')[0].value = data.localidade;
                document.getElementsByName('bairro')[0].value = data.bairro;
                document.getElementsByName('rua')[0].value = data.logradouro;

                document.getElementsByName('numero')[0].value = '';
                document.getElementsByName('complemento')[0].value = '';
            })
            .catch(error => console.error('Erro ao obter o endereço:', error));
    }
    </script>

</body>
</html>
