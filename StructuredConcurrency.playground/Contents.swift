import Foundation

func fibonacci(of number: Int) -> Int {
    var first = 0
    var second = 1
    
    for _ in 1..<number {
        let previous = first
        first = second
        second = previous + first
    }
    
    return first
}

fibonacci(of: 8)

//  Данная функция аснхронная, так как на реализацию этой функции пришлось тратить много времени и она тормозила бы основной поток (из-за чего пользовательский интерфейс бы лагал\фризил). Мы отправляем эту задачу на фоновый режим (делаем асинхронно, параллельно всем процессам).
func setFibonacciSequence(to numberCount: Int) async {
    var numbers: [Int] = []
    
    for iteration in 1...numberCount {
        let result = fibonacci(of: iteration)
        numbers.append(result)
    }
    
    print("The first \(numberCount) numbers in the fibonacci sequence are: \(numbers)")
}

Task {
    await setFibonacciSequence(to: 60)
}

//  В примере выше, мы вызвали обычную последовательную функцию внутри асинхронной функции
