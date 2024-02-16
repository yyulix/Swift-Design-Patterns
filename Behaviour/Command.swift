protocol Command {
    func execute()
    func undo()
}

class CopyCommand: Command {
    private var receiver: TextEditor
    private var backup: String

    init(receiver: TextEditor) {
        self.receiver = receiver
        self.backup = receiver.text
    }

    func execute() {
        receiver.copy()
    }

    func undo() {
        receiver.text = backup
    }
}

class PasteCommand: Command {
    private var receiver: TextEditor
    private var backup: String

    init(receiver: TextEditor) {
        self.receiver = receiver
        self.backup = receiver.text
    }

    func execute() {
        receiver.paste()
    }

    func undo() {
        receiver.text = backup
    }
}

class TextEditor {
    var text: String = ""
    
    func copy() {
        print("Copied")
    }
    
    func paste() {
        print("Pasted")
    }
}

class CommandManager {
    private var history: [Command] = []
    
    func execute(command: Command) {
        command.execute()
        history.append(command)
    }
    
    func undo() {
        if let lastCommand = history.popLast() {
            lastCommand.undo()
        }
    }
}

let editor = TextEditor()
let copyCommand = CopyCommand(receiver: editor)
let pasteCommand = PasteCommand(receiver: editor)

let manager = CommandManager()
manager.execute(command: copyCommand)
manager.execute(command: pasteCommand)
manager.undo()
