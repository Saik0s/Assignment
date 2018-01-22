//
//  RxIGListAdapterDataSource.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/09.
//  Copyright © 2017 yuzushioh. All rights reserved.
//

import RxSwift
import IGListKit
import RxCocoa

public protocol RxListAdapterDataSource {
    associatedtype Element
    func listAdapter(
            _ adapter: ListAdapter,
            observedUser: RxSwift.Event<Element>
    )
}

extension Reactive where Base: ListAdapter {
    public func items<DataSource, O: ObservableType>(dataSource: DataSource) ->
            (_ source: O) -> Disposable
            where DataSource: RxListAdapterDataSource & ListAdapterDataSource,
            DataSource.Element == O.E {
        return { source in
            let subscription = source.subscribe {
                dataSource.listAdapter(self.base, observedUser: $0)
            }

            return Disposables.create {
                subscription.dispose()
            }
        }
    }

    public func setDataSource<DataSource>(_ dataSource: DataSource)
                    -> Disposable
            where DataSource: RxListAdapterDataSource & ListAdapterDataSource {
        base.dataSource = dataSource
        return Disposables.create()
    }
}
