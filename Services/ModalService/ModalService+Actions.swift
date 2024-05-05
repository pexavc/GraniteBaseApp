import Foundation
import GraniteUI
import SwiftUI
import SafariServices

extension ModalService {
    
    #if os(iOS)
    func present(_ modal : AnyGraniteModal, target: GraniteSheetPresentationStyle = .cover) {
        
        switch target {
        case .sheet:
            modalSheetManager.present(modal)
        default:
            modalManager.present(modal)
        }
    }
    func presentModal(_ modal : AnyGraniteModal, target: GraniteSheetPresentationStyle = .cover) {
        present(modal, target: target)
    }
    #else
    func presentModal(_ modal : AnyGraniteModal, target: GraniteSheetPresentationStyle = .cover) {
        
        switch target {
        case .sheet:
            modalSheetManager.present(modal)
        default:
            modalManager.present(modal)
        }
    }
    func present(id: String = GraniteSheetManager.defaultId,
                 _ alert: GraniteAlertView) {
        presentSheet(id: id) {
            alert
                .attach( {
                    sheetManager.dismiss(id: id)
                }, at: \.dismiss)
                .frame(maxWidth: 480)
                .environmentObject(modalManager)
        }
    }
    #endif
    
    func presentErrorToast(title: LocalizedStringKey = "Error", error: Error?) {
        #if os(iOS)
        modalManager.present(GraniteToastView(title: title,
                                              message: .init(error?.localizedDescription ?? "Something went wrong"),
                                              event: .error))
        #endif
    }
    
    func dismiss() {
        modalManager.dismiss()
    }
    
}

extension ModalService {
    
    var shouldPreventSheetDismissal : Bool {
        get {
            sheetManager.shouldPreventDismissal
        }
        nonmutating set {
            sheetManager.shouldPreventDismissal = newValue
        }
    }
    
    func presentSheet<Content : View>(id: String = GraniteSheetManager.defaultId,
                                      style : GraniteSheetPresentationStyle = .sheet, @ViewBuilder content : () -> Content) {
        sheetManager.present(id: id, content: content, style: style)
    }
    
    func dismissSheet() {
        sheetManager.dismiss()
    }
    
}

extension ModalService {
    static func share(urlString: String) {
        #if os(iOS)
        let url: URL? = URL(string: urlString)
        guard let url else { return }
        ModalService.presentActivitySheet(items: [url])
        #endif
    }
    
    static func presentActivitySheet(items : [Any]) {
        #if os(iOS)
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.overrideUserInterfaceStyle = .dark
        
        let parentController = UIApplication.shared.topViewController ?? UIApplication.shared.windows.first?.rootViewController
        parentController?.present(controller, animated: true, completion: nil)
        #endif
    }
    
    static func presentBrowser(url : URL) {
        #if os(iOS)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if components?.scheme == nil {
            components?.scheme = "http"
        }
        
        guard let url = components?.url else {
            return
        }
        
        let controller = SFSafariViewController(url: url)
        controller.overrideUserInterfaceStyle = .dark
        controller.modalPresentationStyle = .overFullScreen
        
        let parentController = UIApplication.shared.topViewController ?? UIApplication.shared.windows.first?.rootViewController
        parentController?.present(controller, animated: true, completion: nil)
        #endif
    }
    
}

extension View {
    
    public func addGraniteSheet<Background : View>(id: String = GraniteSheetManager.defaultId,
                                                   _ manager : GraniteSheetManager, background : Background) -> some View {
        GraniteSheetContainerView(id: id, content: self, background: background)
            .environmentObject(manager)
    }
    
    public func addGraniteSheet(id: String = GraniteSheetManager.defaultId,
                                _ manager : GraniteSheetManager) -> some View {
        GraniteSheetContainerView(id: id, content: self, background: Color.black)
            .environmentObject(manager)
    }
    
    public func addGraniteSheet<Background : View>(id: String = GraniteSheetManager.defaultId,
                                _ manager : GraniteSheetManager,
                                modalManager : GraniteModalManager,
                                background : Background) -> some View {
        GraniteSheetContainerView(id: id, modalManager: modalManager, content: self, background: background)
            .environmentObject(manager)
    }
    
    public func addGraniteModal(_ manager: GraniteModalManager) -> some View {
        #if os(macOS)
        Group {
            if let view = manager.view {
                self.overlay(view)
            } else {
                self
            }
        }
        #else
        self
        #endif
    }
}
