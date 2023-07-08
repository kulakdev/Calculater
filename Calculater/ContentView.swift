import SwiftUI
import Eval

let config = DoubleEvalConfiguration()

struct ContentView: View {
    @State public var calcnum: Int = 0
    @State public var field: String = ""
    @State private var calculate: Double = 0
    
    enum Buttons: String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case zero = "0"
        case add = "+"
        case sub = "-"
        case mult = "*"
        case divide = "/"
        case clrall = "CA"
        case decimal = "."
        case backspace = "⌫"
        case perc = "⁒"
        case brac = "( )"
        case equal = "="
        
        var ButtColor: Color {
            switch self{
            case .clrall, .brac, .perc:
                return Color(.lightGray)
            case .divide, .mult, .sub, .add, .equal:
                return .orange
            default:
                return Color(.darkGray)
            }
        }
    }
    
    var buttons: [[Buttons]] = [
        [.clrall, .brac, .perc, .divide],
        [.seven, .eight	, .nine, .mult],
        [.four, .five, .six, .sub],
        [.one, .two, .three, .add],
        [.zero, .decimal, .backspace, .equal]
    ]
    
    
    
    var width = (UIScreen.main.bounds.width - 40) / 4
    var height = UIScreen.main.bounds.height - 40
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            
            
            VStack {
                TextField("", text: $field, prompt: Text("Prompt text").foregroundColor(.gray))
                    .padding()
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.trailing)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .border(Color.white, width: 2)
                
                VStack {
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    switch item {
                                    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
                                        field += item.rawValue
                                    case .clrall:
                                        field = ""
                                    case .mult:
                                        if let lastChar = field.last, lastChar.isNumber || lastChar == "." || lastChar == "⁒" || lastChar == "+" || lastChar == "-" || lastChar == "*"   {
                                            field += item.rawValue
                                        }
                                    case .backspace:
                                        field = String(field.dropLast())
                                    case .brac:
                                        if field.last != "(" && field != "" {
                                            field += ")"
                                        }
                                        else {
                                            field += "("}
                                    case .equal:
                                        doCalc(equationString: field, config: config)
                                        
                                    default:
                                        field += item.rawValue
                                    }
                                }
                                ) {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(width: width, height: width)
                                        .background(item.ButtColor, in: Circle())
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func doCalc(equationString:String, config: EvalConfiguration) {
        calculate = try! (Evaluator.execute(expression: equationString, configuration: config) as? Double)!
        field = String(calculate)
    }
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    }

