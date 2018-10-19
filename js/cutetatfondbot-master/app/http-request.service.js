var  XMLHttpRequest = require('xhr2/lib/xhr2.js');

XMLHttpRequest.prototype.sendAsBinary = function (sData) {
  var nBytes = sData.length, ui8Data = new Uint8Array(nBytes);
  for (var nIdx = 0; nIdx < nBytes; nIdx++) {
    console.log(nIdx);
    ui8Data[nIdx] = sData.charCodeAt(nIdx) & 0xff;
  }
  /* send as ArrayBufferView...: */
  this.send(ui8Data);
  /* ...or as ArrayBuffer (legacy)...: this.send(ui8Data.buffer); */
};

var isBuffer = require('is-buffer');

module.exports = (function () {
  var get, del, makeRequest , post, update, xhr;
  
  xhr = new XMLHttpRequest();
  
  makeRequest = function (options) {
    
    return new Promise(function (resolve, reject) {
      var data;
      xhr.open(options.method, options.url, true);
      
      if(options.method === 'POST' || options.method === 'PUT' || options.method === 'GET') {
        setHeaders(options.headers);

        if (!(options.method === 'GET')) {
         if(!isBuffer(options.data)) {
            data = JSON.stringify(options.data);
          } else {
            data = options.data
          }
        }
      }

      xhr.onload = function () {
        if (this.status === 201 || this.status === 200 || this.status === 'success') {
          resolve(this.response);
        } else {
          var error = new Error(this.statusText);
          error.code = this.status;
          
          reject(error);
        }
      };

      xhr.onerror = function () {
        reject(new Error("Network error"))
      };

      data === undefined ? xhr.send() : xhr.send(data)
    })
  };
  
  
  get = function (url, headers = {}) {

    return makeRequest({
      url: url,
      method: 'GET',
      headers: headers
    })
  };

  post = function (url, data, headers) {

    return makeRequest({
      url: url,
      method: 'POST',
      data: data,
      headers: headers
    })
  };

  del = function (url) {
    
    return makeRequest({
      url: url,
      method: 'DELETE'
    })
  };

  update = function (url, data, headers) {
    
    return makeRequest({
      url: url,
      method: 'PUT',
      data: data,
      headers: headers
    })
  };

  function setHeaders(headers = {}) {
    Object.keys(headers).forEach((key) => {
      xhr.setRequestHeader(key, headers[key]);
    })
  }

  return {
    get: get,
    delete: del,
    post: post,
    update: update
  }
})();
