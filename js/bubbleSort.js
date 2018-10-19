function bubbleSort(arr) {
	var tmp
	// var counter

	for (var j = 0; j < arr.length; j++) {
		// console.log(arr[j])
		for(var i = 0; i < arr.length - j; i++)
			if (arr[i] > arr[i + 1]) {
				tmp = arr[i]
				arr[i] = arr[i + 1]
				arr[i + 1] = tmp
			}
	}
	return arr
}

var arr = [0, 5, 1, 3, 2, 7, 1, 4, 8, 15]

var sortedArr = bubbleSort(arr)

console.log(sortedArr)

// console.log(arr.length)