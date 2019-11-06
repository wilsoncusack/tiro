//
//  LinkPresentation.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import LinkPresentation
import SwiftUI

struct URLPreview : UIViewRepresentable {
    var previewURL:URL
    //Add binding
    @Binding var metaSize: CGSize

    func makeUIView(context: Context) -> LPLinkView {
        LPLinkView(url: previewURL)
    }

    func updateUIView(_ view: LPLinkView, context: Context) {
        // New instance for each update

        let provider = LPMetadataProvider()

        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
            if let md = metadata {
                DispatchQueue.main.async {
                    view.metadata = md
                    view.sizeToFit()
                    //metadata?.imageProvider.ima
                    //Set binding after resize
                    self.metaSize = view.frame.size
                }
            }
        }
    }
}

//use
//   @State var metaSize: CGSize = CGSize()
//URLPreview(previewURL: URL(string: "https://www.nytimes.com/2019/10/15/world/middleeast/kurds-syria-turkey.html?action=click&module=Top%20Stories&pgtype=Homepage")!, metaSize: $metaSize)
//.frame(width: 300, height: 200)
