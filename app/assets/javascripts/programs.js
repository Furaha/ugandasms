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

  //create label for Title, set it's for attribute, 
  //and append it to <div> element
  var labelTitle = document.createElement("label");
  labelTitle.setAttribute("for", idAttributTitle);
  var titleLabelText = document.createTextNode("Title");
  labelTitle.appendChild(titleLabelText);
  message.appendChild(labelTitle);

  //create input for Title, set it's type, id and name attribute, 
  //and append it to <div> element
  var inputTitle = document.createElement("INPUT");
  inputTitle.setAttribute("type", "text");
  inputTitle.setAttribute("id", idAttributTitle);
  inputTitle.setAttribute("name", nameAttributTitle);
  message.appendChild(inputTitle);

  //add created <div> element with its child elements 
  //(label and input) to myList (<ul>) element
  document.getElementById("messages").appendChild(message);

  //show message header
  //$("#messageHeader").show(); 
}
