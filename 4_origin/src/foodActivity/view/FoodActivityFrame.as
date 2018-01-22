package foodActivity.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import foodActivity.FoodActivityControl;
   import foodActivity.FoodActivityManager;
   import store.HelpFrame;
   import wonderfulActivity.data.GiftConditionInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class FoodActivityFrame extends Frame
   {
      
      private static var MONEY:int = 100;
       
      
      private var _bg:Bitmap;
      
      private var _countBg:Bitmap;
      
      private var _boxArr:Vector.<FoodActivityBox>;
      
      private var _boxNumTxtArr:Vector.<FilterFrameText>;
      
      private var _sp:Sprite;
      
      private var _progress:Bitmap;
      
      private var _btnBg:ScaleBitmapImage;
      
      private var _simpleBtn:SimpleBitmapButton;
      
      private var _payBtn:SimpleBitmapButton;
      
      private var _ripeTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _boxMc:MovieClip;
      
      private var _getAwardBtn:MovieClip;
      
      private var _defaultLength:int = 11;
      
      private var _defaultRipeNum:int = 60;
      
      private var _giftState:int;
      
      private var _data:GmActivityInfo;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var frame:int;
      
      public function FoodActivityFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc11_:int = 0;
         var _loc6_:* = null;
         var _loc8_:int = 0;
         var _loc1_:* = null;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc10_:* = undefined;
         var _loc4_:* = null;
         var _loc9_:* = null;
         _bg = ComponentFactory.Instance.creat("foodActivity.bg");
         addToContent(_bg);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("foodActivity.helpBtn");
         addToContent(_helpBtn);
         _progress = ComponentFactory.Instance.creat("foodActivity.progress");
         addToContent(_progress);
         _sp = new Sprite();
         _sp.x = _progress.x;
         _sp.y = _progress.y;
         _sp.graphics.beginFill(16777215,0);
         _sp.graphics.drawRect(0,0,_progress.width,_progress.height);
         _sp.graphics.endFill();
         _progress.cacheAsBitmap = true;
         _progress.mask = _sp;
         addToContent(_sp);
         _boxArr = new Vector.<FoodActivityBox>();
         _loc11_ = 0;
         while(_loc11_ < 5)
         {
            _loc6_ = new FoodActivityBox();
            _loc6_.play(1);
            _loc6_.x = 237 + 93 * (_loc11_ - 1);
            _loc6_.y = 110;
            addToContent(_loc6_);
            _boxArr.push(_loc6_);
            _loc11_++;
         }
         _boxNumTxtArr = new Vector.<FilterFrameText>();
         _loc8_ = 0;
         while(_loc8_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("foodActivity.boxNumTxt");
            _loc1_.x = 151 + 93 * _loc8_;
            _loc1_.y = 152;
            addToContent(_loc1_);
            _boxNumTxtArr.push(_loc1_);
            _loc8_++;
         }
         _ripeTxt = ComponentFactory.Instance.creatComponentByStylename("foodActivity.ripeTxt");
         addToContent(_ripeTxt);
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("foodActivity.countTxt");
         addToContent(_countTxt);
         _countBg = ComponentFactory.Instance.creat("foodActivity.countBg");
         addToContent(_countBg);
         _boxMc = ComponentFactory.Instance.creat("foodActivity.box.mc");
         _boxMc.x = 334;
         _boxMc.y = 194;
         _boxMc.gotoAndStop(1);
         addToContent(_boxMc);
         _getAwardBtn = ComponentFactory.Instance.creat("foodActivity.getAward.btn");
         _getAwardBtn.visible = false;
         _getAwardBtn.x = 326;
         _getAwardBtn.y = 205;
         addToContent(_getAwardBtn);
         _btnBg = ComponentFactory.Instance.creatComponentByStylename("foodActivity.buttonBackBg");
         addToContent(_btnBg);
         _simpleBtn = ComponentFactory.Instance.creatComponentByStylename("foodActivity.simpleBtn");
         addToContent(_simpleBtn);
         _payBtn = ComponentFactory.Instance.creatComponentByStylename("foodActivity.payBtn");
         addToContent(_payBtn);
         _data = FoodActivityManager.Instance.info;
         if(!_data)
         {
            return;
         }
         _loc7_ = 0;
         while(_loc7_ < _boxArr.length)
         {
            if(!_boxArr[_loc7_].tipData)
            {
               _loc5_ = "";
               _loc2_ = 0;
               while(_loc2_ < _data.giftbagArray[_loc7_].giftRewardArr.length)
               {
                  _loc3_ = _data.giftbagArray[_loc7_].giftRewardArr[_loc2_];
                  _loc10_ = _data.giftbagArray[_loc7_].giftConditionArr;
                  _loc4_ = ItemManager.Instance.getTemplateById(_loc3_.templateId).Name;
                  _loc5_ = _loc5_ + (_loc4_ + "x" + _loc3_.count + (_loc2_ == _data.giftbagArray[_loc7_].giftRewardArr.length - 1?"":"、\n"));
                  _loc2_++;
               }
               _loc9_ = {};
               _loc9_.content = LanguageMgr.GetTranslation("foodActivity.boxTipTxt",_loc10_[0].conditionValue,_loc10_[1].conditionValue);
               _loc9_.awards = _loc5_;
               _boxArr[_loc7_].tipStyle = "foodActivity.view.FoodActivityTip";
               _boxArr[_loc7_].tipDirctions = "2,1";
               _boxArr[_loc7_].tipData = _loc9_;
            }
            _loc7_++;
         }
         updateProgress();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _simpleBtn.addEventListener("click",__simpleHandler);
         _payBtn.addEventListener("click",__payHandler);
         _boxMc.addEventListener("click",__getAwardHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      protected function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("foodActivity.frame.HelpPrompt" + _data.activityChildType);
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("foodActivity.frame.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(_loc3_,3,true,1);
      }
      
      public function updateProgress() : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:* = 0;
         var _loc8_:* = _boxArr;
         for each(var _loc4_ in _boxArr)
         {
            _loc4_.play(1);
         }
         _giftState = 0;
         var _loc2_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _data.giftbagArray.length)
         {
            _loc2_.push(_data.giftbagArray[_loc6_].giftConditionArr[0].conditionValue);
            _loc6_++;
         }
         var _loc1_:int = _loc2_[4];
         var _loc3_:int = FoodActivityManager.Instance.ripeNum + _defaultRipeNum;
         if(_loc3_ == _defaultRipeNum)
         {
            _sp.width = _defaultLength;
         }
         else if(_loc3_ < _loc1_)
         {
            _loc7_ = 1;
            while(_loc7_ < _loc2_.length)
            {
               if(_loc3_ < _loc2_[_loc7_])
               {
                  _giftState = 1 << _loc7_ - 1;
                  _boxArr[_loc7_ - 1].play(2);
                  _sp.width = _defaultLength + int(93 * ((_loc3_ - _loc2_[_loc7_ - 1]) / (_loc2_[_loc7_] - _loc2_[_loc7_ - 1]) + _loc7_ - 1));
                  break;
               }
               _loc7_++;
            }
         }
         else
         {
            _giftState = 16;
            _boxArr[_boxArr.length - 1].play(2);
            _sp.width = _progress.width;
         }
         _loc9_ = _giftState != 0;
         _getAwardBtn.visible = _loc9_;
         _loc8_ = _loc9_;
         _boxMc.buttonMode = _loc8_;
         _loc9_ = _loc8_;
         _boxMc.mouseChildren = _loc9_;
         _boxMc.mouseEnabled = _loc9_;
         _boxNumTxtArr[0].text = (_loc2_[0] - 1).toString();
         _loc5_ = 1;
         while(_loc5_ < _boxNumTxtArr.length - 1)
         {
            _boxNumTxtArr[_loc5_].text = _loc2_[_loc5_];
            _loc5_++;
         }
         _boxNumTxtArr[4].text = "" + _loc1_;
         _ripeTxt.text = "" + (FoodActivityManager.Instance.ripeNum + _defaultRipeNum);
         _countTxt.text = "" + FoodActivityManager.Instance.cookingCount;
      }
      
      protected function __simpleHandler(param1:MouseEvent) : void
      {
         if(!click())
         {
            return;
         }
         SocketManager.Instance.out.cooking(1);
      }
      
      protected function __payHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!click())
         {
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("foodActivity.perfectCookingTxt",MONEY);
         _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__confirm);
      }
      
      protected function __confirm(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               _loc3_.removeEventListener("response",__confirm);
               ObjectUtils.disposeObject(_loc3_);
               return;
            }
            if(PlayerManager.Instance.Self.Money >= MONEY)
            {
               FoodActivityManager.Instance.ripeNum = _defaultRipeNum;
               SocketManager.Instance.out.cooking(2);
            }
            else
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               _loc2_.addEventListener("response",_response);
               ObjectUtils.disposeObject(_loc3_);
            }
         }
         _loc3_.removeEventListener("response",__confirm);
      }
      
      protected function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function click() : Boolean
      {
         SoundManager.instance.playButtonSound();
         if(FoodActivityManager.Instance.cookingCount <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("foodActivity.noCookingCount"));
            return false;
         }
         if(_giftState != 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("foodActivity.canNotCooking"));
            return false;
         }
         return true;
      }
      
      public function updateBoxMc() : void
      {
         var _loc1_:* = false;
         _getAwardBtn.visible = _loc1_;
         _loc1_ = _loc1_;
         _payBtn.enable = _loc1_;
         _simpleBtn.enable = _loc1_;
         _boxMc.gotoAndStop(2);
         _boxMc.y = 223;
         _boxMc.addEventListener("enterFrame",__enterHandler);
      }
      
      public function failRewardUpdate() : void
      {
         var _loc1_:* = true;
         _boxMc.buttonMode = _loc1_;
         _loc1_ = _loc1_;
         _boxMc.mouseChildren = _loc1_;
         _boxMc.mouseEnabled = _loc1_;
      }
      
      protected function __getAwardHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = false;
         _boxMc.buttonMode = _loc2_;
         _loc2_ = _loc2_;
         _boxMc.mouseChildren = _loc2_;
         _boxMc.mouseEnabled = _loc2_;
         SocketManager.Instance.out.cookingGetAward(_giftState);
      }
      
      protected function __enterHandler(param1:Event) : void
      {
         frame = Number(frame) + 1;
         if(frame >= 120)
         {
            frame = 0;
            var _loc2_:Boolean = true;
            _payBtn.enable = _loc2_;
            _simpleBtn.enable = _loc2_;
            _boxMc.removeEventListener("enterFrame",__enterHandler);
            _boxMc.gotoAndStop(1);
            _boxMc.y = 194;
            updateProgress();
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            FoodActivityControl.Instance.disposeFrame();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _simpleBtn.removeEventListener("click",__simpleHandler);
         _payBtn.removeEventListener("click",__payHandler);
         _boxMc.removeEventListener("click",__getAwardHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         var _loc4_:int = 0;
         var _loc3_:* = _boxArr;
         for each(var _loc2_ in _boxArr)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         _boxArr = null;
         var _loc6_:int = 0;
         var _loc5_:* = _boxNumTxtArr;
         for each(var _loc1_ in _boxNumTxtArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _boxNumTxtArr = null;
         _boxMc.removeEventListener("enterFrame",__enterHandler);
         _boxMc.parent.removeChild(_boxMc);
         _boxMc = null;
         _getAwardBtn.parent.removeChild(_getAwardBtn);
         _getAwardBtn = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_countBg);
         _countBg = null;
         ObjectUtils.disposeObject(_btnBg);
         _btnBg = null;
         ObjectUtils.disposeObject(_simpleBtn);
         _simpleBtn = null;
         ObjectUtils.disposeObject(_payBtn);
         _payBtn = null;
         ObjectUtils.disposeObject(_ripeTxt);
         _ripeTxt = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         _sp.graphics.clear();
         ObjectUtils.disposeObject(_sp);
         _sp = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
   }
}
