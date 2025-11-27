//
// Copyright 2022-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial
// Please see LICENSE files in the repository root for full details.
//

import CommonKit
import SwiftUI

struct UserSessionsOverviewCoordinatorParameters {
    let session: MXSession
    let service: UserSessionsOverviewService
}

final class UserSessionsOverviewCoordinator: Coordinator, Presentable {
    private let parameters: UserSessionsOverviewCoordinatorParameters
    private var hostingViewController: VectorHostingController?
    private var viewModel: UserSessionsOverviewViewModelProtocol
    private let service: UserSessionsOverviewService

    private var indicatorPresenter: UserIndicatorTypePresenterProtocol?
    private var loadingIndicator: UserIndicator?

    var childCoordinators: [Coordinator] = []
    var completion: ((UserSessionsOverviewCoordinatorResult) -> Void)?

    init(parameters: UserSessionsOverviewCoordinatorParameters) {
        self.parameters = parameters
        self.service = parameters.service

        let shouldShowDeviceLogout = parameters.session.homeserverWellknown?.authentication == nil

        let vm = UserSessionsOverviewViewModel(
            userSessionsOverviewService: parameters.service,
            settingsService: RiotSettings.shared,
            showDeviceLogout: shouldShowDeviceLogout
        )
        self.viewModel = vm
    }

    func start() {
        if hostingViewController == nil {
            let host = VectorHostingController(rootView: UserSessionsOverview(viewModel: viewModel.context))
            host.vc_setLargeTitleDisplayMode(.never)
            host.vc_removeBackTitle()
            hostingViewController = host
        }

        if indicatorPresenter == nil {
            if let host = hostingViewController {
                indicatorPresenter = UserIndicatorTypePresenter(presentingViewController: host)
            }
        }

        viewModel.completion = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .showOtherSessions(sessionInfos, filter):
                self.completion?(.openOtherSessions(sessionInfos: sessionInfos, filter: filter))
            case .verifyCurrentSession:
                self.completion?(.verifyCurrentSession)
            case .renameSession(let sessionInfo):
                self.completion?(.renameSession(sessionInfo))
            case .logoutOfSession(let sessionInfo):
                self.completion?(.logoutOfSession(sessionInfo))
            case let .showCurrentSessionOverview(sessionInfo):
                self.completion?(.openSessionOverview(sessionInfo: sessionInfo))
            case let .showUserSessionOverview(sessionInfo):
                self.completion?(.openSessionOverview(sessionInfo: sessionInfo))
            case .linkDevice:
                self.completion?(.linkDevice)
            case let .logoutFromUserSessions(sessionInfos):
                self.completion?(.logoutFromUserSessions(sessionInfos: sessionInfos))
            }
        }
    }

    func toPresentable() -> UIViewController {
        return hostingViewController ?? UIViewController()
    }

    func refreshData() {
        viewModel.context.send(viewAction: .viewAppeared)
    }

    private func startLoading(label: String = VectorL10n.loading, isInteractionBlocking: Bool = true) {
        guard let indicatorPresenter = indicatorPresenter else { return }
        loadingIndicator = indicatorPresenter.present(.loading(label: label, isInteractionBlocking: isInteractionBlocking))
    }

    private func stopLoading() {
        loadingIndicator = nil
    }
}
