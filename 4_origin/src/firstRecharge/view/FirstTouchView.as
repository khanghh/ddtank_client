package firstRecharge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import firstRecharge.FirstRechargeControl;
   import firstRecharge.FirstRechargeManger;
   import firstRecharge.data.RechargeData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class FirstTouchView extends Frame implements Disposeable
   {
       
      
      private var _treeImage:ScaleBitmapImage;
      
      private var _treeImage2:ScaleBitmapImage;
      
      private var _worldtitle:Bitmap;
      
      private var _child:Bitmap;
      
      private var _back:MutipleImage;
      
      private var _btn:SimpleBitmapButton;
      
      private var _goodsContentList:Vector.<BagCell>;
      
      private var _line:Bitmap;
      
      private var _cartoonList:Vector.<MovieClip>;
      
      private var _rechargeMoneyTotalText:GradientText;
      
      private var _rechargeGiftBagValueText1:GradientText;
      
      private var _rechargeGiftBagValueText2:GradientText;
      
      private var _wordDirept:FilterFrameText;
      
      private var _wordDirept2:FilterFrameText;
      
      private var _wordDirept3:FilterFrameText;
      
      private var _wordDirept4:FilterFrameText;
      
      private var _endTimeTxt:FilterFrameText;
      
      private var _daojishiTxt:Bitmap;
      
      public function FirstTouchView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function initView() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc7_:* = null;
         _goodsContentList = new Vector.<BagCell>();
         _treeImage = ComponentFactory.Instance.creatComponentByStylename("fristRecharge.scale9cornerImageTree");
         addToContent(_treeImage);
         _treeImage2 = ComponentFactory.Instance.creatComponentByStylename("accumulationView.rightBottomBgImg");
         addToContent(_treeImage2);
         _back = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.SignedAwardBack");
         addToContent(_back);
         _wordDirept = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept.text = "Gunner thân mến:\nBạn chưa nạp thẻ trong thời gian hoạt động. ";
         addToContent(_wordDirept);
         _wordDirept2 = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept2.text = LanguageMgr.GetTranslation("firstTouchView.wordDirept2");
         PositionUtils.setPos(_wordDirept2,"firstRecharge.wordDireptText2Pos");
         addToContent(_wordDirept2);
         _rechargeGiftBagValueText1 = ComponentFactory.Instance.creatComponentByStylename("fristRecharge.rechargeMoneyTotalText1");
         addToContent(_rechargeGiftBagValueText1);
         _rechargeGiftBagValueText1.x = _wordDirept2.x + _wordDirept2.width;
         _rechargeGiftBagValueText1.y = _wordDirept2.y - 3;
         _rechargeGiftBagValueText1.text = FirstRechargeManger.Instance.rechargeMoneyTotal + " xu";
         _wordDirept3 = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept3.text = LanguageMgr.GetTranslation("firstTouchView.wordDirept3");
         _wordDirept3.x = _rechargeGiftBagValueText1.x + _rechargeGiftBagValueText1.width;
         _wordDirept3.y = _rechargeGiftBagValueText1.y + 3;
         addToContent(_wordDirept3);
         _wordDirept4 = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.wordDireptText");
         _wordDirept4.text = LanguageMgr.GetTranslation("firstTouchView.wordDirept4");
         PositionUtils.setPos(_wordDirept4,"firstRecharge.wordDireptText2Pos4");
         addToContent(_wordDirept4);
         _rechargeMoneyTotalText = ComponentFactory.Instance.creatComponentByStylename("fristRecharge.rechargeMoneyTotalText");
         addToContent(_rechargeMoneyTotalText);
         PositionUtils.setPos(_rechargeMoneyTotalText,"firstRecharge.wordDireptText2Pos3");
         _rechargeMoneyTotalText.text = LanguageMgr.GetTranslation("firstTouchView.rechargeMoneyTotalText");
         _worldtitle = ComponentFactory.Instance.creatBitmap("fristRecharge.libao.title");
         addToContent(_worldtitle);
         titleText = LanguageMgr.GetTranslation("ddt.firstIntimateContact");
         _cartoonList = new Vector.<MovieClip>(2);
         var _loc2_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < 7)
         {
            _loc5_ = new BagCell(_loc6_);
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("recharge.ItemBg");
            _loc4_.x = _loc6_ * (_loc5_.width + 8) + 60;
            _loc4_.y = 254;
            _loc5_.x = _loc4_.x + 2;
            _loc5_.y = _loc4_.y + 2;
            addToContent(_loc4_);
            addToContent(_loc5_);
            _loc5_.setBgVisible(false);
            _goodsContentList.push(_loc5_);
            _loc3_ = FirstRechargeManger.Instance.getGoodsList_haiwai().length;
            if(_loc3_ > 1)
            {
               if(_loc6_ == 0 || _loc6_ == 1)
               {
                  _loc1_ = ComponentFactory.Instance.creat("firstRecharge.cartoon");
                  _loc1_.mouseChildren = false;
                  _loc1_.mouseEnabled = false;
                  _loc1_.x = _loc4_.x - 21;
                  _loc1_.y = _loc4_.y - 36;
                  addToContent(_loc1_);
                  _cartoonList[_loc6_] = _loc1_;
               }
            }
            else if(_loc6_ == 0)
            {
               _loc7_ = ComponentFactory.Instance.creat("firstRecharge.cartoon");
               _loc7_.mouseChildren = false;
               _loc7_.mouseEnabled = false;
               _loc7_.x = _loc4_.x - 21;
               _loc7_.y = _loc4_.y - 36;
               addToContent(_loc7_);
               _cartoonList[_loc6_] = _loc7_;
            }
            _loc6_++;
         }
         _child = ComponentFactory.Instance.creatBitmap("fristRecharge.child");
         addToContent(_child);
         _btn = ComponentFactory.Instance.creatComponentByStylename("accumulationView.ftxtBtn");
         addToContent(_btn);
         _btn.addEventListener("click",clickHander);
         _endTimeTxt = ComponentFactory.Instance.creatComponentByStylename("firstRecharge.timePlayTxt");
         addToContent(_endTimeTxt);
         _daojishiTxt = ComponentFactory.Instance.creatBitmap("fristRecharge.downtimes");
         addToContent(_daojishiTxt);
         refreshTimePlayTxt();
      }
      
      public function setGoodsList(param1:Vector.<RechargeData>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.length;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_ >= 7)
            {
               return;
            }
            if(param1[_loc4_] && param1[_loc4_].RewardID < 2000)
            {
               _goodsContentList[_loc4_].info = FirstRechargeControl.Instance.setGoods(param1[_loc4_]);
               _goodsContentList[_loc4_].setCount(param1[_loc4_].RewardItemCount);
            }
            _loc2_++;
            _loc4_++;
         }
      }
      
      protected function clickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         LeavePageManager.leaveToFillPath();
      }
      
      private function changeStringToDate(param1:String) : Date
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(param1 == "" || param1 == null)
         {
            return null;
         }
         _loc5_ = param1.split(" ");
         _loc3_ = _loc5_[0].split("-");
         _loc2_ = _loc5_[1].split(":");
         _loc4_ = new Date(_loc3_[0],_loc3_[1] - 1,_loc3_[2],_loc2_[0],_loc2_[1],_loc2_[2]);
         return _loc4_;
      }
      
      private function refreshTimePlayTxt() : void
      {
         var _loc8_:* = null;
         var _loc4_:String = FirstRechargeManger.Instance.rechargeEndTime;
         var _loc6_:Date = changeStringToDate(_loc4_);
         var _loc7_:Number = _loc6_.getTime();
         var _loc1_:Date = TimeManager.Instance.Now();
         var _loc5_:Number = _loc1_.getTime();
         var _loc2_:Number = _loc7_ - _loc5_;
         _loc2_ = _loc2_ < 0?0:Number(_loc2_);
         var _loc3_:int = 0;
         if(_loc2_ / 86400000 > 1)
         {
            _loc3_ = _loc2_ / 86400000;
            _loc8_ = _loc3_ + LanguageMgr.GetTranslation("day");
         }
         else if(_loc2_ / 3600000 > 1)
         {
            _loc3_ = _loc2_ / 3600000;
            _loc8_ = _loc3_ + LanguageMgr.GetTranslation("hour");
         }
         else if(_loc2_ / 60000 > 1)
         {
            _loc3_ = _loc2_ / 60000;
            _loc8_ = _loc3_ + LanguageMgr.GetTranslation("minute");
         }
         else
         {
            _loc3_ = _loc2_ / 1000;
            _loc8_ = _loc3_ + LanguageMgr.GetTranslation("second");
         }
         _endTimeTxt.text = LanguageMgr.GetTranslation("newChickenBox1.timePlayTxt",_loc8_);
         if(_loc3_ <= 0)
         {
            _endTimeTxt.text = LanguageMgr.GetTranslation("firstTouchView.endTimeTxt");
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_response);
         if(_btn)
         {
            _btn.removeEventListener("click",clickHander);
         }
         var _loc3_:int = 0;
         var _loc2_:* = _cartoonList;
         for each(var _loc1_ in _cartoonList)
         {
            if(_loc1_)
            {
               _loc1_.gotoAndStop(1);
            }
         }
         _cartoonList = null;
         super.dispose();
      }
   }
}
