function payDoc(chatId, bot, phone_to, amount) {
    var httpRequestService = require('./http-request.service');
    var headers = {
        'Authorization': 'Basic cmV0YWlsOnJldGFpbA==',
        'Content-Type': 'application/json'
    }

    var data = {
        "docDate":"2016-09-18T09:25:43.511Z",
        "corrDirection":4,
        "amount":amount,
        "description":"НДС в 12",
        "corrType":"FL",
        "corrPhone":phone_to,
        "accId":7403,
        "corrFirstname":"T",
        "corrSecondname":"P",
        "agreeRules":true,
        "corrCardNumber":"4276060012218775",
        "corrBankBik":"044525562",
        "corrAccNumber":"40702810300001002464"
    }

    var id;

    httpRequestService.post('http://40.85.141.154:8083/rest/personal/document/create/pay_transfer_rur', data, headers).then(function(response) {
        return JSON.parse(response);
    }).then(function(result) {
        // 193998
        id = result.id;
        return result.id;
    }).then(function(id) {
        var headers = {
            'Authorization': 'Basic cmV0YWlsOnJldGFpbA=='
        }
        return httpRequestService.get('http://40.85.141.154:8083/rest/personal/document/confirmation/request?doc_id=' + id, headers)
    }).then(function(response) {
            bot.sendMessage(chatId, 'Оплата успешно завершена! Номер платежного документа: ' + id);
            return JSON.parse(response);
        }).catch(error => {
        throw error
    });
}

export {
    payDoc
};
