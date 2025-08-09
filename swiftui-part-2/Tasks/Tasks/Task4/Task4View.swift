import SwiftUI

struct Task4View: View {
    
    @State private var isDarkMode = false
    
    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $isDarkMode)
                .toggleStyle(ColorChangingToggleStyle())
                .padding()
            
            Spacer()
            
            Text("Custom Toggle Style")
                .font(.title)
                .bold()
                .frame(maxHeight: .infinity, alignment: .center)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    NavigationStack { Task4View() }
}

struct ColorChangingToggleStyle: ToggleStyle {
    
    private let systemImage = "moon.fill"
    private let onColor = Color.blue
    private let offColor = Color.red
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? onColor : offColor)
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .overlay {
                            Image(systemName: systemImage)
                                .foregroundColor(configuration.isOn ? onColor : offColor)
                        }
                        .offset(x: configuration.isOn ? 10 : -10)
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
