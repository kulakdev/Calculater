import Foundation
import SwiftUI

struct Numb: View {


    @Binding public var num: Int
    @Binding var calcnum: Int
    
    var body: some View {
        Button("\(num)",action: updateCalcnum)
        .padding()
        .background(Color(red: 0.808, green: 0.8, blue: 0.808))
        .clipShape(RoundedRectangle(cornerRadius: 7))
    }
    
    func updateCalcnum() {
        calcnum = num
    }
    
    
    
   
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        Numb(num: .constant(1), calcnum: .constant(2))
    }
}
