function LockCard(chatId, bot, cardNum, description) {
    var httpRequestService = require('./http-request.service');
    var headers = {
        'Authorization': 'Basic cmV0YWlsOnJldGFpbA==',
        'Content-Type':'application/json'
    }

    var date = {"cardNum":cardNum,
"description": description,
"agreeRules":1};

    httpRequestService.post('http://40.85.141.154:8083/rest/personal/request/process/lock_card_request', date, headers).then(function(response) {
        return JSON.parse(response);
    }).then(function(result) {
        var id_document = result.id;

        var s = "Карта заблокирована. \n Идентификатор созданного заявления: " + id_document;
        bot.sendMessage(chatId, s);
    }).catch((error) => { 
         var k = "Карту не удалось заблокировать.";
         bot.sendMessage(chatId, k);
    }).catch(error => {
        throw error
    });
};

export {
    LockCard
};