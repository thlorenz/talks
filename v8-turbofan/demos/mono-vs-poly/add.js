function addMono(a, b) {
  return a + b
}

function addPoly(a, b) {
  return a + b
}

let sum = 0
sum += addMono(sum, 2)
sum += addMono(sum, 3)
sum += addPoly(sum, 3)
sum += addPoly(sum, '2')

;%OptimizeFunctionOnNextCall(addMono)
;%OptimizeFunctionOnNextCall(addPoly)

sum += addMono(3, 1)
sum += addPoly(sum, 9)

print(sum)
