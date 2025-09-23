import SwiftUI

/// UIViewControllerRepresenter
/// ref: - https://zenn.dev/matsuji/articles/f35e91682a1ed5
public struct UIViewControllerRepresenter<ViewController: UIViewController, Coordinator>: UIViewControllerRepresentable {
    private let makeCoordinatorHandler: @MainActor () -> Coordinator
    private let makeUIViewControllerHandler: @MainActor (Context) -> ViewController
    private let updateUIViewControllerHandler: @MainActor (ViewController, Context) -> Void
    private let sizeThatFitsHandler: @MainActor (ProposedViewSize, ViewController, Context) -> CGSize?
    
    public init(
    makeCoordinator: @escaping @MainActor () -> Coordinator = { () },
    makeUIViewController: @escaping @MainActor (Context) -> ViewController,
    updateUIViewController: @escaping @MainActor (ViewController, Context) -> Void = { _, _ in },
    sizeThatFits: @escaping @MainActor (ProposedViewSize, ViewController, Context) -> CGSize? = { _, _, _ in nil }
    ) {
        self.makeCoordinatorHandler = makeCoordinator
        self.makeUIViewControllerHandler = makeUIViewController
        self.updateUIViewControllerHandler = updateUIViewController
        self.sizeThatFitsHandler = sizeThatFits
    }
    
    public func makeCoordinator() -> Coordinator {
        makeCoordinatorHandler()
    }
    
    public func makeUIViewController(context: Context) -> ViewController {
        makeUIViewControllerHandler(context)
    }
    
    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        updateUIViewControllerHandler(uiViewController, context)
    }
    
    @MainActor
    public func sizeThatFits(_ proposal: ProposedViewSize, uiViewController: ViewController, context: Context) -> CGSize? {
        sizeThatFitsHandler(proposal, uiViewController, context)
    }
}
