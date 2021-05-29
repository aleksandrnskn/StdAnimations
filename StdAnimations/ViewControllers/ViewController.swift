//
//  ViewController.swift
//  StdAnimations
//
//  Created by Aleksandr Aniskin on 23.05.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numOfAnim: UILabel!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var countAnim: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numOfAnim.text = String(countAnim)
        colorChange()
    }

    @IBAction func prevButton(_ sender: Any) {
        if countAnim > 1 { countAnim -= 1 }
        numOfAnim.text = String(countAnim)
        
        // Animation
        animate(countAnim)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if countAnim < 7 { countAnim += 1 }
        numOfAnim.text = String(countAnim)
        
        // Animation
        animate(countAnim)
    }
}

extension ViewController {
    
    func animate(_ count: Int){
        
        redView.layer.removeAllAnimations()
        
        switch count {
        // 1. Изменение цвета фона квадрата на жёлтый.
        case 1:
            print("1")
            colorChange()
        // 2. Перемещение в правый верхний угол экрана.
        case 2:
            print("2")
            upperRightCorner()
        // 3. Закругление краёв, чтобы квадрат выглядел как круг.
        case 3:
            print("3")
            roundingTheEdges()
        // 4. Поворот на 180 градусов.
        case 4:
            print("4")
            rotate180Degrees()
        // 5. «Исчезание».
        case 5:
            print("5")
            disappearing()
        // 6. Сначала увеличение в два раза, потом анимированное уменьшение обратно.
        case 6:
            print("6")
            doubleIncrease()
        // 7. Бесконечную анимацию поворота.
        case 7:
            print("7")
            endlessRotation()
        default:
            return
        }
    }
    
    // MARK: 1. Изменение цвета фона квадрата на жёлтый.
    
    func colorChange () {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.redView.backgroundColor = UIColor.yellow
        }) { isCompleted in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.redView.backgroundColor = UIColor.red
            })
            print("Completed animation")
        }
    }
    
    // MARK: 2. Перемещение в правый верхний угол экрана.
    
    func upperRightCorner () {
        rightConstraint.constant = 16
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { isCompleted in
            self.rightConstraint.constant = 127
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.redView.center.x = self.view.center.x
            })
            print("Completed animation")
        }
    }
    
    // MARK: 3. Закругление краёв, чтобы квадрат выглядел как круг.
    
    func roundingTheEdges () {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.redView.layer.cornerRadius = self.redView.frame.height / 2
        }) { isCompleted in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.redView.layer.cornerRadius = 0
            })
            print("Completed animation")
        }
    }
    
    // MARK: 4. Поворот на 180 градусов.
    
    func rotate180Degrees () {
        let angle: CGFloat = CGFloat.pi
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.redView.transform = CGAffineTransform(rotationAngle: angle)
        }) { isCompleted in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.redView.transform = CGAffineTransform(rotationAngle: angle-angle)
            })
            print("Completed animation")
        }
    }
    
    // MARK: 5. «Исчезание».
    
    func disappearing () {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.redView.alpha = 0
        }) { isCompleted in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.redView.alpha = 1
            })
            print("Completed animation")
        }
    }
    
    // MARK: 6. Сначала увеличение в два раза, потом анимированное уменьшение обратно.
    
    func doubleIncrease () {
        let origSize = heightConstraint.constant
        heightConstraint.constant = 320
        widthConstraint.constant = 320
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { isCompleted in
            self.heightConstraint.constant = origSize
            self.widthConstraint.constant = origSize
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            })
            print("Completed animation")
        }
    }
    
    // MARK: 7. Бесконечную анимацию поворота.
    
    func endlessRotation () {
        let angle: CGFloat = CGFloat.pi
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut, .repeat], animations: {
            self.redView.transform = CGAffineTransform(rotationAngle: angle)
        }) { isCompleted in
            print("Completed animation")
        }
    }
}
