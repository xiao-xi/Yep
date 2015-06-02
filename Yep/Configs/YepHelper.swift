//
//  YepHelper.swift
//  Yep
//
//  Created by kevinzhow on 15/5/3.
//  Copyright (c) 2015年 Catch Inc. All rights reserved.
//

import Foundation

typealias CancelableTask = (cancel: Bool) -> Void

func delay(time: NSTimeInterval, work: dispatch_block_t) -> CancelableTask? {

    var finalTask: CancelableTask?

    var cancelableTask: CancelableTask = { cancel in
        if cancel {
            finalTask = nil // key

        } else {
            dispatch_async(dispatch_get_main_queue(), work)
        }
    }

    finalTask = cancelableTask

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
        if let task = finalTask {
            task(cancel: false)
        }
    }

    return finalTask
}

func cancel(cancelableTask: CancelableTask?) {
    cancelableTask?(cancel: true)
}