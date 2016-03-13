function addMessageField() {

  //create Date object
  var date = new Date();

  //get number of milliseconds since midnight Jan 1, 1970 
  //and use it for message key
  var mSec = date.getTime(); 

  //Replace 0 with milliseconds
  idAttributTitle =  "program_messages_attributes_0_title".replace("0", mSec);
  nameAttributTitle =  "program[messages_attributes][0][title]".replace("0", mSec);

  idAttributStreet =  "program_messages_attributes_0_street".replace("0", mSec);
  nameAttributStreet =  "program[messages_attributes][0][street]".replace("0", mSec);

  //create <div> tag
  var message = document.createElement("div");
  message.setAttribute("class", "form-group");

  //create label for Title, set it's for attribute, 
  //and append it to <div> element
  var labelTitle = document.createElement("label");
  labelTitle.setAttribute("for", idAttributTitle);
  labelTitle.setAttribute("class", idAttributTitle);
  labelTitle.setAttribute("class", "col-sm-2 control-label");
  var titleLabelText = document.createTextNode("Message");
  labelTitle.appendChild(titleLabelText);
  message.appendChild(labelTitle);

  //create input for Title, set it's type, id and name attribute, 
  //and append it to <div> element
  var messageDiv = document.createElement("div");
  messageDiv.setAttribute("class", "col-sm-10");
  var inputTitle = document.createElement("INPUT");
  inputTitle.setAttribute("type", "text");
  inputTitle.setAttribute("id", idAttributTitle);
  inputTitle.setAttribute("name", nameAttributTitle);
  inputTitle.setAttribute("class", "form-control");
  messageDiv.appendChild(inputTitle);
  message.appendChild(messageDiv);

  //add created <div> element with its child elements 
  //(label and input) to myList (<ul>) element
  document.getElementById("messages").appendChild(message);

  //show message header
  //$("#messageHeader").show(); 
}
