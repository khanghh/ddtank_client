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
         var i:int = 0;
         var box:* = null;
         var j:int = 0;
         var boxNumTxt:* = null;
         var bi:int = 0;
         var award:* = null;
         var kii:int = 0;
         var giftInfo:* = null;
         var conditionVec:* = undefined;
         var name:* = null;
         var tip:* = null;
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
         for(i = 0; i < 5; )
         {
            box = new FoodActivityBox();
            box.play(1);
            box.x = 237 + 93 * (i - 1);
            box.y = 110;
            addToContent(box);
            _boxArr.push(box);
            i++;
         }
         _boxNumTxtArr = new Vector.<FilterFrameText>();
         for(j = 0; j < 5; )
         {
            boxNumTxt = ComponentFactory.Instance.creatComponentByStylename("foodActivity.boxNumTxt");
            boxNumTxt.x = 151 + 93 * j;
            boxNumTxt.y = 152;
            addToContent(boxNumTxt);
            _boxNumTxtArr.push(boxNumTxt);
            j++;
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
         bi = 0;
         while(bi < _boxArr.length)
         {
            if(!_boxArr[bi].tipData)
            {
               award = "";
               for(kii = 0; kii < _data.giftbagArray[bi].giftRewardArr.length; )
               {
                  giftInfo = _data.giftbagArray[bi].giftRewardArr[kii];
                  conditionVec = _data.giftbagArray[bi].giftConditionArr;
                  name = ItemManager.Instance.getTemplateById(giftInfo.templateId).Name;
                  award = award + (name + "x" + giftInfo.count + (kii == _data.giftbagArray[bi].giftRewardArr.length - 1?"":"、\n"));
                  kii++;
               }
               tip = {};
               tip.content = LanguageMgr.GetTranslation("foodActivity.boxTipTxt",conditionVec[0].conditionValue,conditionVec[1].conditionValue);
               tip.awards = award;
               _boxArr[bi].tipStyle = "foodActivity.view.FoodActivityTip";
               _boxArr[bi].tipDirctions = "2,1";
               _boxArr[bi].tipData = tip;
            }
            bi++;
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
      
      protected function __helpHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         var helpBd:DisplayObject = ComponentFactory.Instance.creat("foodActivity.frame.HelpPrompt" + _data.activityChildType);
         var helpPage:HelpFrame = ComponentFactory.Instance.creat("foodActivity.frame.HelpFrame");
         helpPage.setView(helpBd);
         helpPage.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(helpPage,3,true,1);
      }
      
      public function updateProgress() : void
      {
         var k:int = 0;
         var i:int = 0;
         var j:int = 0;
         var _loc9_:* = 0;
         var _loc8_:* = _boxArr;
         for each(var box in _boxArr)
         {
            box.play(1);
         }
         _giftState = 0;
         var cookingNumArr:Array = [];
         for(k = 0; k < _data.giftbagArray.length; )
         {
            cookingNumArr.push(_data.giftbagArray[k].giftConditionArr[0].conditionValue);
            k++;
         }
         var max:int = cookingNumArr[4];
         var sum:int = FoodActivityManager.Instance.ripeNum + _defaultRipeNum;
         if(sum == _defaultRipeNum)
         {
            _sp.width = _defaultLength;
         }
         else if(sum < max)
         {
            for(i = 1; i < cookingNumArr.length; )
            {
               if(sum < cookingNumArr[i])
               {
                  _giftState = 1 << i - 1;
                  _boxArr[i - 1].play(2);
                  _sp.width = _defaultLength + int(93 * ((sum - cookingNumArr[i - 1]) / (cookingNumArr[i] - cookingNumArr[i - 1]) + i - 1));
                  break;
               }
               i++;
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
         _boxNumTxtArr[0].text = (cookingNumArr[0] - 1).toString();
         for(j = 1; j < _boxNumTxtArr.length - 1; )
         {
            _boxNumTxtArr[j].text = cookingNumArr[j];
            j++;
         }
         _boxNumTxtArr[4].text = "" + max;
         _ripeTxt.text = "" + (FoodActivityManager.Instance.ripeNum + _defaultRipeNum);
         _countTxt.text = "" + FoodActivityManager.Instance.cookingCount;
      }
      
      protected function __simpleHandler(event:MouseEvent) : void
      {
         if(!click())
         {
            return;
         }
         SocketManager.Instance.out.cooking(1);
      }
      
      protected function __payHandler(event:MouseEvent) : void
      {
         var confirmFrame:* = null;
         if(!click())
         {
            return;
         }
         var msg:String = LanguageMgr.GetTranslation("foodActivity.perfectCookingTxt",MONEY);
         confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__confirm);
      }
      
      protected function __confirm(event:FrameEvent) : void
      {
         var alertFrame:* = null;
         SoundManager.instance.playButtonSound();
         var confirmFrame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               confirmFrame.removeEventListener("response",__confirm);
               ObjectUtils.disposeObject(confirmFrame);
               return;
            }
            if(PlayerManager.Instance.Self.Money >= MONEY)
            {
               FoodActivityManager.Instance.ripeNum = _defaultRipeNum;
               SocketManager.Instance.out.cooking(2);
            }
            else
            {
               alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
               alertFrame.addEventListener("response",_response);
               ObjectUtils.disposeObject(confirmFrame);
            }
         }
         confirmFrame.removeEventListener("response",__confirm);
      }
      
      protected function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
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
      
      protected function __getAwardHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = false;
         _boxMc.buttonMode = _loc2_;
         _loc2_ = _loc2_;
         _boxMc.mouseChildren = _loc2_;
         _boxMc.mouseEnabled = _loc2_;
         SocketManager.Instance.out.cookingGetAward(_giftState);
      }
      
      protected function __enterHandler(event:Event) : void
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
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
         for each(var box in _boxArr)
         {
            ObjectUtils.disposeObject(box);
            box = null;
         }
         _boxArr = null;
         var _loc6_:int = 0;
         var _loc5_:* = _boxNumTxtArr;
         for each(var boxTxt in _boxNumTxtArr)
         {
            ObjectUtils.disposeObject(boxTxt);
            boxTxt = null;
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
