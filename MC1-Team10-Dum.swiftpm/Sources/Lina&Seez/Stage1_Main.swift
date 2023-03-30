
import SwiftUI



struct Stage1_Main: View {
    
    @StateObject var leafVM:LeafViewModel = LeafViewModel()

    
    var body: some View{
        
        ZStack{
            Image("spaceAwkward")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Image("Stage_transparent")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Image("monsterName")
                .resizable()
                .scaledToFit()
                .frame(width: 265)
                .offset(x:155, y:-110)
            
            
            Image("roseMonster")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(leafVM.countLeaf == 0 ? .degrees(3) : .degrees(0))
                .animation(.linear.repeatForever().speed(5), value: leafVM.countLeaf)
            
            Image("speechBubble")
                .resizable()
                .scaledToFit()
                .offset(x: -200, y:-140)
                .animation(.linear.repeatForever().speed(5), value: leafVM.countLeaf)
            
            GeometryReader { proxy in
                ForEach(0...4, id:\.self) { index in
                    LeafRightView(index: index, offset: logicalFunction(size: proxy.size), leafVM: leafVM)
                    LeafLeftView(index: index, offset: logicalFunction(size: proxy.size), leafVM: leafVM)
                }
            }.animation(.easeInOut(duration: 1))
            
            
        ZStack{
            Image("stage1Dark")
                .resizable()
                .aspectRatio(contentMode: .fill)
            }.opacity(leafVM.countLeaf == 0 ? 0.8 : 0.0)
        }
        
        
    }
    
    func logicalFunction(size: CGSize) -> CGSize {
        let width: CGFloat = CGFloat.random(in: -120...200)
        let height: CGFloat = CGFloat.random(in: -100...200)
  
        return CGSize(width: width, height: height)
        
    }
    
}


struct FinalView: View{
    var body: some View{
        Image("Stage 7")
    }
}
