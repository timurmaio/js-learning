const electron = require('electron');

const ipc = electron.ipcRenderer;

var addAcceptButton = document.getElementById("addAcceptButton");

var vacancy = document.getElementById("vacancy");

var employee = document.getElementById("employee");

var salary = getElem('salary');

function getElem(id) {
  return document.getElementById(id);
}

function getAcceptFields() {
  return {
    userId: employee.value,
    vacancyId: vacancy.value,
    salary: salary.value
  }
}

addAcceptButton.addEventListener('click', function (event) {
  ipc.send('addAcceptToDb', getAcceptFields());
  window.location = 'accept.html';
})

ipc.send('renderData');

ipc.on('renderDataVacancy', function (event, arg) {

  Object.keys(arg).map(function(index) {
      var option = document.createElement('option');
      var vacancyData = arg[index].dataValues;
      option.value = vacancyData.id;
      option.innerHTML = vacancyData.name;
      vacancy.appendChild(option);
  });
});

ipc.on('renderDataUser', function (event, arg) {

  Object.keys(arg).map(function(index) {
      var option = document.createElement('option');
      var vacancyData = arg[index].dataValues;
      option.value = vacancyData.id;
      option.innerHTML = vacancyData.name + " " + vacancyData.surname + " " + vacancyData.patronymic;
      employee.appendChild(option);
  });
})
