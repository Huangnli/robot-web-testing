*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                          chrome
${URL}                              https://www.amazon.com.br
${URL_ELETRONICOS}                  https://www.amazon.com.br/gp/browse.html?node=16209062011&ref_=nav_em__electronics_all__0_2_18_2
${MENU_TODOS}                       //i[contains(@class,'hm-icon nav-sprite')]
${HEADER_ELETRONICOS_TECNOLOGIA}    //h1[contains(.,'Eletrônicos e Tecnologia')]

*** Keywords *** 
Abrir o navegador
    ${MyDesiredCapabilities}   Create Dictionary   firefox_binary=C:\XXXXX\Firefox.exe
    #Para navegador permaneça aberto utilize options=add_experimental_option("detach", True)
    Open Browser    browser=${BROWSER}    options=add_experimental_option("detach", True)
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    #Versões mais recentes do chromedriver fecha sozinho o browser após a execução.
    Close Browser 

Acessar a home page do site Amazon.com.br
    Go To                                  url=${URL}
    Wait Until Element Is Visible          ${MENU_TODOS}

Entrar no menu "Eletrônicos"
    Go To                                url=${URL_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains             ${FRASE}
    Wait Until Element Is Visible        ${HEADER_ELETRONICOS_TECNOLOGIA}

Verificar se o título da página fica "${TITULO}"
    Title Should Be         ${TITULO}

Verificar se aparece a categoria "${CATEGORIA}"
    Element Should Be Visible    //a[contains(@aria-label,'${CATEGORIA}')]

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    twotabsearchtextbox    ${PRODUTO}

Clicar no botão de pesquisa
    Click Element    nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    (//span[contains(.,'${PRODUTO}')])[2]

#Gherkin Steps
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Wait Until Element Is Visible        //span[@class='a-color-state a-text-bold'][contains(.,'"Xbox Series S"')]
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"