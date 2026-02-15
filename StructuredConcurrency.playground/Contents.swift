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

Task {
    await setFibonacciSequence(to: 60)
}

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

Task {
    let readings = try await getWeatherReadings(for: "Sochi")
    print("Readings are: \(readings)")
}
