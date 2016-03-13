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

function addRecipientField() {

  //create Date object
  var date = new Date();

  //get number of milliseconds since midnight Jan 1, 1970 
  //and use it for recipient key
  var mSec = date.getTime(); 

  //Replace 0 with milliseconds
  idAttributName =  "program_recipients_attributes_0_name".replace("0", mSec);
  nameAttributName =  "program[recipients_attributes][0][name]".replace("0", mSec);

  idAttributNumber =  "program_recipients_attributes_0_number".replace("0", mSec);
  nameAttributNumber =  "program[recipients_attributes][0][number]".replace("0", mSec);

  //create <div> tag
  var recipient = document.createElement("div");
  recipient.setAttribute("class", "form-group");

  //create label for Name, set it's for attribute, 
  //and append it to <div> element
  var labelName = document.createElement("label");
  labelName.setAttribute("for", idAttributName);
  labelName.setAttribute("class", idAttributName);
  labelName.setAttribute("class", "col-sm-2 control-label");
  var nameLabelText = document.createTextNode("Recipient");
  labelName.appendChild(nameLabelText);
  recipient.appendChild(labelName);

  //create input for Name, set it's type, id and name attribute, 
  //and append it to <div> element
  var recipientDiv = document.createElement("div");
  recipientDiv.setAttribute("class", "col-sm-4");
  var inputName = document.createElement("INPUT");
  inputName.setAttribute("type", "text");
  inputName.setAttribute("id", idAttributName);
  inputName.setAttribute("name", nameAttributName);
  inputName.setAttribute("class", "form-control");
  recipientDiv.appendChild(inputName);
  recipient.appendChild(recipientDiv);

  //create label for Number, set it's for attribute, 
  //and append it to <div> element
  var labelNumber = document.createElement("label");
  labelNumber.setAttribute("for", idAttributNumber);
  labelNumber.setAttribute("class", idAttributNumber);
  labelNumber.setAttribute("class", "col-sm-2 control-label");
  var nameLabelText = document.createTextNode("Recipient");
  labelNumber.appendChild(nameLabelText);
  recipient.appendChild(labelNumber);

  //create input for Number, set it's type, id and name attribute, 
  //and append it to <div> element
  var recipientDiv = document.createElement("div");
  recipientDiv.setAttribute("class", "col-sm-4");
  var inputNumber = document.createElement("INPUT");
  inputNumber.setAttribute("type", "text");
  inputNumber.setAttribute("id", idAttributNumber);
  inputNumber.setAttribute("name", nameAttributNumber);
  inputNumber.setAttribute("class", "form-control");
  recipientDiv.appendChild(inputNumber);
  recipient.appendChild(recipientDiv);

  //add created <div> element with its child elements 
  //(label and input) to myList (<ul>) element
  document.getElementById("recipients").appendChild(recipient);

  //show recipient header
  //$("#recipientHeader").show(); 
}
