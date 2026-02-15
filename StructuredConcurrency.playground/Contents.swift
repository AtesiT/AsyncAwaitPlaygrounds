import Foundation

//  MARK: - 1 TASK

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

//  2nd way.

func setFibonacciSequenceUpd(to numberCount: Int) async {
    let result = (1...numberCount).map(fibonacci)
    print("The first \(numberCount) numbers in the fibonacci sequence are: \(result)")
}

//Task {
//    await setFibonacciSequence(to: 60)
//}

//  В примере выше, мы вызвали обычную последовательную функцию внутри асинхронной функции


//  MARK: - 2 TASK

enum LocationError: Error {
    case unknown
}

func getWeatherReadings(for city: String) async throws -> [Int] {
    switch city {
    case "Moscow":
        return (1...10).map { _ in Int.random(in: 6...18) }
    case "Saint Petersburg":
        return (1...10).map { _ in Int.random(in: 3...13) }
    case "Sochi":
        return (1...10).map { _ in Int.random(in: -2...20) }
    default:
        throw LocationError.unknown
    }
}

//Task {
//    let readings = try await getWeatherReadings(for: "Sochi")
//    print("Readings are: \(readings)")
//}


func runMultipleCalculation() async throws {
    let fibonacciTask = Task {
        //  Это обычная функция
        (1...60).map(fibonacci)
    }
    
    let weatherTask = Task {
        //  Это функция выкидывает throws
        try await getWeatherReadings(for: "Sochi")
    }
    
    //  Результаты хранятся в свойствах value
    
    let fibonacciResult = await fibonacciTask.value
    // Первая функция вызывается без try, потому что первая функция не выкидывает throws (она может выкидывать, но не делает этого). Сама функция без try вызывалась.
    let weatherResult = try await weatherTask.value
    //  Вторую функцию вызываем через try, потому что сама функции вызывается с поомощью try.
    
    print("The first 60 numbers in the fibonacci sequence are: \(fibonacciResult)")
    print("Readings are: \(weatherResult)")
}

//  Вызываем функцию, которую мы сделали выше
Task {
    try await runMultipleCalculation()
}
