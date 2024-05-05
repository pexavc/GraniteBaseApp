import Granite
import SwiftUI

extension ConfigService {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var config: InstanceConfig? = nil
        }
        
        @Event var boot: Boot.Reducer
        
        @Store(persist: "persistence.config.Lemur.0000") public var state: State
    }
}
