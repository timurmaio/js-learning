
const electron = require('electron');

const ipc = electron.ipcRenderer;

const addVacancyButton = document.getElementById('addVacancyButton');

function getElem(id) {
  return document.getElementById(id);
}

function getVacancyFields() {
  return {
    name: getElem('name').value,
    sphere: getElem('sphere').value,
    experience: getElem('experience').value,
    city: getElem('city').value,
    age: getElem('age').value,
    salary: getElem('salary').value
  }
}

addVacancyButton.addEventListener('click', function(event) {
  ipc.send('saveVacancyToDb', getVacancyFields())
  window.location = 'vacancies.html';
});
