var xml2js = require('xml2js');
var parser = new xml2js.Parser();
var httpRequestService = require('./http-request.service');
var isBuffer = require('is-buffer');

function getRecognizeApiToken() {
    var data = "grant_type=" + encodeURIComponent("client_credentials") + "&client_id=" + encodeURIComponent("4ea8dc5179ca4a8bbe96e7d065507a08") + "&client_secret=" + encodeURIComponent("81313e0b29e743f4b5a67d3b3b19de5a") + "&scope=" + encodeURIComponent("https://speech.platform.bing.com");
    return httpRequestService.post('https://oxford-speech.cloudapp.net/token/issueToken', data, {
        'Content-Type': 'application/x-www-form-urlencoded'
    }).then(function(response) {
        return JSON.parse(response);
    }).then(function(result) {
        return result.access_token;
    }).catch(error => {
        throw error
    });
}
// Получить можно:
// POST https://oxford-speech.cloudapp.net/token/issueToken
// HEADERS:
// Content-Type:application/x-www-form-urlencoded
// BODY:
// grant_type:client_credentials
// client_id:4ea8dc5179ca4a8bbe96e7d065507a08
// client_secret:81313e0b29e743f4b5a67d3b3b19de5a
// scope:https://speech.platform.bing.com
// }

function audioToText(audio, locale) {
	// return getRecognizeApiToken().then(function(token) {
	console.log(locale);
	if(locale === 'en') {
		return getRecognizeApiToken().then(function(token) {

			var appGuid = '64e4bea2-7c95-47bd-8399-b52d3b443428';
			var deviceGuid = '4ac572fe-b9a7-4efc-9c9b-c6b988707289';
			var guid = 'e294dcca-c623-4642-a2d8-22d5162068d6';

			var url = 'https://speech.platform.bing.com/recognize?version=3.0&appID=' + appGuid + '&format=json&locale=en-US&requestid=' + guid + '&device.os=Android&scenarios=websearch&instanceid=' + deviceGuid;
			var headers = {
				'Content-Type': 'audio/wav; samplerate=16000',
				'Authorization': 'Bearer ' + token
			};

			return httpRequestService.post(url, audio, headers)
		}).then(function (response) {
			return JSON.parse(response).header.name;
		});

	} else {
		var url = 'https://asr.yandex.net/asr_xml?uuid=7f5627227d2111e6ae2256b6b6499611&key=10651522-54ac-4f4a-9641-1605d1e8d81d&topic=queries&lang=ru-RU';

		var headers = {
			'Content-Type': 'audio/x-wav' //,
			// 'Transfer-Encoding': 'chunked'
			// 'Authorization': 'Bearer ' + token
		};

		return httpRequestService.post(url, audio, headers)
			.then(function (response) {
				return new Promise((resolve, reject) => {
					parser.parseString(response, function (err, data) {
						resolve(data.recognitionResults.variant[0]._);
					})
				})
				// return JSON.parse(response).header.name;
			});
	}


	// 

	// POST url
	// HEADERS:
	// Host:speech.platform.bing.com
	// Content-Type:audio/wav; samplerate=16000
	// Authorization:Bearer ${jwt_token}
	// BODY: audio file

	// jwt_token - это токен, который истекает через каждые 5 минут
}
export {
    audioToText,
    getRecognizeApiToken
};