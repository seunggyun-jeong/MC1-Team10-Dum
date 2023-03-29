
import SwiftUI



struct Stage1_Main: View {
    
    
    
    var body: some View{
        
        ZStack{
            Image("spaceAwkward")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Image("monsterName")
                .resizable()
                .scaledToFit()
                .frame(width: 265)
                .offset(x:155, y:-110)
            
            
            Image("roseMonster")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            GeometryReader { proxy in
                ForEach(0...5, id:\.self) { index in
                    LeafRightView(index: index, offset: logicalFunction(size: proxy.size))
                    LeafLeftView(index: index, offset: logicalFunction(size: proxy.size))
                }
            }
        }
    }
    
    func logicalFunction(size: CGSize) -> CGSize {
        let width: CGFloat = CGFloat.random(in: -120...200)
        let height: CGFloat = CGFloat.random(in: -100...200)
  
        return CGSize(width: width, height: height)
        
    }
    
}
