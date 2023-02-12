import SwiftUI
import WalletChainCore

extension RustString: Error {
    var desctription: String {
        return self.toString()
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("Return String: \(hello_rust().toString())")
            //Text("Return Result String: \(String(reflecting: try! rust_()))")
            //Text("Return Result String: \(String(reflecting: ))")
            Text("Coin Enum: \(String(reflecting: Coin.Ethereum))")
            
            Button("Fetch My IP") {
                Task {
                    let text = await get_my_ip_from_rust();
                    print("My IP: \(text.origin.toString())")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
