const electron = require('electron');

const textract = require('textract');

const Sequelize = require('sequelize');

const app = electron.app;

const BrowserWindow = electron.BrowserWindow;

const dialog = electron.dialog;

const ipc = electron.ipcMain;

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let mainWindow;

const sequelize = new Sequelize('postgres://dev:dev@localhost:5432/resume');

function createWindow() {

    mainWindow = new BrowserWindow({
        width: 800,
        height: 600
    });

    mainWindow.loadURL(`file://${__dirname}/index.html`);

    mainWindow.on('closed', function() {
        mainWindow = null;
    });
}

// parseHandler

function extractField(beginIndex, endIndex, inputString) {
    return inputString.slice(inputString.indexOf(beginIndex) + beginIndex.length + 2, inputString.indexOf(endIndex) - 1);
}

app.on('ready', createWindow);

app.on('window-all-closed', function() {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

app.on('activate', function() {
    if (mainWindow === null) {
        createWindow();
    }
});

var User = sequelize.define('users', {
    name: {
        type: Sequelize.STRING(100)
    },
    surname: {
        type: Sequelize.STRING(100)
    },
    patronymic: {
        type: Sequelize.STRING(100)
    },
    birthday: {
        type: Sequelize.STRING(100)
    },
    address: {
        type: Sequelize.STRING(100)
    },
    phone: {
        type: Sequelize.STRING(100)
    },
    mail: {
        type: Sequelize.STRING(100)
    },
    target: {
        type: Sequelize.STRING(1000)
    },
    experience: {
        type: Sequelize.STRING(10000)
    },
    education: {
        type: Sequelize.STRING(10000)
    },
    additionalEducation: {
        type: Sequelize.STRING(10000)
    },
    skills: {
        type: Sequelize.STRING(1000)
    },
    personalQualities: {
        type: Sequelize.STRING(1000)
    }
});

var Vacancy = sequelize.define('vacancies', {
    name: {
        type: Sequelize.STRING(100)
    },
    sphere: {
        type: Sequelize.STRING(100)
    },
    experience: {
        type: Sequelize.STRING(100)
    },
    city: {
        type: Sequelize.STRING(100)
    },
    age: {
        type: Sequelize.STRING(100)
    },
    salary: {
        type: Sequelize.STRING(100)
    }
});

var Acceptance = sequelize.define('acceptance', {
    salary: {
        type: Sequelize.STRING(100)
    }
});

Acceptance.belongsTo(Vacancy);
Acceptance.belongsTo(User);

ipc.on('saveVacancyToDb', function(event, arg) {
    Vacancy.sync().then(function() {
        return Vacancy.create({
            name: arg.name,
            sphere: arg.sphere,
            experience: arg.experience,
            city: arg.city,
            age: arg.age,
            salary: arg.salary
        })
    });
});

ipc.on('addAcceptToDb', function(event, arg) {
    Acceptance.sync().then(function() {
        console.log(arg);
        return Acceptance.create({
            userId: arg.userId,
            vacancyId: arg.vacancyId,
            salary: arg.salary
        })
    });
})

ipc.on('refreshAccept', function(event, arg) {
    sequelize.query('SELECT "acceptance"."salary",  "user"."name" AS "user.name", "user"."surname" AS "user.surname", "user"."patronymic" AS "user.patronymic", "vacancy"."name" AS "vacancy.name", "vacancy"."sphere" AS "vacancy.sphere" FROM "acceptances" AS "acceptance" LEFT OUTER JOIN "users" AS "user" ON "acceptance"."userId" = "user"."id" LEFT OUTER JOIN "vacancies" AS "vacancy" ON "acceptance"."vacancyId" = "vacancy"."id";').then(function(acceptance) {
        event.sender.send('refreshAcceptClient', acceptance);
    });
});

ipc.on('renderData', function(event, arg) {

    Vacancy.findAll().then(function(vacancies) {
        event.sender.send('renderDataVacancy', vacancies);
    });

    User.findAll().then(function(users) {
        event.sender.send('renderDataUser', users);
    });

});


function sendToDb(data, event) {
    let name = extractField('Имя', 'Фамилия', data);
    let surname = extractField('Фамилия', 'Отчество', data);
    let patronymic = extractField('Отчество', 'Дата рождения', data);
    let birthday = extractField('Дата рождения', 'Адрес', data);
    let address = extractField('Адрес проживания', 'Телефон', data);
    let phone = extractField('Телефон', 'e-mail', data);
    let mail = extractField('e-mail', 'Цель', data);
    let target = extractField('Цель', 'Опыт работы', data);
    let experience = extractField('Опыт работы', 'Образование', data);
    let education = extractField('Образование', 'Дополнительное образование', data);
    let additionalEducation = extractField('Дополнительное образование', 'Профессиональные навыки', data);
    let skills = extractField('Профессиональные навыки', 'Личные качества', data);
    let personalQualities = extractField('Личные качества', '', data);

    User.sync().then(function() {
        return User.create({
            name: name,
            surname: surname,
            patronymic: patronymic,
            birthday: birthday,
            address: address,
            phone: phone,
            mail: mail,
            target: target,
            experience: experience,
            education: education,
            additionalEducation: additionalEducation,
            skills: skills,
            personalQualities: personalQualities
        });
    }).then(function() {
        User.findAll().then(function(users) {
            // sequelize.query('SELECT * FROM users', { model: User }).then(function(userString){
            event.sender.send('getDataClient', users);
            console.log('users');
        });
    });
}

ipc.on('fileDialog', function(event, arg) {
    dialog.showOpenDialog({
        properties: ['openFile']
    }, function(files) {
        if (files) {
            textract.fromFileWithPath(files[0], function(error, text) {
                sendToDb(text, event);
            });
        }
    });
});

ipc.on('sendToDb', function(event, arg) {
    sequelize.query('SELECT * FROM users', {
        model: User
    }).then(function(userString) {
        event.sender.send('getDataClient', userString);
    });
});

ipc.on('refreshVacancies', function(event, arg) {
    Vacancy.findAll().then(function(vacancies) {
        event.sender.send('refreshedVacancies', vacancies);
    });
});
