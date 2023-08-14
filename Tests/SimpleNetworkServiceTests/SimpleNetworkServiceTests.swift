import XCTest
@testable import SimpleNetworkService

final class SimpleNetworkServiceTests: XCTestCase {
    private var networkService: SimpleNetworkService!

    override func setUp() {
        super.setUp()
        networkService = SimpleNetworkService()
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
}
