package midAutumnWorshipTheMoon.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.ItemCellEffectMngr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import midAutumnWorshipTheMoon.WorshipTheMoonManager;
   import midAutumnWorshipTheMoon.i.IWorshipTheMoonMainFrame;
   import midAutumnWorshipTheMoon.model.WorshipTheMoonAwardsBoxInfo;
   import midAutumnWorshipTheMoon.model.WorshipTheMoonModel;
   import road7th.utils.DateUtils;
   import shop.view.ShopItemCell;
   
   public class WorshipTheMoonMainFrame extends Frame implements Disposeable, IWorshipTheMoonMainFrame
   {
       
      
      private var _model:WorshipTheMoonModel;
      
      private var _bg:Bitmap;
      
      private var _animationWorshipTheMoon:MovieClip;
      
      private var _listShiningMoonList:Vector.<DisplayObject>;
      
      private var _buyOnceBtn:SimpleBitmapButton;
      
      private var _buyTenTimesBtn:SimpleBitmapButton;
      
      private var _timesRemainTitle:Bitmap;
      
      private var _timesRemainTxt:FilterFrameText;
      
      private var _listAwardsMaybeGain:Vector.<BagCell>;
      
      private var _coolShiningFor200TimesItem:MovieClip;
      
      private var _awardsAfter200times:ShopItemCell;
      
      private var _gained200:Bitmap;
      
      private var _tipClickToGain200:Bitmap;
      
      private var _timesUsed:FilterFrameText;
      
      private var _ruleDetails:FilterFrameText;
      
      private var _timesGoingToWorship:int = 0;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var confirmFrame:BaseAlerFrame;
      
      public function WorshipTheMoonMainFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc4_:int = 0;
         super.init();
         titleText = LanguageMgr.GetTranslation("worshipTheMoon.main.title");
         _bg = ComponentFactory.Instance.creat("worshipTheMoon.BG");
         addToContent(_bg);
         _animationWorshipTheMoon = ComponentFactory.Instance.creat("worshipTheMoon.mc.shining");
         PositionUtils.setPos(_animationWorshipTheMoon,"worshipTheMoon.pt.animation");
         _animationWorshipTheMoon.mouseChildren = false;
         _animationWorshipTheMoon.mouseEnabled = false;
         _animationWorshipTheMoon.gotoAndStop(_animationWorshipTheMoon.totalFrames);
         addToContent(_animationWorshipTheMoon);
         _listShiningMoonList = new Vector.<DisplayObject>();
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _listShiningMoonList[_loc4_] = _animationWorshipTheMoon.getChildByName("mn" + (_loc4_ + 1).toString());
            _listShiningMoonList[_loc4_].visible = false;
            _loc4_++;
         }
         _buyOnceBtn = ComponentFactory.Instance.creat("worshipTheMoon.btn.buyOnce");
         addToContent(_buyOnceBtn);
         _buyTenTimesBtn = ComponentFactory.Instance.creat("worshipTheMoon.btn.buyTenTimes");
         addToContent(_buyTenTimesBtn);
         _timesRemainTitle = ComponentFactory.Instance.creatBitmap("worshipTheMoon.bm.timesRemainTitle");
         addToContent(_timesRemainTitle);
         _timesRemainTxt = ComponentFactory.Instance.creat("worshipTheMoon.txt.TimesRemain");
         _timesRemainTxt.mouseEnabled = false;
         addToContent(_timesRemainTxt);
         _listAwardsMaybeGain = new Vector.<BagCell>();
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _listAwardsMaybeGain[_loc4_] = new BagCell(0);
            _listAwardsMaybeGain[_loc4_].x = 624 + _loc4_ % 4 * 50;
            _listAwardsMaybeGain[_loc4_].y = 80 + int(_loc4_ / 4) * 50;
            addToContent(_listAwardsMaybeGain[_loc4_]);
            _loc4_++;
         }
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,70,70);
         _loc1_.graphics.endFill();
         _awardsAfter200times = new ShopItemCell(_loc1_);
         PositionUtils.setPos(_awardsAfter200times,"worshipTheMoon.pt.on200");
         _awardsAfter200times.useHandCursor = true;
         _awardsAfter200times.buttonMode = true;
         addToContent(_awardsAfter200times);
         _coolShiningFor200TimesItem = ComponentFactory.Instance.creat("asset.core.icon.coolShining");
         _coolShiningFor200TimesItem = ItemCellEffectMngr.getEffect(_awardsAfter200times,0,101);
         _coolShiningFor200TimesItem.alpha = 0.7;
         addToContent(_coolShiningFor200TimesItem);
         _gained200 = ComponentFactory.Instance.creatBitmap("worship.alreadyGet");
         _tipClickToGain200 = ComponentFactory.Instance.creatBitmap("worshipTheMoon.clickToGain");
         _timesUsed = ComponentFactory.Instance.creat("worshipTheMoon.txt.TimesUsed");
         _timesUsed.mouseEnabled = false;
         addToContent(_timesUsed);
         _ruleDetails = ComponentFactory.Instance.creat("worshipTheMoon.txt.details");
         _ruleDetails.mouseEnabled = false;
         var _loc3_:String = getDateToString(ServerConfigManager.instance.WorshipMoonBeginDate);
         var _loc2_:String = getDateToString(ServerConfigManager.instance.WorshipMoonEndDate);
         _ruleDetails.text = LanguageMgr.GetTranslation("worshipTheMoon.Details",_loc3_,_loc2_);
         addToContent(_ruleDetails);
         initEvents();
      }
      
      private function getDateToString(param1:String) : String
      {
         var _loc2_:Date = DateUtils.getDateByStr(param1);
         return LanguageMgr.GetTranslation("tank.calendar.grid.today",_loc2_.fullYear,_loc2_.month + 1,_loc2_.date);
      }
      
      private function initEvents() : void
      {
         this.addEventListener("click",onFrameClick);
         addEventListener("response",_response);
         _awardsAfter200times.addEventListener("click",on200AwardsBoxClick);
      }
      
      protected function on200AwardsBoxClick(param1:MouseEvent) : void
      {
         var _loc2_:int = _model.canGain200AwardsBox();
         if(_loc2_ == 2)
         {
            WorshipTheMoonManager.getInstance().requireWorship200AwardBox();
         }
      }
      
      protected function onFrameClick(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.target;
         if(_buyOnceBtn !== _loc2_)
         {
            if(_buyTenTimesBtn === _loc2_)
            {
               SoundManager.instance.play("008");
               _timesGoingToWorship = 10;
               showConfirmFrame(_timesGoingToWorship);
            }
         }
         else
         {
            SoundManager.instance.play("008");
            _timesGoingToWorship = 1;
            showConfirmFrame(_timesGoingToWorship);
         }
      }
      
      private function getPrice() : int
      {
         return WorshipTheMoonModel.getInstance().getNeedMoney(_timesGoingToWorship);
      }
      
      public function showConfirmFrame(param1:int) : void
      {
         var _loc7_:Boolean = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = WorshipTheMoonModel.getInstance().getNeedMoneyTimes(param1);
         var _loc4_:* = PlayerManager.Instance.Self.Money < WorshipTheMoonModel.getInstance().getNeedMoney(_loc2_);
         var _loc6_:* = PlayerManager.Instance.Self.BandMoney < WorshipTheMoonModel.getInstance().getNeedMoney(_loc2_);
         var _loc3_:Boolean = WorshipTheMoonModel.getInstance().getIsOnceBtnUseBindMoney();
         var _loc5_:Boolean = WorshipTheMoonModel.getInstance().getIsTensBtnUseBindMoney();
         if(param1 == 1)
         {
            if(_loc3_)
            {
               WorshipTheMoonModel.getInstance().onceBtnShowTipsAgain();
            }
            else if(!_loc3_ && _loc4_)
            {
               WorshipTheMoonModel.getInstance().onceBtnShowTipsAgain();
            }
         }
         else if(_loc5_)
         {
            WorshipTheMoonModel.getInstance().tensBtnShowTipsAgain();
         }
         else if(!_loc5_ && _loc4_)
         {
            WorshipTheMoonModel.getInstance().tensBtnShowTipsAgain();
         }
         if(param1 == 1)
         {
            _loc7_ = WorshipTheMoonModel.getInstance().getIsOnceBtnShowBuyTipThisLogin();
         }
         else
         {
            _loc7_ = WorshipTheMoonModel.getInstance().getIsTensBtnShowBuyTipThisLogin();
         }
         if(_loc2_ <= 0 || !_loc7_)
         {
            disableBtns();
            WorshipTheMoonManager.getInstance().requireWorshipTheMoon(param1);
            return;
         }
         confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worshipTheMoon.thisIsCostMoney",getPrice(),String(param1)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",comfirmHandler,false,0,true);
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
         _selectBtn.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
         _selectBtn.addEventListener("click",__onClickSelectedBtn);
         confirmFrame.addToContent(_selectBtn);
         confirmFrame.height = 200;
         _selectBtn.x = 66;
         _selectBtn.y = 67;
      }
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void
      {
         WorshipTheMoonManager.getInstance().showBuyCountFram = _selectBtn.selected;
      }
      
      private function comfirmHandler(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc4_.removeEventListener("response",comfirmHandler);
         _loc4_.dispose();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc3_ = getPrice();
            if(_loc4_.isBand && PlayerManager.Instance.Self.BandMoney < _loc3_)
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!_loc4_.isBand && PlayerManager.Instance.Self.Money < _loc3_)
            {
               if(_timesGoingToWorship == 1)
               {
                  WorshipTheMoonModel.getInstance().onceBtnNotShowBuyTipsAgainThisLogin(true);
               }
               else
               {
                  WorshipTheMoonModel.getInstance().tensBtnNotShowBuyTipsAgainThisLogin(true);
               }
               LeavePageManager.showFillFrame();
               return;
            }
            if(WorshipTheMoonManager.getInstance().showBuyCountFram)
            {
               if(_timesGoingToWorship == 1)
               {
                  WorshipTheMoonModel.getInstance().onceBtnNotShowBuyTipsAgainThisLogin(true);
               }
               else
               {
                  WorshipTheMoonModel.getInstance().tensBtnNotShowBuyTipsAgainThisLogin(true);
               }
            }
            if(_timesGoingToWorship == 1)
            {
               WorshipTheMoonModel.getInstance().updateIsOnceBtnUseBindMoney(_loc4_.isBand);
            }
            else
            {
               WorshipTheMoonModel.getInstance().updateIsTensBtnUseBindMoney(_loc4_.isBand);
            }
            WorshipTheMoonManager.getInstance().requireWorshipTheMoon(_timesGoingToWorship);
            _timesGoingToWorship = 0;
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            WorshipTheMoonManager.getInstance().showBuyCountFram = false;
         }
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",comfirmHandler);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function reConfirmHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(_timesGoingToWorship == 1)
         {
            WorshipTheMoonModel.getInstance().onceBtnShowTipsAgain();
            WorshipTheMoonModel.getInstance().updateIsOnceBtnUseBindMoney(false);
         }
         else
         {
            WorshipTheMoonModel.getInstance().onceBtnShowTipsAgain();
            WorshipTheMoonModel.getInstance().updateIsTensBtnUseBindMoney(false);
         }
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",reConfirmHandler);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = getPrice();
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            WorshipTheMoonManager.getInstance().requireWorshipTheMoon(_timesGoingToWorship);
            _timesGoingToWorship = 0;
         }
      }
      
      public function updateTimesRemains() : void
      {
         _timesRemainTxt.text = _model.getTimesRemain().toString();
      }
      
      public function updateUsedTimes() : void
      {
         _timesUsed.text = _model.getUsedTimes().toString();
      }
      
      public function updateAwardItemsCanGainList() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<int> = _model.getItemsCanGainsIDList();
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            _listAwardsMaybeGain[_loc3_].info = ItemManager.Instance.getTemplateById(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      public function update200TimesGains() : void
      {
         _awardsAfter200times.info = ItemManager.Instance.getTemplateById(_model.get200TimesGainsID());
         var _loc1_:int = _model.canGain200AwardsBox();
         switch(int(_loc1_) - 1)
         {
            case 0:
               _awardsAfter200times.filters = [];
               _coolShiningFor200TimesItem.play();
               _coolShiningFor200TimesItem.visible = true;
               _tipClickToGain200.parent && _awardsAfter200times.removeChild(_tipClickToGain200);
               _gained200.parent && _awardsAfter200times.removeChild(_gained200);
               break;
            case 1:
               _awardsAfter200times.filters = [];
               _coolShiningFor200TimesItem.play();
               _coolShiningFor200TimesItem.visible = true;
               _awardsAfter200times.addChild(_tipClickToGain200);
               _gained200.parent && _awardsAfter200times.removeChild(_gained200);
         }
      }
      
      public function playTenTimesAnimation() : void
      {
         disableBtns();
         _animationWorshipTheMoon.addEventListener("show_result",timeToLightAll);
         _animationWorshipTheMoon.gotoAndPlay(1);
      }
      
      protected function timeToLightAll(param1:Event) : void
      {
         e = param1;
         onComplete = function(param1:DisplayObject):void
         {
            param1.visible = false;
         };
         _animationWorshipTheMoon.removeEventListener("show_result",timeToLightAll);
         var len:int = _listShiningMoonList.length;
         var i:int = 0;
         while(i < len)
         {
            _listShiningMoonList[i].alpha = 0;
            _listShiningMoonList[i].visible = true;
            var temp:DisplayObject = _listShiningMoonList[i];
            TweenMax.to(_listShiningMoonList[i],0.5,{
               "alpha":1,
               "yoyo":true,
               "repeat":3,
               "onComplete":onComplete,
               "onCompleteParams":[temp]
            });
            i = Number(i) + 1;
         }
      }
      
      public function playOnceAnimation() : void
      {
         disableBtns();
         _animationWorshipTheMoon.addEventListener("show_result",timeToLightTheMoon);
         _animationWorshipTheMoon.gotoAndPlay(1);
      }
      
      protected function timeToLightTheMoon(param1:Event) : void
      {
         e = param1;
         onComplete = function():void
         {
            _listShiningMoonList[moonType].visible = false;
            showNotification();
            resetBtns();
         };
         _animationWorshipTheMoon.removeEventListener("show_result",timeToLightTheMoon);
         var len:int = _listShiningMoonList.length;
         var moonType:int = _model.getCurrentMoonType() - 1;
         var i:int = 0;
         while(i < len)
         {
            _listShiningMoonList[i].visible = false;
            i = Number(i) + 1;
         }
         _listShiningMoonList[moonType].alpha = 0;
         _listShiningMoonList[moonType].visible = true;
         TweenMax.to(_listShiningMoonList[moonType],0.5,{
            "alpha":1,
            "yoyo":true,
            "repeat":3,
            "onComplete":onComplete
         });
      }
      
      private function disableBtns() : void
      {
         escEnable = false;
         _closeButton.enable = false;
         _closeButton.mouseEnabled = false;
         _closeButton.mouseChildren = false;
         _buyOnceBtn.enable = false;
         _buyOnceBtn.mouseEnabled = false;
         _buyOnceBtn.mouseChildren = false;
         _buyTenTimesBtn.enable = false;
         _buyTenTimesBtn.mouseEnabled = false;
         _buyTenTimesBtn.mouseChildren = false;
      }
      
      private function showGainsAwardsAndresetBtns() : void
      {
         showGainsAwards();
         resetBtns();
      }
      
      private function resetBtns() : void
      {
         escEnable = true;
         if(_closeButton != null)
         {
            _closeButton.enable = true;
            _closeButton.mouseChildren = true;
            _closeButton.mouseEnabled = true;
         }
         if(_buyOnceBtn != null)
         {
            _buyOnceBtn.enable = true;
            _buyOnceBtn.mouseEnabled = true;
            _buyOnceBtn.mouseChildren = true;
         }
         if(_buyTenTimesBtn != null)
         {
            _buyTenTimesBtn.enable = true;
            _buyTenTimesBtn.mouseEnabled = true;
            _buyTenTimesBtn.mouseChildren = true;
         }
      }
      
      private function showNotification() : void
      {
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc1_:* = null;
         var _loc3_:Vector.<WorshipTheMoonAwardsBoxInfo> = WorshipTheMoonModel.getInstance().getAwardsGainedBoxInfoList();
         var _loc2_:ItemManager = ItemManager.Instance;
         var _loc4_:int = _loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = WorshipTheMoonAwardsBoxInfo.getMoonName(_loc3_[_loc6_].moonType);
            _loc1_ = WorshipTheMoonAwardsBoxInfo.getCakeName(_loc3_[_loc6_].moonType);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worshipTheMoon.notification",_loc5_,_loc1_),0,true,3);
            _loc6_++;
         }
      }
      
      private function showGainsAwards() : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:Vector.<WorshipTheMoonAwardsBoxInfo> = WorshipTheMoonModel.getInstance().getAwardsGainedBoxInfoList();
         var _loc5_:int = _loc4_.length;
         var _loc2_:ItemManager = ItemManager.Instance;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_[_loc7_] = {
               "info":_loc2_.getTemplateById(_loc4_[_loc7_].id),
               "count":1
            };
            _loc7_++;
         }
         var _loc1_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = 0;
            while(true)
            {
               if(_loc6_ >= _loc1_.length)
               {
                  _loc1_.push(_loc3_[_loc7_]);
                  break;
               }
               if(_loc3_[_loc7_].info.TemplateID == _loc1_[_loc6_].info.TemplateID)
               {
                  _loc1_[_loc6_].count++;
                  break;
               }
               _loc6_++;
            }
            _loc7_++;
         }
         BagAndInfoManager.Instance.showPreviewFrame(LanguageMgr.GetTranslation("worshipTheMoon.preview.title"),_loc1_);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _awardsAfter200times != null && _awardsAfter200times.removeEventListener("click",on200AwardsBoxClick);
         this.removeEventListener("click",onFrameClick);
         removeEventListener("response",_response);
         _animationWorshipTheMoon.removeEventListener("show_result",timeToLightAll);
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         _listShiningMoonList.length = 0;
         _listShiningMoonList = null;
         if(_animationWorshipTheMoon != null)
         {
            _animationWorshipTheMoon.gotoAndStop(1);
            _loc1_ = _animationWorshipTheMoon.numChildren;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(_animationWorshipTheMoon.getChildAt(_loc2_) is MovieClip)
               {
                  (_animationWorshipTheMoon.getChildAt(_loc2_) as MovieClip).stop();
               }
               _loc2_++;
            }
            ObjectUtils.disposeObject(_animationWorshipTheMoon);
            _animationWorshipTheMoon = null;
         }
         if(_listAwardsMaybeGain != null)
         {
            _listAwardsMaybeGain.length = 0;
            _listAwardsMaybeGain = null;
         }
         if(_buyOnceBtn != null)
         {
            ObjectUtils.disposeObject(_buyOnceBtn);
            _buyOnceBtn = null;
         }
         if(_buyTenTimesBtn != null)
         {
            ObjectUtils.disposeObject(_buyTenTimesBtn);
            _buyTenTimesBtn = null;
         }
         if(_timesRemainTitle != null)
         {
            ObjectUtils.disposeObject(_timesRemainTitle);
            _timesRemainTitle = null;
         }
         if(_timesRemainTxt != null)
         {
            ObjectUtils.disposeObject(_timesRemainTxt);
            _timesRemainTxt = null;
         }
         if(_listAwardsMaybeGain != null)
         {
            _listAwardsMaybeGain.length = 0;
            _listAwardsMaybeGain = null;
         }
         if(_awardsAfter200times != null)
         {
            ObjectUtils.disposeObject(_awardsAfter200times);
            _awardsAfter200times = null;
         }
         if(_coolShiningFor200TimesItem != null)
         {
            _coolShiningFor200TimesItem.stop();
            ObjectUtils.disposeObject(_coolShiningFor200TimesItem);
            _coolShiningFor200TimesItem = null;
         }
         if(_gained200 != null)
         {
            ObjectUtils.disposeObject(_gained200);
            _gained200 = null;
         }
         if(_timesUsed != null)
         {
            ObjectUtils.disposeObject(_timesUsed);
            _timesUsed = null;
         }
         if(_ruleDetails != null)
         {
            ObjectUtils.disposeObject(_ruleDetails);
            _ruleDetails = null;
         }
         if(_tipClickToGain200 != null)
         {
            ObjectUtils.disposeObject(_tipClickToGain200);
            _tipClickToGain200 = null;
         }
         if(_closeButton != null)
         {
            ObjectUtils.disposeObject(_closeButton);
            _closeButton = null;
         }
         super.dispose();
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         WorshipTheMoonManager.getInstance().disposeMainFrame();
      }
      
      public function set model(param1:WorshipTheMoonModel) : void
      {
         _model = param1;
      }
   }
}
