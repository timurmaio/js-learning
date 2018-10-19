 var xml2js = require('xml2js');
 var parser = new xml2js.Parser();
 var striptags = require('striptags');
 var httpRequestService = require('./http-request.service');
  export default function () {
     return httpRequestService.get('http://40.85.141.154:8083/public/rss?news_count=10').then(function (response) {

      return new Promise((resolve, reject) => {
        parser.parseString(response, function (err, data) {
          resolve(data);
        })
      }).then(function(data) {
        const url = 'http://40.85.141.154:8083/rich/auth';

        return data.rss.channel[0].item.map((item, index) => {
          const newsUrl = url + item.link[0].substring(item.link[0].lastIndexOf('/'), item.link[0].length);

          return `${index + 1}) [${item.title[0]}](${newsUrl})`
        });
      });
    });
  }