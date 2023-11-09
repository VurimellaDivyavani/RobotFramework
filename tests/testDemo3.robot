*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Library    Collections
Library    String
Test Setup      open the browser with the Mortgage payment url
Test Teardown   Close Browser
Resource        resource.robot

*** Variables ***
${Error_Message_Login}      xpath://*[@id="login-form"]/div[1]


*** Test Cases ***
Validate Child window Functionality
	Select the link of Child window
	Verify the user is Switched to Child window
	Grab the Email id in the Child window
	Switch to Parent window and enter the Email


*** Keywords ***
Select the link of Child window
    Click Element    css:.blinkingText
    Sleep            5

Verify the user is Switched to Child window
    Switch Window    NEW
    Element Text Should Be      css:h2      DOCUMENTS REQUEST

Grab the Email id in the Child window
	${text}=    Get Text        css:.red
	@{words}=   Split String    ${text}     at

	# at 0 index -> Please email us -- will be stored
	# at 1 index -> mentor@rahulshettyacademy.com with below template to receive response -- will be stored
	${text_split}=      Get From List       ${words}    1
	Log     ${text_split}
	@{words_2}=   Split String    ${text_split}

	# at 0 index -> mentor@rahulshettyacademy.com
	 ${email}=      Get From List      ${words_2}   0
	 Set Global Variable        ${email}

Switch to Parent window and enter the Email
	Switch Window   MAIN
	Title Should Be     LoginPage Practise | Rahul Shetty Academy
	Input Text      id:username     ${email}
	Sleep   2 minutes
