function showCredits(chatId, bot) {
    var httpRequestService = require('./http-request.service');
    var headers = {
        'Authorization': 'Basic cmV0YWlsOnJldGFpbA=='
    }

    httpRequestService.get('http://40.85.141.154:8083/rest/personal/credit?sync_credits=true', headers).then(function (response) {
        return JSON.parse(response);
    }).then(function (result) {
        var cards = result.credit;
        var s = "Ваши кредиты:\n ";

        cards.forEach((item, i, arr) => {
            s += item.number + " ( " + item.info + " ) " + ", сумма кредита: " + item.creditInformation.amount + " " + item.currency + ".\n ";
        })

        bot.sendMessage(chatId, s);
    }).catch(error => {
        throw error
    });
};

function showMoreCredits(chatId, bot) {
    var httpRequestService = require('./http-request.service');
    var headers = {
        'Authorization': 'Basic cmV0YWlsOnJldGFpbA=='
    }

    httpRequestService.get('http://40.85.141.154:8083/rest/personal/credit?sync_credits=true', headers).then(function (response) {
        return JSON.parse(response);
    }).then(function (result) {
        // console.log(result);
        var cards = result.credit;
        var s = "Ваши кредиты:\n ";

        cards.forEach((item, i, arr) => {
            s += item.number + " ( " + item.info + " ) " +
                ". \n Осталось внести для оплаты платежа: " + item.creditTotalAmountDebtPay + " " + item.currency +
                ". \n Дата очередного платежа: " + item.nextPayDate + " " + item.currency + ".\n ";
        })

        // console.log(s);
        bot.sendMessage(chatId, s);
    }).catch(error => {
        throw error
    });
};
export {
showCredits, showMoreCredits
};
