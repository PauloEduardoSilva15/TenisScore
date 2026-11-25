//
//  AppBackgroundImg.swift
//  TenisScore
//
//  Created by Igor Carrasco on 25/11/26.
//

import SwiftUI

/// The app's default background: an image with a progressive blur and a soft shade.
///
/// The view is composed of three layers, from back to front:
/// 1. The sharp image.
/// 2. A blurred copy, revealed gradually from top to bottom by a gradient mask.
/// 3. A black gradient that darkens the lower area.
///
/// Place it behind the screen content:
///
/// ```swift
/// content
///     .background { AppBackgroundImg(Image(.court)) }
/// ```

struct AppBackgroundImg: View {
    private let image: Image
    private let blurRadius: CGFloat
    
    /// Creates a background from an image.
    ///
    /// - Parameters:
    ///   - image: The image to fill the available space.
    ///   - blurRadius: The blur radius applied to the blurred layer, in points.
    init(_ image: Image, blurRadius: CGFloat = 12) {
        self.image = image
        self.blurRadius = blurRadius
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                filledImage(in: proxy.size)

                filledImage(in: proxy.size)
                    .blur(radius: blurRadius, opaque: true)
                    .mask {
                        LinearGradient(
                            colors: [.clear, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }

                LinearGradient(
                    stops: Self.shadeStops.map {
                        Gradient.Stop(color: .black.opacity($0.opacity), location: $0.location)
                    },
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
        .ignoresSafeArea()
        .accessibilityHidden(true)
    }
    
    private func filledImage(in size: CGSize) -> some View {
        image
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .clipped()
    }
}

extension AppBackgroundImg {

    /// A point of the shade gradient.
    struct ShadeStop: Equatable {
        /// Vertical position, from `0` (top) to `1` (bottom).
        let location: CGFloat

        /// Opacity of the black shade at this position, from `0` to `1`.
        let opacity: Double
    }

    /// The shade gradient, ordered from top to bottom.
    static let shadeStops: [ShadeStop] = [
        ShadeStop(location: 0.00, opacity: 0.08),
        ShadeStop(location: 0.15, opacity: 0.12),
        ShadeStop(location: 0.35, opacity: 0.27),
        ShadeStop(location: 0.65, opacity: 0.37),
        ShadeStop(location: 1.00, opacity: 0.52)
    ]
}

#Preview {
    AppBackgroundImg(Image("AppBackgroundImg"))
}
