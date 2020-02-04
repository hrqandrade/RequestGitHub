//
//  Utils.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 03/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

public func formatNumberAcessibility(_ n: Int) -> String {

    let num = abs(Double(n))
    let sign = (n < 0) ? "-" : ""

    switch num {

    case 1_000_000_000...:
        var formatted = num / 1_000_000_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted) bilhões"

    case 1_000_000...:
        var formatted = num / 1_000_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted) milhões"

    case 1_000...:
        var formatted = num / 1_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted)  mil"

    case 0...:
        return "\(n)"

    default:
        return "\(sign)\(n)"

    }

}

public func formatNumber(_ n: Int) -> String {

    let num = abs(Double(n))
    let sign = (n < 0) ? "-" : ""

    switch num {

    case 1_000_000_000...:
        var formatted = num / 1_000_000_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted)B"

    case 1_000_000...:
        var formatted = num / 1_000_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted)M"

    case 1_000...:
        var formatted = num / 1_000
        formatted = formatted.truncate(places: 1)
        return "\(sign)\(formatted)K"

    case 0...:
        return "\(n)"

    default:
        return "\(sign)\(n)"
    }

}

public func showAlert(view: UIViewController) {
    let alert = UIAlertController(title: "Atenção", message: "Erro ao recuperar os dados, por favor tente mais tarde.", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    view.present(alert, animated: true)
}

public func setActivity(viewWidth: UIView) -> UIView {
       let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: viewWidth.bounds.width, height: CGFloat(44))
        return spinner
}



