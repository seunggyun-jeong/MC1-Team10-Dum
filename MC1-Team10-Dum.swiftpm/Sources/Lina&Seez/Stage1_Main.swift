
import SwiftUI



struct Stage1_Main: View {
    
    @StateObject var SIClass: StageInformationClass
    @StateObject var leafVM:LeafViewModel = LeafViewModel()
    @State private var deadFlag: Bool = true
    
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
                .opacity( leafVM.countLeaf <= 2  ? 0.8 : 0.0)
            
            GeometryReader { proxy in
                ForEach(0...4, id:\.self) { index in
                    LeafRightView(index: index, offset: logicalFunction(size: proxy.size), leafVM: leafVM)
                    LeafLeftView(index: index, offset: logicalFunction(size: proxy.size), leafVM: leafVM)
                }
            }.animation(.easeInOut(duration: 1), value: leafVM.countLeaf)

            
           
            StageClearView(SIClass: SIClass, deadFlag: $deadFlag, mentorImageName: "judyMonster", mentorName: "JUDY", mentorSpeak: "어색함 괴물을 물리쳤군! 수고했어!\nCBL에서 필수 스킬인 소통 능력 획득으로\n원팀이 되었군!")
            .opacity(leafVM.countLeaf == 0  ? 0.8 : 0.0)
            .animation(.linear(duration: 3), value: leafVM.countLeaf==0)
        }
        .navigationBarHidden(true)
    }
        
    func logicalFunction(size: CGSize) -> CGSize {
        let width: CGFloat = CGFloat.random(in: -120...200)
        let height: CGFloat = CGFloat.random(in: -100...200)
  
        return CGSize(width: width, height: height)
        
    }
    
}

struct Stage1_Main_Previews: PreviewProvider {
    static var previews: some View {
        Stage1_Main(SIClass: StageInformationClass())
    }
}
