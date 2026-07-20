struct MenuView: View {
    var body: some View {
        Button("Quit") {
        //exit(0)
            NSApplication.shared.terminate(nil)
        }
        .keyboardShortcut("q")
    }
}
