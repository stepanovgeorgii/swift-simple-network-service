import XCTest
@testable import SimpleNetworkService

final class SimpleNetworkServiceTests: XCTestCase {
    // MARK: - Private
    private enum BaseUrl: String {
        case todos = "https://jsonplaceholder.typicode.com"
    }

    private var todosNetworkService: SimpleNetworkService!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        todosNetworkService = SimpleNetworkService(
            configurator: SimpleNetworkServiceConfiguration(
                baseUrl: BaseUrl.todos.rawValue
            )
        )

    }

    override func tearDown() {
        todosNetworkService = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testGetTodos() async throws {
        let router = TodosRouter.todos
        let result: [Todo] = try await todosNetworkService.request(router: router)
        XCTAssertFalse(result.isEmpty)
    }

    func testGetTodo() async throws {
        let router = TodosRouter.todo(id: 1)
        let result: Todo = try await todosNetworkService.request(router: router)
        let expectedTodo = Todo(userId: 1, id: 1, title: "delectus aut autem", completed: false)
        XCTAssertEqual(result, expectedTodo)
    }

}
