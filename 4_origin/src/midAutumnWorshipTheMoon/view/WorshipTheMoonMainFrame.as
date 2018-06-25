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
         var i:int = 0;
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
         for(i = 0; i < 6; )
         {
            _listShiningMoonList[i] = _animationWorshipTheMoon.getChildByName("mn" + (i + 1).toString());
            _listShiningMoonList[i].visible = false;
            i++;
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
         for(i = 0; i < 12; )
         {
            _listAwardsMaybeGain[i] = new BagCell(0);
            _listAwardsMaybeGain[i].x = 624 + i % 4 * 50;
            _listAwardsMaybeGain[i].y = 80 + int(i / 4) * 50;
            addToContent(_listAwardsMaybeGain[i]);
            i++;
         }
         var bg:Shape = new Shape();
         bg.graphics.beginFill(0,0);
         bg.graphics.drawRect(0,0,70,70);
         bg.graphics.endFill();
         _awardsAfter200times = new ShopItemCell(bg);
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
         var beginDate:String = getDateToString(ServerConfigManager.instance.WorshipMoonBeginDate);
         var endDate:String = getDateToString(ServerConfigManager.instance.WorshipMoonEndDate);
         _ruleDetails.text = LanguageMgr.GetTranslation("worshipTheMoon.Details",beginDate,endDate);
         addToContent(_ruleDetails);
         initEvents();
      }
      
      private function getDateToString(str:String) : String
      {
         var date:Date = DateUtils.getDateByStr(str);
         return LanguageMgr.GetTranslation("tank.calendar.grid.today",date.fullYear,date.month + 1,date.date);
      }
      
      private function initEvents() : void
      {
         this.addEventListener("click",onFrameClick);
         addEventListener("response",_response);
         _awardsAfter200times.addEventListener("click",on200AwardsBoxClick);
      }
      
      protected function on200AwardsBoxClick(me:MouseEvent) : void
      {
         var state:int = _model.canGain200AwardsBox();
         if(state == 2)
         {
            WorshipTheMoonManager.getInstance().requireWorship200AwardBox();
         }
      }
      
      protected function onFrameClick(me:MouseEvent) : void
      {
         var _loc2_:* = me.target;
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
      
      public function showConfirmFrame(times:int) : void
      {
         var showConfirmFrame:Boolean = false;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var needMoneyTimes:int = WorshipTheMoonModel.getInstance().getNeedMoneyTimes(times);
         var moneyNotEnough:* = PlayerManager.Instance.Self.Money < WorshipTheMoonModel.getInstance().getNeedMoney(needMoneyTimes);
         var bindMoneyNotEnough:* = PlayerManager.Instance.Self.BandMoney < WorshipTheMoonModel.getInstance().getNeedMoney(needMoneyTimes);
         var isOnceBindMoney:Boolean = WorshipTheMoonModel.getInstance().getIsOnceBtnUseBindMoney();
         var isTensBindMoney:Boolean = WorshipTheMoonModel.getInstance().getIsTensBtnUseBindMoney();
         if(times == 1)
         {
            if(isOnceBindMoney)
            {
               WorshipTheMoonModel.getInstance().onceBtnShowTipsAgain();
            }
            else if(!isOnceBindMoney && moneyNotEnough)
            {
               WorshipTheMoonModel.getInstance().onceBtnShowTipsAgain();
            }
         }
         else if(isTensBindMoney)
         {
            WorshipTheMoonModel.getInstance().tensBtnShowTipsAgain();
         }
         else if(!isTensBindMoney && moneyNotEnough)
         {
            WorshipTheMoonModel.getInstance().tensBtnShowTipsAgain();
         }
         if(times == 1)
         {
            showConfirmFrame = WorshipTheMoonModel.getInstance().getIsOnceBtnShowBuyTipThisLogin();
         }
         else
         {
            showConfirmFrame = WorshipTheMoonModel.getInstance().getIsTensBtnShowBuyTipThisLogin();
         }
         if(needMoneyTimes <= 0 || !showConfirmFrame)
         {
            disableBtns();
            WorshipTheMoonManager.getInstance().requireWorshipTheMoon(times);
            return;
         }
         confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("worshipTheMoon.thisIsCostMoney",getPrice(),String(times)),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
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
      
      private function __onClickSelectedBtn(e:MouseEvent) : void
      {
         WorshipTheMoonManager.getInstance().showBuyCountFram = _selectBtn.selected;
      }
      
      private function comfirmHandler(event:FrameEvent) : void
      {
         var tmpNeedMoney:int = 0;
         var confirmFrame2:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",comfirmHandler);
         confirmFrame.dispose();
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            tmpNeedMoney = getPrice();
            if(confirmFrame.isBand && PlayerManager.Instance.Self.BandMoney < tmpNeedMoney)
            {
               confirmFrame2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("sevenDouble.game.useSkillNoEnoughReConfirm"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
               confirmFrame2.moveEnable = false;
               confirmFrame2.addEventListener("response",reConfirmHandler,false,0,true);
               return;
            }
            if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money < tmpNeedMoney)
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
               WorshipTheMoonModel.getInstance().updateIsOnceBtnUseBindMoney(confirmFrame.isBand);
            }
            else
            {
               WorshipTheMoonModel.getInstance().updateIsTensBtnUseBindMoney(confirmFrame.isBand);
            }
            WorshipTheMoonManager.getInstance().requireWorshipTheMoon(_timesGoingToWorship);
            _timesGoingToWorship = 0;
         }
         else if(event.responseCode == 4 || event.responseCode == 0 || event.responseCode == 1)
         {
            WorshipTheMoonManager.getInstance().showBuyCountFram = false;
         }
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",comfirmHandler);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function reConfirmHandler(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
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
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",reConfirmHandler);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            needMoney = getPrice();
            if(PlayerManager.Instance.Self.Money < needMoney)
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
         var i:int = 0;
         var idList:Vector.<int> = _model.getItemsCanGainsIDList();
         var len:int = idList.length;
         for(i = 0; i < 12; )
         {
            _listAwardsMaybeGain[i].info = ItemManager.Instance.getTemplateById(idList[i]);
            i++;
         }
      }
      
      public function update200TimesGains() : void
      {
         _awardsAfter200times.info = ItemManager.Instance.getTemplateById(_model.get200TimesGainsID());
         var state:int = _model.canGain200AwardsBox();
         switch(int(state) - 1)
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
      
      protected function timeToLightAll(e:Event) : void
      {
         e = e;
         onComplete = function(obj:DisplayObject):void
         {
            obj.visible = false;
         };
         _animationWorshipTheMoon.removeEventListener("show_result",timeToLightAll);
         var len:int = _listShiningMoonList.length;
         for(var i:int = 0; i < len; )
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
      
      protected function timeToLightTheMoon(e:Event) : void
      {
         e = e;
         onComplete = function():void
         {
            _listShiningMoonList[moonType].visible = false;
            showNotification();
            resetBtns();
         };
         _animationWorshipTheMoon.removeEventListener("show_result",timeToLightTheMoon);
         var len:int = _listShiningMoonList.length;
         var moonType:int = _model.getCurrentMoonType() - 1;
         for(var i:int = 0; i < len; )
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
         var info:* = null;
         var i:int = 0;
         var moonName:* = null;
         var cakeName:* = null;
         var list:Vector.<WorshipTheMoonAwardsBoxInfo> = WorshipTheMoonModel.getInstance().getAwardsGainedBoxInfoList();
         var manager:ItemManager = ItemManager.Instance;
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            moonName = WorshipTheMoonAwardsBoxInfo.getMoonName(list[i].moonType);
            cakeName = WorshipTheMoonAwardsBoxInfo.getCakeName(list[i].moonType);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worshipTheMoon.notification",moonName,cakeName),0,true,3);
            i++;
         }
      }
      
      private function showGainsAwards() : void
      {
         var i:int = 0;
         var j:int = 0;
         var arr:Array = [];
         var list:Vector.<WorshipTheMoonAwardsBoxInfo> = WorshipTheMoonModel.getInstance().getAwardsGainedBoxInfoList();
         var len:int = list.length;
         var manager:ItemManager = ItemManager.Instance;
         for(i = 0; i < len; )
         {
            arr[i] = {
               "info":manager.getTemplateById(list[i].id),
               "count":1
            };
            i++;
         }
         var infos:Array = [];
         for(i = 0; i < len; )
         {
            j = 0;
            while(true)
            {
               if(j >= infos.length)
               {
                  infos.push(arr[i]);
                  break;
               }
               if(arr[i].info.TemplateID == infos[j].info.TemplateID)
               {
                  infos[j].count++;
                  break;
               }
               j++;
            }
            i++;
         }
         BagAndInfoManager.Instance.showPreviewFrame(LanguageMgr.GetTranslation("worshipTheMoon.preview.title"),infos);
      }
      
      override public function dispose() : void
      {
         var len:int = 0;
         var i:int = 0;
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
            len = _animationWorshipTheMoon.numChildren;
            for(i = 0; i < len; )
            {
               if(_animationWorshipTheMoon.getChildAt(i) is MovieClip)
               {
                  (_animationWorshipTheMoon.getChildAt(i) as MovieClip).stop();
               }
               i++;
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
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         WorshipTheMoonManager.getInstance().disposeMainFrame();
      }
      
      public function set model(value:WorshipTheMoonModel) : void
      {
         _model = value;
      }
   }
}
