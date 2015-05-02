import XCTest
import Quick
import Nimble


class BananaSpec: QuickSpec {
    override func spec() {
        
        describe("the 'Documentation' directory") {
            it("is peel"){
                let banana:Banana = Banana()
                banana.peel()
                expect(banana.isEdible).to(beTruthy())
            }
            
            
        }
    }
    
}
