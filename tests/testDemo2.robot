*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Library    Collections
Test Setup      open the browser with the Mortgage payment url
#Test Teardown   Close Browser Session
Resource        resource.robot

*** Variables ***
${Error_Message_Login}      xpath://*[@id="login-form"]/div[1]
${Shop_page_load}           xpath://*[@id="navbarResponsive"]/ul/li/a
${radio_button_user}        css:input[value='user']

*** Test Cases ***
Validate UnSuccessful Login
	Fill the login form     ${user_name}    ${invalid_password}
	wait until Element is located in the page   ${Error_Message_Login}
	verify error message is correct

Validate Successful Login
	Fill The Login Form     ${user_name}    ${valid_password}
    wait until Element is located in the page   ${Shop_page_load}

Validate Cards display in the Shopping Page
	Fill The Login Form     ${user_name}    ${valid_password}
    wait until Element is located in the page   ${Shop_page_load}
    Verify Card titles in the Shop page

Select the Card in the Shopping page
	Fill The Login Form     ${user_name}    ${valid_password}
    wait until Element is located in the page   ${Shop_page_load}
    Verify Card titles in the Shop page
    Select the Card     iphone X

Select the Form and navigate to Child window
	Fill the Login Details and Login Form   ${user_name}    ${valid_password}

*** Keywords ***
Fill the login form
	[arguments]    ${username}     ${password}
	Input Text      id:username     ${username}
	Input Password  id:password     ${password}
	Click Button    signInBtn

wait until Element is located in the page
	[arguments]    ${element}
	Wait Until Element Is Visible   ${element}

verify error message is correct
#	${result}=     Get Text        ${Error_Message_Login}
#	Log To Console  ${result}
#	Should Be Equal As Strings      ${result}   Incorrect username/password.
#   Above 1st and 3rd commented code can be replace with below line
   Element Text Should Be      ${Error_Message_Login}      Incorrect username/password.

Verify Card titles in the Shop page
    @{expectedList} =    Create List    iphone X     Samsung Note 8      Nokia Edge      Blackberry
    ${elements} =   Get WebElements     css:.card-title
    @{actualList} =    Create List
    FOR     ${element}  IN   @{elements}
         Log       ${element.text}
         Append To List     ${actualList}       ${element.text}
    END
    Lists Should Be Equal       ${expectedList}     ${actualList}

Select the Card
	[arguments]     ${cardName}
	${elements} =   Get Webelements     css:.card-title
	${index} =  Set Variable    1
	    FOR  ${element}  IN   @{elements}
		    Exit For Loop If    '${cardName}' == '${element.text}'
		    ${index} =  Evaluate    ${index} + 1
        END
	Click Button    xpath:(//*[@class='card-footer'])[${index}]/button

Fill the Login Details and Login Form
	[arguments]     ${username}    ${password}
	Input Text      id:username     ${username}
	Input Password  id:password     ${password}
	Click Element   ${radio_button_user}
	Wait Until Element Is Visible   css:.modal-body
	Click Button    id:okayBtn
	Click Button    id:okayBtn
	Wait Until Element Is Not Visible   css:.modal-body
	Select From List By Value       css:select.form-control     teach
	Select Checkbox     id:terms
	Checkbox Should Be Selected     id:terms
	Sleep   2 minutes 30 seconds
#	Unselect Checkbox   id:terms
#	Checkbox Should Not Be Selected     id:terms