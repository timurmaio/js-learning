// This file is required by the index.html file and will
// be executed in the renderer process for that window.
// All of the Node.js APIs are available in this process.

const electron = require('electron');

const ipc = electron.ipcRenderer;

// const remote = electron.remote;

// const mainProcess = remote.require('./main');

// const dialog = electron.dialog;

const selectDirBtn = document.getElementById('selectFile');

selectDirBtn.addEventListener('click', function (event) {
  ipc.send('fileDialog')
});

const sendToDb = document.getElementById('sendToDb');

ipc.send('sendToDb');

function extractField(start, end, string) {
  return string.slice(string.indexOf(start) + start.length + 2, string.indexOf(end) - 1);
}

ipc.on('selectedFile', function (event, arg) {
	var table = document.getElementById("tableField").getElementsByTagName('tbody')[0];

	var row = table.insertRow(0);

	var name = row.insertCell(0);
	var surname = row.insertCell(1);
	var patronymic = row.insertCell(2);
	var birthday = row.insertCell(3);
	var address = row.insertCell(4);
	var phone = row.insertCell(5);
	var mail = row.insertCell(6);
	var target = row.insertCell(7);
	var experience = row.insertCell(8);
	var education = row.insertCell(9);
	var additionalEducation = row.insertCell(10);
	var skills = row.insertCell(11);
	var personalQualities = row.insertCell(12);

	name.innerHTML = '<div>' + extractField('Имя', 'Фамилия', arg) + '</div>';
	surname.innerHTML = '<div>' + extractField('Фамилия', 'Отчество', arg) + '</div>';
	patronymic.innerHTML = '<div>' + extractField('Отчество', 'Дата рождения', arg) + '</div>';
	birthday.innerHTML = '<div>' + extractField('Дата рождения', 'Адрес', arg) + '</div>';
	address.innerHTML = '<div style="width: 200px;">' + extractField('Адрес проживания', 'Телефон', arg) + '</div>';
	phone.innerHTML = '<div style="width: 100px;">' + extractField('Телефон', 'e-mail', arg) + '</div>';
	mail.innerHTML = '<div>' + extractField('e-mail', 'Цель', arg) + '</div>';
	target.innerHTML = '<div style="width: 200px;">' + extractField('Цель', 'Опыт работы', arg) + '</div>';
	experience.innerHTML = '<div style="width: 300px;">' + extractField('Опыт работы', 'Образование', arg) + '</div>';
	education.innerHTML = '<div style="width: 200px;">' + extractField('Образование', 'Дополнительное образование', arg) + '</div>';
	additionalEducation.innerHTML = '<div style="width: 200px;">' + extractField('Дополнительное образование', 'Профессиональные навыки', arg) + '</div>';
	skills.innerHTML = '<div >' + extractField('Профессиональные навыки', 'Личные качества', arg) + '</div>';
	personalQualities.innerHTML = '<div style="width: 200px;">' + extractField('Личные качества', '', arg) + '</div>';
});

ipc.on('getDataClient', function (event, arg) {

	var table = document.getElementById("tableField").getElementsByTagName('tbody')[0];
	var newTable = document.createElement('tbody');
	table.parentNode.replaceChild(newTable, table);

	Object.keys(arg).map(function(index){

		var userData = arg[index].dataValues;

		var row = newTable.insertRow(0);

		var name = row.insertCell(0);
		var surname = row.insertCell(1);
		var patronymic = row.insertCell(2);
		var birthday = row.insertCell(3);
		var address = row.insertCell(4);
		var phone = row.insertCell(5);
		var mail = row.insertCell(6);
		var target = row.insertCell(7);
		var experience = row.insertCell(8);
		var education = row.insertCell(9);
		var additionalEducation = row.insertCell(10);
		var skills = row.insertCell(11);
		var personalQualities = row.insertCell(12);

		name.innerHTML = '<div>' + userData.name + '</div>';
		surname.innerHTML = '<div>' + userData.surname + '</div>';
		patronymic.innerHTML = '<div>' + userData.patronymic + '</div>';
		birthday.innerHTML = '<div>' + userData.birthday + '</div>';
		address.innerHTML = '<div style="width: 200px;">' + userData.address + '</div>';
		phone.innerHTML = '<div style="width: 100px;">' + userData.phone + '</div>';
		mail.innerHTML = '<div>' + userData.mail + '</div>';
		target.innerHTML = '<div style="width: 200px;">' + userData.target + '</div>';
		experience.innerHTML = '<div style="width: 300px;">' + userData.experience + '</div>';
		education.innerHTML = '<div style="width: 200px;">' + userData.education + '</div>';
		additionalEducation.innerHTML = '<div style="width: 200px;">' + userData.additionalEducation + '</div>';
		skills.innerHTML = '<div >' + userData.skills + '</div>';
		personalQualities.innerHTML = '<div style="width: 200px;">' + userData.personalQualities + '</div>';

	});
});
