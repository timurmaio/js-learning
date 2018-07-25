/**
 * 
 */
function isObject() {

}

/**
 * 
 */
function isFunction() {

}


const _isFunction = function(obj) {
    return !!(obj && obj.constructor && obj.call && obj.apply);
};
