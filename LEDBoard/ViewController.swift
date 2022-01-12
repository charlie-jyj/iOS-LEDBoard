//
//  ViewController.swift
//  LEDBoard
//
//  Created by UAPMobile on 2022/01/06.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {
    
    @IBOutlet weak var contentsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentsLabel.textColor = .yellow
    }
    
    // segueway 를 사용했기 때문에 prepare 함수 안에서 vc 가 위임자임을 선언한다. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.ledText = self.contentsLabel.text
            settingViewController.textColor = self.contentsLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
    
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.contentsLabel.text = text
            self.contentsLabel.textColor = textColor
            self.view.backgroundColor = backgroundColor
        }
    }


}

