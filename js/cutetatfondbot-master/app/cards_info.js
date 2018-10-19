function showCards(chatId, bot) {
    var httpRequestService = require('./http-request.service');
    var headers = {
        'Authorization': 'Basic cmV0YWlsOnJldGFpbA=='
    }

    httpRequestService.get('http://40.85.141.154:8083/rest/personal/card?sync_cards=true', headers).then(function(response) {
        return JSON.parse(response);
    }).then(function(result) {
        // console.log(result);
        var cards = result.card;
        var s = "Ваши карты:\n ";
        console.log(result.card);

        cards.forEach((item, i, arr) => {
            s += item.info.bold() + ", остаток: " + item.balance + " " + item.currency + ".\n ";
        })

        // console.log(s);
        bot.sendMessage(chatId, s, {parse_mode: 'HTML'});
    }).catch(error => {
        throw error
    });
};
export {
    showCards
};
