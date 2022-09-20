import Foundation

func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    guard let output = String(data: data, encoding: .utf8) else {
        return ""
    }
    return output
}

func readVariables() {
    print("⭐️ Github tools v1.0 ⭐️")
    print("Escribe el nombre del Repositorio -> ")
    guard let strRepo = readLine(), !strRepo.isEmpty else { return }
    print("Escribe una descripción -> ")
    guard let strDescription = readLine(), !strDescription.isEmpty else { return }
    
    print(shell("gh repo create \(strRepo) --public -d \"\(strDescription)\""))
    print(shell("git remote add origin https://github.com/ierwinx/\(strRepo).git"))
    print(shell("git push -u origin main"))
}

readVariables()
