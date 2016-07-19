//
//  UnicodeIterator.swift
//  CSV
//
//  Created by Yasuhiro Hatta on 2016/06/20.
//  Copyright © 2016 yaslab. All rights reserved.
//

internal struct UnicodeIterator<
    Input: IteratorProtocol,
    InputEncoding: UnicodeCodec
    where InputEncoding.CodeUnit == Input.Element>
    : IteratorProtocol {
    
    private var input: Input
    private var inputEncoding: InputEncoding
    
    internal init(input: Input, inputEncodingType: InputEncoding.Type) {
        self.input = input
        self.inputEncoding = inputEncodingType.init()
    }
    
    internal mutating func next() -> UnicodeScalar? {
        switch inputEncoding.decode(&input) {
        case .scalarValue(let c): return c
        case .emptyInput: return nil
        case .error: return nil
        }
    }
    
}
