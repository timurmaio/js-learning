function showDeposits(chatId, bot) {
    var httpRequestService = require('./http-request.service');
    var headers = {
        'Authorization': 'Basic cmV0YWlsOnJldGFpbA=='
    }

    httpRequestService.get('http://40.85.141.154:8083/rest/personal/deposit?sync_deposits=true', headers).then(function(response) {
        return JSON.parse(response);
    }).then(function(result) {
        var deposits = result.deposit;
        var s = "Ваши вклады:\n ";

        deposits.forEach((item, i, arr) => {
            s += item.info + ", остаток: " + item.balance + " " + item.currency + ".\n ";
        })

        bot.sendMessage(chatId, s);
    }).catch(error => {
        throw error
    });
}
export {
    showDeposits
};
