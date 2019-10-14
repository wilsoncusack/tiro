//
//  Util.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/8/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

func compose<A, B, C>(
  _ f: @escaping (B) -> C,
  _ g: @escaping (A) -> B
  )
  -> (A) -> C {

    return { (a: A) -> C in
      f(g(a))
    }
}

func with<A, B>(_ a: A, _ f: (A) throws -> B) rethrows -> B {
  return try f(a)
}
