import XCTest
@testable import SimpleNetworkService

final class SimpleNetworkServiceTests: XCTestCase {
    // MARK: - Private
    private enum BaseUrl: String {
        case jsonplaceholder = "https://jsonplaceholder.typicode.com"
    }

    private var jsonplaceholderNetworkService: SimpleNetworkService!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        jsonplaceholderNetworkService = SimpleNetworkService(
            configuration: SimpleNetworkServiceConfiguration(
                baseUrl: BaseUrl.jsonplaceholder.rawValue
            )
        )
    }

    override func tearDown() {
        jsonplaceholderNetworkService = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testGetTodos() async throws {
        let router = TodosRouter.todos
        let result: [Todo] = try await jsonplaceholderNetworkService.executeRequest(withRouter: router)
        XCTAssertFalse(result.isEmpty)
    }

    func testGetTodo() async throws {
        let router = TodosRouter.todo(id: 1)
        let result: Todo = try await jsonplaceholderNetworkService.executeRequest(withRouter: router)
        let expectedTodo = Todo(userId: 1, id: 1, title: "delectus aut autem", completed: false)
        XCTAssertEqual(result, expectedTodo)
    }

    func testSavePost() async throws {
        let postModel = Post(title: "New post", body: "Lorem ipsum dolor sit amet", userId: 20)
        let router = PostsRouter.savePost(postModel)
        let result: PostResponse = try await jsonplaceholderNetworkService.executeRequest(withRouter: router)
        XCTAssertEqual(postModel.title, result.title)
        XCTAssertEqual(postModel.body, result.body)
        XCTAssertEqual(postModel.userId, result.userId)
    }
}
