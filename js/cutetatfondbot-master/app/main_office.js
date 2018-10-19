// главный офис
var httpRequestService = require('./http-request.service');

function showMainOffice() {
    return httpRequestService.get('http://40.85.141.154:8083/public/json?service=banks_ru&id=1889').then(function(response) {
        return JSON.parse(response);
    }).then(function(result) {
    	var place = result[0].place;
    	var address = result[0].address;
    	var addr = "Адрес главного офиса Татфондбанк:\n " + place + ', ' + address;
    	return addr;
    })
}
export {
    showMainOffice
};
