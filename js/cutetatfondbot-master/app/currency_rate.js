// курсы валют
function showCurrencyRate(msg, bot) {
    var httpRequestService = require('./http-request.service');
    httpRequestService.get('http://40.85.141.154:8083/rest/public/currency_rate').then(function(response) {
        return JSON.parse(response);
    }).then(function(result) {
        var chatId = msg.chat.id;
        var usd_rub = (+(result.currencyRates[0].currRate)).toFixed(2);
        var eur_rub = (+result.currencyRates[1].currRate).toFixed(2);
        var rub_usd = (+result.currencyRates[3].currRate).toFixed(2);
        var rub_eur = (+result.currencyRates[4].currRate).toFixed(2);
        var message = '<strong>Курс валют.</strong>\nПокупка: USD: ' + usd_rub + ', EUR: ' + eur_rub + '.\nПродажа: USD: ' + rub_usd + ', EUR: ' + rub_eur + '.';
        bot.sendMessage(chatId, message, {parse_mode: 'HTML'});
    }).catch(error => {
        throw error
    });
}
export {
    showCurrencyRate
};