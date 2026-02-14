import Foundation


func fetchWeatherHistory(completion: @escaping ([Int]) -> Void) {
    //  Генерируем 365 случайных чисел в диапозоне -35 -- +35 и добавляем их в массив
    let results = (1...365).map { _ in Int.random(in: -35...35) }
    
    //  DispatchQueue - класс из нативного API GCD, который позволяет распараллеливать потоки
    //  Ниже - мы выполняем задачу в основном потоке, но с задержкой в одну секунду. Это позволяет сделать метод - AsyncAfter
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //  Через одну секунду выполнится этот блок. В самом блоке
        completion(results)
    }
}

