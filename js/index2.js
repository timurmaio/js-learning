function fib(n) {
	if (n === 0 || n === 1) return 1;
	return fib(n - 1) + fib(n - 2);
}

function fib2(n) {
	let result = 1;
	let prev = 1;
	let prev2 = 1;

	for (let i = 0; i <= n; i++) {
		if (i === 0) result = 1;
		if (i === 1) result = 1;
		if (i > 1) { 
			result = prev + prev2; // 5
			prev2 = prev; // 3
			prev = result; // 5
		}
	}
	return result;
}

function initArray() {
	return new Array(10).map(function (x, i) { return i; });
}

function finalTransformation(firstArr, secondArr) {
	return f;
}

console.log(initArray());

function f(item) {
    console.log(item)
    return item === 'sdf'
}

function find(f) {
    var arr = ['a', 'dsaads', 'sdf'];

    for (let i = 0; i < arr.length; i++) {
        if (f(arr[i]) === true) {
            return i;
        }
    }
}

console.log(find(f));

arr.find()

