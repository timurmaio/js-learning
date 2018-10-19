const electron = require('electron');

const ipc = electron.ipcRenderer;

const addVacancyButton = document.getElementById('addVacancyButton');

function getElem(id) {
    return document.getElementById(id);
}

ipc.send('refreshVacancies');

ipc.on('refreshedVacancies', function(event, arg) {
    var table = document.getElementById("tableField").getElementsByTagName('tbody')[0];
    var newTable = document.createElement('tbody');
    table.parentNode.replaceChild(newTable, table);

    Object.keys(arg).map(function(index) {

        var vacancyData = arg[index].dataValues;

        var row = newTable.insertRow(0);

        var name = row.insertCell(0);
        var sphere = row.insertCell(1);
        var experience = row.insertCell(2);
        var city = row.insertCell(3);
        var age = row.insertCell(4);
        var salary = row.insertCell(5);

        name.innerHTML = '<div>' + vacancyData.name + '</div>';
        sphere.innerHTML = '<div>' + vacancyData.sphere + '</div>';
        experience.innerHTML = '<div>' + vacancyData.experience + '</div>';
        city.innerHTML = '<div>' + vacancyData.city + '</div>';
        age.innerHTML = '<div style="width: 200px;">' + vacancyData.age + '</div>';
        salary.innerHTML = '<div style="width: 100px;">' + vacancyData.salary + '</div>';
    });
});
