//
//  ReviewViewController.swift
//  HeardSample
//
//  Created by Thanh Tran on 3/2/16.
//  Copyright © 2016 XVolve. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Kingfisher

class ReviewViewController: UIViewController, UITextViewDelegate {
    
    var reviewObj: ReviewObject!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewComment: UIView!
    @IBOutlet weak var tvComment: UITextView!
    @IBOutlet weak var btnSummit: UIButton!
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!

    
    @IBOutlet weak var backgroundVie: UIImageView!
    var tap = UITapGestureRecognizer()
    var isKBUp: Bool = false
    @IBOutlet weak var avatar: UIImageView!
    var rate: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: "")
        PKHUD.sharedHUD.show()

        avatar.kf_setImageWithURL(NSURL(string: "https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xpa1/v/t1.0-9/11221845_10153577034343463_7615505548754319145_n.jpg?oh=b00696c8fd115e6bcca6fab38955581b&oe=5761EA0B")!, placeholderImage: nil, optionsInfo:.None) { (image, error, cacheType, imageURL) -> () in
            
            PKHUD.sharedHUD.hide(afterDelay: 0.0, completion: nil)
        }
        
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.layer.masksToBounds = true
        avatar.clipsToBounds = true
        avatar.layer.borderColor = UIColor.whiteColor().CGColor
        avatar.layer.borderWidth = 2.0
    }
    
    override func viewWillAppear(animated: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: "")
        PKHUD.sharedHUD.show()
        
        backgroundVie.kf_setImageWithURL(NSURL(string: "https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xpa1/v/t1.0-9/11221845_10153577034343463_7615505548754319145_n.jpg?oh=b00696c8fd115e6bcca6fab38955581b&oe=5761EA0B")!, placeholderImage: nil, optionsInfo:.None) { (image, error, cacheType, imageURL) -> () in
            
            PKHUD.sharedHUD.hide(afterDelay: 0.0, completion: nil)
            
            let blurEffect = UIBlurEffect(style: .Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.backgroundVie.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.backgroundVie.addSubview(blurEffectView)
        }
    }
    
    func initUI(){

        viewComment.layer.cornerRadius = 5.0
        viewComment.layer.masksToBounds = true
        viewComment.clipsToBounds = true
        viewComment.layer.borderColor = UIColor(red: 73/255, green: 74/255, blue: 74/255, alpha: 1).CGColor
        viewComment.layer.borderWidth = 1.0
        
        btnSummit.layer.cornerRadius = 5.0
        btnSummit.layer.masksToBounds = true
        btnSummit.clipsToBounds = true
        
        if(tvComment.text == "") {
            tvComment.text = placeHolderText
            tvComment.textColor = UIColor.lightGrayColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - textview
    var placeHolderText = "type here ( optional )"
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        tvComment.textColor = UIColor.blackColor()
        
        if(tvComment.text == placeHolderText) {
            tvComment.text = ""
        }
        
        tap = UITapGestureRecognizer(target: self, action: Selector("handleTap"))
        self.view.addGestureRecognizer(self.tap)
        
        isKBUp = true
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height + 210)
        scrollView.setContentOffset(CGPointMake(0, 135), animated: true)
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        self.view.removeGestureRecognizer(self.tap)
        
        if(textView.text == "") {
            tvComment.text = placeHolderText
            tvComment.textColor = UIColor.lightGrayColor()
        }
    }
    
    func handleTap(){
        
        resetTF()
    }
    
    func resetTF(){
        
        if(isKBUp){
            scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height - 210)
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
            
            isKBUp = false
        }
        
        tvComment.resignFirstResponder()

    }
    
    //MARK: - actions
    
    @IBAction func star1Tapped(sender: AnyObject) {
        updateStarWithNumberOfStars(1)
    }
    @IBAction func star2Tapped(sender: AnyObject) {
        updateStarWithNumberOfStars(2)
    }
    

    @IBAction func star3Tapped(sender: AnyObject) {
        updateStarWithNumberOfStars(3)
    }

    @IBAction func star4Tapped(sender: AnyObject) {
        updateStarWithNumberOfStars(4)
    }

    @IBAction func star5Tapped(sender: AnyObject) {
        updateStarWithNumberOfStars(5)
    }
    
    func updateStarWithNumberOfStars(stars: Int){
    
        switch (stars)
        {
            
        case 1:
            star1.setImage(UIImage(named: "star_active"), forState: .Normal)
            star2.setImage(UIImage(named: "star_normal"), forState: .Normal)
            star3.setImage(UIImage(named: "star_normal"), forState: .Normal)
            star4.setImage(UIImage(named: "star_normal"), forState: .Normal)
            star5.setImage(UIImage(named: "star_normal"), forState: .Normal)
            rate = 1
            break
            
        case 2:
            star1.setImage(UIImage(named: "star_active"), forState: .Normal)
            star2.setImage(UIImage(named: "star_active"), forState: .Normal)
            star3.setImage(UIImage(named: "star_normal"), forState: .Normal)
            star4.setImage(UIImage(named: "star_normal"), forState: .Normal)
            star5.setImage(UIImage(named: "star_normal"), forState: .Normal)
            rate = 2
            break
            
        case 3:
            star1.setImage(UIImage(named: "star_active"), forState: .Normal)
            star2.setImage(UIImage(named: "star_active"), forState: .Normal)
            star3.setImage(UIImage(named: "star_active"), forState: .Normal)
            star4.setImage(UIImage(named: "star_normal"), forState: .Normal)
            star5.setImage(UIImage(named: "star_normal"), forState: .Normal)
            rate = 3
            break
            
        case 4:
            star1.setImage(UIImage(named: "star_active"), forState: .Normal)
            star2.setImage(UIImage(named: "star_active"), forState: .Normal)
            star3.setImage(UIImage(named: "star_active"), forState: .Normal)
            star4.setImage(UIImage(named: "star_active"), forState: .Normal)
            star5.setImage(UIImage(named: "star_normal"), forState: .Normal)
            rate = 4
            break
            
        case 5:
            star1.setImage(UIImage(named: "star_active"), forState: .Normal)
            star2.setImage(UIImage(named: "star_active"), forState: .Normal)
            star3.setImage(UIImage(named: "star_active"), forState: .Normal)
            star4.setImage(UIImage(named: "star_active"), forState: .Normal)
            star5.setImage(UIImage(named: "star_active"), forState: .Normal)
            rate = 5
            break
            
        default:
            break
        }
    }
    
    func validateInput() -> Bool{
    
        if(rate == 0){
        
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "Please rate!")
            PKHUD.sharedHUD.show()
            
            PKHUD.sharedHUD.hide(afterDelay: 0.5, completion: nil)
            return false
        }else{
        
            if(tvComment.text == placeHolderText) {
                tvComment.text = " "
            }
            return true
        }
    }
    
    @IBAction func submitTapped(sender: AnyObject) {
        
        if(validateInput()){
            
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "Processing....")
            PKHUD.sharedHUD.show()
            
            var requestURL: String = ""
            var params: NSDictionary = NSDictionary()
            
            requestURL = "http://ec2-54-254-223-73.ap-southeast-1.compute.amazonaws.com:3005/api/conversation/submitReview"
            params = ["conversation_id": "-testconversationid_dont_delete", "rating_stars" : rate, "comment" : tvComment.text, "tip" : 3.0]
            
            Alamofire.request(.POST, requestURL, parameters: params as? [String : AnyObject], encoding: .JSON, headers: nil).responseJSON { response in
                
                if let JSON = response.result.value as? NSDictionary {
                    
                    let data: NSDictionary = JSON.objectForKey("data") as! NSDictionary
                    let convoID: String = data.objectForKey("conversation_id") as! String
                    let comment: String = data.objectForKey("comment") as! String
                    let rating: Int = data.objectForKey("rating_stars") as! Int
                    let tip: Float = data.objectForKey("tip") as! Float
                    let _id: String = data.objectForKey("id") as! String
                    
                    self.reviewObj = ReviewObject(convoID: convoID, stars: rating, comment: comment, tip: tip, ọbjID: _id)
                    
                    print(self.reviewObj)
                    
                    PKHUD.sharedHUD.hide(afterDelay: 0.75, completion: nil)
                    
                }
            }
        }
        
    }

}
