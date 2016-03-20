//
//  ViewController.swift
//  SlideshowApp
//
//  Created by TanakaShunichi on 2016/03/19.
//  Copyright © 2016年 shunichi.tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tmr : NSTimer?
    //var FirstShowFlag : Bool = true
    @IBOutlet weak var SlideShowPlay: UILabel!
    var SlideShowPlayFlag : Bool = false
    var PhotoN : Int = 0
    let img = [UIImage(named:"山.jpg"),UIImage(named:"池.jpg"),UIImage(named:"滝.jpg"),UIImage(named:"紅葉.jpg")]
    override func viewDidLoad() {
        super.viewDidLoad()
        SlideShowPlay.hidden = true
        imageView.image = img[PhotoN]
     }

    @IBOutlet weak var imageView: UIImageView!

    @IBAction func Forward(sender: AnyObject) {
        if(SlideShowPlayFlag == false){
            Next()
        }
    }
    @IBAction func Backward(sender: AnyObject) {
        if(SlideShowPlayFlag == false){
            if(PhotoN > 0){
                PhotoN--
            }
            else{
                PhotoN = img.count-1
            }
            imageView.image = img[PhotoN]
        }
    }

    func InitTimer(){
        tmr = NSTimer.scheduledTimerWithTimeInterval(
            2.0,                              // 時間間隔 秒
            target:self,                       // タイマーの実際の処理の場所
            selector: Selector("tickTimer:"),   // メソッド タイマーの実際の処理
            userInfo: nil,
            repeats: true)// 繰り返し
    }
    @IBOutlet weak var buttonFore: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    @IBAction func PlayAndStop(sender: AnyObject) {
       /* if(FirstShowFlag){
            InitTimer()
            FirstShowFlag = false
        }*/
        if(SlideShowPlayFlag == true){
            SlideShowPlay.hidden = true
            buttonBack.hidden = false
            buttonFore.hidden = false
            tmr?.invalidate()
            SlideShowPlayFlag = false
        }
        else{
            SlideShowPlay.hidden = false
            buttonBack.hidden = true
            buttonFore.hidden = true
            InitTimer()
            tmr?.fire()
            SlideShowPlayFlag = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwind(segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
    }
    func Next(){
        if(PhotoN < img.count-1){
            PhotoN++
        }
        else{
            PhotoN = 0
        }
        imageView.image = img[PhotoN]
    }
    func tickTimer(timer: NSTimer) {
        Next()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let enlargementViewController:EnlargementViewController = segue.destinationViewController as! EnlargementViewController
        enlargementViewController.imgEnlarge = img[PhotoN]
    }

}

