const electron = require('electron');

const ipc = electron.ipcRenderer;

ipc.send('refreshAccept');

ipc.on('refreshAcceptClient', function (event, arg) {

  var data = arg[0];

  var table = document.getElementById("tableField").getElementsByTagName('tbody')[0];
  var newTable = document.createElement('tbody');
  table.parentNode.replaceChild(newTable, table);

  Object.keys(data).map(function(index) {

    var data2 = data[index];

      var row = newTable.insertRow(0);

      var vacancyName = row.insertCell(0);
      var sphere = row.insertCell(1);
      var salary = row.insertCell(2);
      var fio = row.insertCell(3);

      vacancyName.innerHTML = '<div>' + data2['vacancy.name'] + '</div>';
      sphere.innerHTML = '<div>' + data2['vacancy.sphere'] + '</div>';
      salary.innerHTML = '<div>' + data2.salary + '</div>';
      fio.innerHTML = '<div>' + data2['user.name'] + " " + data2['user.surname'] + " " + data2['user.patronymic'] + '</div>';
  });
})
