import Foundation

struct UserData {
    let name: String
    let friends: [String]
    let highScores: [Int]
}

func getUserName() async -> String {
    "Tim Cook"
}

func getHighScores() async -> [Int] {
    [15, 10, 20, 5]
}

func getFriends() async -> [String] {
    ["Ati", "Reimi", "Willie"]
}

func printUserDetails() async {
    //  Await писать не нужно перед getUserName, потому что мы перед let уже написали async
    async let name = getUserName()
    async let friends = getFriends()
    async let scores = getHighScores()
    //  "Надписи" выше позволят вызвать все функции одновременно и дожидаться результатов выполнения каждой из них.
    
    //  await перед словом UserData - позволяет дождаться результатов всех функций, которые мы вызвали выше
    let user = await UserData(name: name, friends: friends, highScores: scores)
    print(user)
}

Task {
    await printUserDetails()
}

