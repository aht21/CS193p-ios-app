struct MatchMarkers: View {
    var body: some View {
        HStack {
            VStack {
                Circle().fill()
                Circle().stroke(.primary, lineWidth: 3)
            }
            VStack {
                Circle()
                Circle().opacity(0)
            }
        }
    }
}