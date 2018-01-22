package prayIndiana.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import invite.InviteManager;
   import prayIndiana.PrayIndianaManager;
   import store.HelpFrame;
   
   public class PrayIndianaFrame extends Frame
   {
      
      public static var isFlag:Boolean;
       
      
      private var _BG:Bitmap;
      
      private var _lotteryProTest:Bitmap;
      
      private var _paopao:Bitmap;
      
      private var _paopaoPray:Bitmap;
      
      private var _tweenFrameBG:Bitmap;
      
      private var _lotteryBtn:SimpleBitmapButton;
      
      private var _refreshBtn:SimpleBitmapButton;
      
      private var _prayBtn:SimpleBitmapButton;
      
      private var _perfectPrayBtn:SimpleBitmapButton;
      
      private var _helpText:FilterFrameText;
      
      private var _prayText:FilterFrameText;
      
      private var _paopaoText:FilterFrameText;
      
      private var _probabilityText:FilterFrameText;
      
      private var _paopaoPrayText:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _slide:SlideView;
      
      private var _target:MovieClip;
      
      private var _goodsView:PrayGoodsView;
      
      private var _timerGoods:Timer;
      
      private var _refreshTimer:Timer;
      
      private var _isQuit:Boolean;
      
      private var showStarTime:FilterFrameText;
      
      private var _selectBtn3:SelectedCheckButton;
      
      private var alert3:BaseAlerFrame;
      
      private var _showTimer:Timer;
      
      private var _selectBtn1:SelectedCheckButton;
      
      private var alert1:BaseAlerFrame;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var alert:BaseAlerFrame;
      
      private var _selectBtn2:SelectedCheckButton;
      
      private var alert2:BaseAlerFrame;
      
      private var _goodsIndex:int;
      
      private var indexNum:int;
      
      public function PrayIndianaFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         InviteManager.Instance.enabled = false;
         isFlag = true;
         _BG = ComponentFactory.Instance.creatBitmap("prayIndiana.FrameBG");
         addToContent(_BG);
         _lotteryProTest = ComponentFactory.Instance.creatBitmap("prayIndiana.lotteryProbabilityT");
         addToContent(_lotteryProTest);
         _tweenFrameBG = ComponentFactory.Instance.creatBitmap("prayIndiana.TweenFrameBG");
         addToContent(_tweenFrameBG);
         _lotteryBtn = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.lotteryBtn");
         addToContent(_lotteryBtn);
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.refreshBtn");
         addToContent(_refreshBtn);
         _prayBtn = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.prayBtn");
         addToContent(_prayBtn);
         _perfectPrayBtn = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.perfectPrayBtn");
         addToContent(_perfectPrayBtn);
         _helpBtn = ComponentFactory.Instance.creat("PrayIndianaFrame.helpBtn");
         addToContent(_helpBtn);
         _helpText = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.helpText");
         _helpText.text = LanguageMgr.GetTranslation("Pray.PrayIndianaFrame.helpText",5);
         addToContent(_helpText);
         showStarTime = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.showStarTime");
         showStarTime.text = PrayIndianaManager.Instance.model.gameTimes;
         addToContent(showStarTime);
         _prayText = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.prayText");
         _prayText.text = LanguageMgr.GetTranslation("Pray.PrayIndianaFrame.prayText");
         addToContent(_prayText);
         _probabilityText = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.probabilityText");
         _probabilityText.text = LanguageMgr.GetTranslation("Pray.PrayIndianaFrame.probabilityText",PrayIndianaManager.Instance.model.probabilityNum);
         addToContent(_probabilityText);
         _paopao = ComponentFactory.Instance.creatBitmap("prayIndiana.paopao");
         addToContent(_paopao);
         _paopaoText = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.paopaoText");
         _paopaoText.text = PrayIndianaManager.Instance.model.PrayGoodsCount.toString();
         addToContent(_paopaoText);
         visiblePaopao(int(_paopaoText.text));
         _paopaoPray = ComponentFactory.Instance.creatBitmap("prayIndiana.paopao");
         PositionUtils.setPos(_paopaoPray,"prayIndiana.paopao.pos");
         addToContent(_paopaoPray);
         _paopaoPrayText = ComponentFactory.Instance.creatComponentByStylename("PrayIndianaFrame.paopaoPrayText");
         _paopaoPrayText.text = PrayIndianaManager.Instance.model.UpdateRateCount.toString();
         addToContent(_paopaoPrayText);
         visiblePaopaoPray(int(_paopaoPrayText.text));
         _goodsView = ComponentFactory.Instance.creatCustomObject("PrayIndianaFrame.PrayGoodsView");
         if(PrayIndianaManager.Instance.model.goodsAll != null && PrayIndianaManager.Instance.model.goodsAll.length > 0)
         {
            _goodsView.setInfo(PrayIndianaManager.Instance.model.goodsAll);
         }
         addToContent(_goodsView);
         _slide = ComponentFactory.Instance.creatCustomObject("PrayIndianaFrame.slide");
         _slide.visible = false;
         _slide.slide.gotoAndStop(1);
         addToContent(_slide);
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _helpBtn.addEventListener("click",__onHelpClick);
         _prayBtn.addEventListener("click",__onPrayBtn);
         _lotteryBtn.addEventListener("click",__lotteryBtn);
         _perfectPrayBtn.addEventListener("click",__PerfectPrayBtn);
         _refreshBtn.addEventListener("click",__refreshBtn);
         PrayIndianaManager.Instance.addEventListener("updateGoods",__updateGoods);
         PrayIndianaManager.Instance.addEventListener("prayStart",__prayStart);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _helpBtn.removeEventListener("click",__onHelpClick);
         if(_prayBtn)
         {
            _prayBtn.removeEventListener("click",__onPrayBtn);
         }
         if(_lotteryBtn)
         {
            _lotteryBtn.removeEventListener("click",__lotteryBtn);
         }
         removeEventListener("keyDown",__onKeyDownHander);
         if(_perfectPrayBtn)
         {
            _perfectPrayBtn.removeEventListener("click",__PerfectPrayBtn);
         }
         if(_refreshBtn)
         {
            _refreshBtn.removeEventListener("click",__refreshBtn);
         }
         PrayIndianaManager.Instance.removeEventListener("updateGoods",__updateGoods);
         PrayIndianaManager.Instance.removeEventListener("prayStart",__prayStart);
      }
      
      private function __refreshBtn(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = PrayIndianaManager.Instance.model.prayInfo[4];
         if(PrayIndianaManager.Instance.showBuyCountFram3)
         {
            _loc2_ = LanguageMgr.GetTranslation("horseRace.match.buyCountDescription",_loc3_);
            alert3 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _selectBtn3 = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn3.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn3.addEventListener("click",__onClickRefreshSelectedBtn);
            alert3.addToContent(_selectBtn3);
            alert3.moveEnable = false;
            alert3.addEventListener("response",__onRecoverRefreshResponse);
            alert3.height = 200;
            _selectBtn3.x = 102;
            _selectBtn3.y = 67;
         }
         else
         {
            if(PlayerManager.Instance.Self.Money < _loc3_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.prayIndianaGoodsRefresh();
         }
      }
      
      private function __updateGoods(param1:Event) : void
      {
         enableBtnToFalse();
         _refreshTimer = new Timer(100,5);
         _refreshTimer.addEventListener("timer",__refreshTimerHandler);
         _refreshTimer.addEventListener("timerComplete",__refreshComplete);
         _refreshTimer.start();
      }
      
      private function __refreshTimerHandler(param1:TimerEvent) : void
      {
         _goodsView.goodsItemSprite.alpha = _goodsView.goodsItemSprite.alpha - 0.2;
         if(_goodsView.goodsItemSprite.alpha <= 0)
         {
            _goodsView.goodsItemSprite.alpha = 0;
         }
      }
      
      private function __refreshComplete(param1:TimerEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         if(_refreshTimer)
         {
            _refreshTimer.removeEventListener("timer",__showGoodsTimer);
            _refreshTimer.stop();
            _refreshTimer = null;
         }
         var _loc4_:Array = PrayIndianaManager.Instance.model.goodsAll;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _goodsView.cellArr[_loc6_].info = null;
            _goodsView.cellArr[_loc6_].filters = null;
            _goodsView.cellArr[_loc6_].alpha = 1;
            _loc5_ = ItemManager.Instance.getTemplateById(_loc4_[_loc6_].TemplateID) as ItemTemplateInfo;
            _loc3_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc3_,_loc5_);
            _loc3_.ValidDate = _loc4_[_loc6_].ValidDate;
            _loc3_.StrengthenLevel = _loc4_[_loc6_].StrengthLevel;
            _loc3_.AttackCompose = _loc4_[_loc6_].AttackCompose;
            _loc3_.DefendCompose = _loc4_[_loc6_].DefendCompose;
            _loc3_.LuckCompose = _loc4_[_loc6_].LuckCompose;
            _loc3_.AgilityCompose = _loc4_[_loc6_].AgilityCompose;
            _loc3_.IsBinds = _loc4_[_loc6_].IsBind;
            _loc3_.Count = _loc4_[_loc6_].Count;
            _loc3_.Place = _loc4_[_loc6_].Position;
            _loc3_.exaltLevel = _loc4_[_loc6_].Quality;
            _goodsView.cellArr[_loc6_].info = _loc3_;
            _loc2_ = _goodsView.cellArr[_loc6_].info.exaltLevel < 5?1:2;
            _goodsView.goodItemContainerAll[_loc6_].gotoAndStop(_loc2_);
            _loc6_++;
         }
         _goodsView.goodsItemSprite.alpha = 0;
         _showTimer = new Timer(100,5);
         _showTimer.addEventListener("timer",__showGoodsTimer);
         _showTimer.start();
      }
      
      private function __showGoodsTimer(param1:TimerEvent) : void
      {
         _goodsView.goodsItemSprite.alpha = _goodsView.goodsItemSprite.alpha + 0.3;
         if(_goodsView.goodsItemSprite.alpha >= 1)
         {
            _goodsView.goodsItemSprite.alpha = 1;
            enableBtnToTrue();
            if(_showTimer)
            {
               _isQuit = false;
               _showTimer.removeEventListener("timer",__showGoodsTimer);
               _showTimer.stop();
               _showTimer = null;
            }
         }
      }
      
      private function __onClickRefreshSelectedBtn(param1:MouseEvent) : void
      {
         PrayIndianaManager.Instance.showBuyCountFram3 = !_selectBtn3.selected;
      }
      
      private function __onRecoverRefreshResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = PrayIndianaManager.Instance.model.prayInfo[4];
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.prayIndianaGoodsRefresh();
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            PrayIndianaManager.Instance.showBuyCountFram3 = true;
         }
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__onRecoverRefreshResponse);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickRefreshSelectedBtn);
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function __onKeyDownHander(param1:KeyboardEvent) : void
      {
         var _loc2_:Number = NaN;
         if(param1.keyCode == 32)
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            _slide.slide.gotoAndStop(_slide.slide.currentFrame);
            _loc2_ = updateSlide();
            SocketManager.Instance.out.prayIndianaPray(2,_slide.x + 14,_target.x + 4.5,_loc2_);
            enableBtnToTrue();
            _isQuit = false;
         }
      }
      
      private function __onPrayBtn(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = PrayIndianaManager.Instance.model.prayInfo[3];
         if(PrayIndianaManager.Instance.model.UpdateRateCount > 0)
         {
            SocketManager.Instance.out.prayIndianaPray(1);
         }
         else if(PrayIndianaManager.Instance.showBuyCountFram1)
         {
            _loc2_ = LanguageMgr.GetTranslation("PrayIndianaFrame.PrayTip",_loc3_);
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _selectBtn1 = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn1.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn1.addEventListener("click",__onClickPraySelectedBtn);
            alert1.addToContent(_selectBtn1);
            alert1.moveEnable = false;
            alert1.addEventListener("response",__onRecoverPrayResponse);
            alert1.height = 200;
            _selectBtn1.x = 102;
            _selectBtn1.y = 67;
         }
         else
         {
            if(PlayerManager.Instance.Self.Money < _loc3_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.prayIndianaPray(1);
         }
      }
      
      private function __prayStart(param1:Event) : void
      {
         _isQuit = true;
         stage.focus = this;
         if(!this.hasEventListener("keyDown"))
         {
            addEventListener("keyDown",__onKeyDownHander);
         }
         showSlide();
         enableBtnToFalse();
         _slide.slide.gotoAndPlay(1);
         _slide.visible = true;
      }
      
      private function updateSlide() : Number
      {
         var _loc1_:int = _slide.slide.currentFrame;
         var _loc2_:* = 0;
         if(_loc1_ <= 25)
         {
            _loc2_ = Number((_loc1_ - 1) * 13.375);
            return _loc2_;
         }
         _loc1_ = 49 - _loc1_ + 1;
         _loc2_ = Number((_loc1_ - 1) * 13.375);
         return _loc2_;
      }
      
      private function __PerfectPrayBtn(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = PrayIndianaManager.Instance.model.prayInfo[5];
         if(this.hasEventListener("keyDown"))
         {
            removeEventListener("keyDown",__onKeyDownHander);
         }
         if(PrayIndianaManager.Instance.showBuyCountFram)
         {
            _loc2_ = LanguageMgr.GetTranslation("PrayIndianaFrame.PerfectPrayTip",_loc3_);
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn.addEventListener("click",__onClickSelectedBtn);
            alert.addToContent(_selectBtn);
            alert.moveEnable = false;
            alert.addEventListener("response",__onRecoverResponse);
            alert.height = 200;
            _selectBtn.x = 102;
            _selectBtn.y = 67;
         }
         else
         {
            if(PlayerManager.Instance.Self.Money < _loc3_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if(_slide != null)
            {
               _slide.visible = false;
            }
            if(_target != null)
            {
               ObjectUtils.disposeObject(_target);
               _target = null;
            }
            SocketManager.Instance.out.prayIndianaPray(3);
         }
      }
      
      private function __onClickSelectedBtn(param1:MouseEvent) : void
      {
         PrayIndianaManager.Instance.showBuyCountFram = !_selectBtn.selected;
      }
      
      private function __onClickPraySelectedBtn(param1:MouseEvent) : void
      {
         PrayIndianaManager.Instance.showBuyCountFram1 = !_selectBtn1.selected;
      }
      
      private function __onRecoverResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = PrayIndianaManager.Instance.model.prayInfo[5];
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            if(_slide != null)
            {
               _slide.visible = false;
            }
            if(_target != null)
            {
               ObjectUtils.disposeObject(_target);
               _target = null;
            }
            SocketManager.Instance.out.prayIndianaPray(3);
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            PrayIndianaManager.Instance.showBuyCountFram = true;
         }
         if(_selectBtn != null)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
            _selectBtn.dispose();
            _selectBtn = null;
         }
         if(alert != null)
         {
            alert.removeEventListener("response",__onRecoverResponse);
            alert.dispose();
            alert = null;
         }
      }
      
      private function __onRecoverPrayResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = PrayIndianaManager.Instance.model.prayInfo[3];
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.prayIndianaPray(1);
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            PrayIndianaManager.Instance.showBuyCountFram1 = true;
         }
         if(_selectBtn1 != null)
         {
            _selectBtn1.removeEventListener("click",__onClickPraySelectedBtn);
            _selectBtn1.dispose();
            _selectBtn1 = null;
         }
         if(alert1 != null)
         {
            alert1.removeEventListener("response",__onRecoverPrayResponse);
            alert1.dispose();
            alert1 = null;
         }
         if(this.hasEventListener("keyDown"))
         {
            removeEventListener("keyDown",__onKeyDownHander);
         }
      }
      
      private function showSlide() : void
      {
         _slide.visible = true;
         showTarget();
      }
      
      private function __lotteryBtn(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(this.hasEventListener("keyDown"))
         {
            removeEventListener("keyDown",__onKeyDownHander);
         }
         var _loc3_:int = PrayIndianaManager.Instance.model.prayInfo[2];
         if(PrayIndianaManager.Instance.model.PrayGoodsCount > 0 && PrayIndianaManager.Instance.model.PrayLotteryGoodsCount > 0)
         {
            SocketManager.Instance.out.prayIndianaLottery();
         }
         else if(PrayIndianaManager.Instance.model.PrayLotteryGoodsCount > 0)
         {
            if(PrayIndianaManager.Instance.showBuyCountFram2)
            {
               _loc2_ = LanguageMgr.GetTranslation("horseRace.match.buyCountDescription",_loc3_);
               alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _selectBtn2 = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
               _selectBtn2.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
               _selectBtn2.addEventListener("click",__onClickLotterySelectedBtn);
               alert2.addToContent(_selectBtn2);
               alert2.moveEnable = false;
               alert2.addEventListener("response",__onRecoverLotteryResponse);
               alert2.height = 200;
               _selectBtn2.x = 102;
               _selectBtn2.y = 67;
            }
            else
            {
               if(PlayerManager.Instance.Self.Money < _loc3_)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               SocketManager.Instance.out.prayIndianaLottery();
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("PrayIndianaFrame.LotteryNoNumberTip"));
         }
      }
      
      public function goodsJump() : void
      {
         if(_slide != null)
         {
            _slide.visible = false;
         }
         if(_target != null)
         {
            ObjectUtils.disposeObject(_target);
            _target = null;
         }
         enableBtnToFalse();
         _timerGoods = new Timer(400,10);
         _timerGoods.addEventListener("timer",__goodsTimerHandler);
         _timerGoods.addEventListener("timerComplete",__goodsTimerComplete);
         _timerGoods.start();
      }
      
      private function __goodsTimerHandler(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         indexNum = Math.random() * 28;
         var _loc2_:Array = PrayIndianaManager.Instance.model.getGoods;
         if(_loc2_.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(int(_loc2_[_loc3_]) == indexNum)
               {
                  indexNum = Math.random() * 28;
               }
               _loc3_++;
            }
         }
         if(indexNum == _goodsIndex)
         {
            indexNum = Math.random() * 28;
         }
         _goodsIndex = indexNum;
         _goodsView.goodItemContainerAll[indexNum].gotoAndStop(3);
      }
      
      private function goodsTimerComplete(param1:int) : void
      {
         var _loc2_:int = _goodsView.cellArr[param1].info.exaltLevel < 5?1:2;
         _goodsView.goodItemContainerAll[param1].gotoAndStop(_loc2_);
      }
      
      private function __goodsTimerComplete(param1:TimerEvent) : void
      {
      }
      
      private function showGoodsItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = _goodsView.cellArr;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].info.TemplateID == PrayIndianaManager.Instance.model.templateID && _loc1_[_loc2_].info.Place == PrayIndianaManager.Instance.model.position)
            {
               PrayIndianaManager.Instance.model.getGoods.push(_loc2_);
               _goodsView.goodItemContainerAll[_loc2_].gotoAndStop(3);
               _goodsView.cellArr[_loc2_].filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _goodsView.cellArr[_loc2_].alpha = 0.4;
               enableBtnToTrue();
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("PrayIndianaFrame.GetGoodsTip",_loc1_[_loc2_].info.Name));
               return;
               §§push(setTimeout(showLotteryGoods,1000,_loc2_));
            }
            else
            {
               _loc2_++;
               continue;
            }
         }
      }
      
      private function showLotteryGoods(param1:int) : void
      {
         var _loc2_:int = _goodsView.cellArr[param1].info.exaltLevel < 5?1:2;
         _goodsView.goodItemContainerAll[param1].gotoAndStop(_loc2_);
         updateLotteryNumber();
      }
      
      private function __onClickLotterySelectedBtn(param1:MouseEvent) : void
      {
         PrayIndianaManager.Instance.showBuyCountFram2 = !_selectBtn2.selected;
      }
      
      private function __onRecoverLotteryResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _loc2_ = PrayIndianaManager.Instance.model.prayInfo[2];
            if(PlayerManager.Instance.Self.Money < _loc2_)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            SocketManager.Instance.out.prayIndianaLottery();
         }
         else if(param1.responseCode == 4 || param1.responseCode == 0 || param1.responseCode == 1)
         {
            PrayIndianaManager.Instance.showBuyCountFram2 = true;
         }
         if(_selectBtn2 != null)
         {
            _selectBtn2.removeEventListener("click",__onClickLotterySelectedBtn);
            _selectBtn2.dispose();
            _selectBtn2 = null;
         }
         if(alert2 != null)
         {
            alert2.removeEventListener("response",__onRecoverLotteryResponse);
            alert2.dispose();
            alert2 = null;
         }
      }
      
      protected function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("PrayIndianaFrame.HelpPrompt");
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("PrayIndianaFrame.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
         LayerManager.Instance.addToLayer(_loc3_,1,true,1);
      }
      
      private function enableBtnToFalse() : void
      {
         _isQuit = true;
         if(_prayBtn)
         {
            var _loc1_:* = false;
            _prayBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _prayBtn.mouseEnabled = _loc1_;
            _prayBtn.enable = _loc1_;
         }
         if(_perfectPrayBtn)
         {
            _loc1_ = false;
            _perfectPrayBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _perfectPrayBtn.mouseEnabled = _loc1_;
            _perfectPrayBtn.enable = _loc1_;
         }
         if(_lotteryBtn)
         {
            _loc1_ = false;
            _lotteryBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _lotteryBtn.mouseEnabled = _loc1_;
            _lotteryBtn.enable = _loc1_;
         }
         if(_refreshBtn)
         {
            _loc1_ = false;
            _refreshBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _refreshBtn.mouseEnabled = _loc1_;
            _refreshBtn.enable = _loc1_;
         }
      }
      
      private function enableBtnToTrue() : void
      {
         _isQuit = false;
         if(_prayBtn)
         {
            var _loc1_:* = true;
            _prayBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _prayBtn.mouseEnabled = _loc1_;
            _prayBtn.enable = _loc1_;
         }
         if(_perfectPrayBtn)
         {
            _loc1_ = true;
            _perfectPrayBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _perfectPrayBtn.mouseEnabled = _loc1_;
            _perfectPrayBtn.enable = _loc1_;
         }
         if(_lotteryBtn)
         {
            _loc1_ = true;
            _lotteryBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _lotteryBtn.mouseEnabled = _loc1_;
            _lotteryBtn.enable = _loc1_;
         }
         if(_refreshBtn)
         {
            _loc1_ = true;
            _refreshBtn.mouseChildren = _loc1_;
            _loc1_ = _loc1_;
            _refreshBtn.mouseEnabled = _loc1_;
            _refreshBtn.enable = _loc1_;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(_isQuit)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("PrayIndianaFrame.ExitNo"));
         }
         else if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            _isQuit = false;
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      public function updateLotteryNumber() : void
      {
         _paopaoText.text = PrayIndianaManager.Instance.model.PrayGoodsCount.toString();
         visiblePaopao(int(_paopaoText.text));
         _paopaoPrayText.text = PrayIndianaManager.Instance.model.UpdateRateCount.toString();
         visiblePaopaoPray(int(_paopaoPrayText.text));
         _probabilityText.text = LanguageMgr.GetTranslation("Pray.PrayIndianaFrame.probabilityText",PrayIndianaManager.Instance.model.probabilityNum.toString());
      }
      
      private function visiblePaopao(param1:int) : void
      {
         if(param1 >= 1)
         {
            _paopaoText.visible = true;
            _paopao.visible = true;
         }
         else
         {
            _paopaoText.visible = false;
            _paopao.visible = false;
         }
      }
      
      private function visiblePaopaoPray(param1:int) : void
      {
         if(param1 >= 1)
         {
            _paopaoPrayText.visible = true;
            _paopaoPray.visible = true;
         }
         else
         {
            _paopaoPrayText.visible = false;
            _paopaoPray.visible = false;
         }
      }
      
      private function showTarget() : void
      {
         if(_target)
         {
            ObjectUtils.disposeObject(_target);
            _target = null;
         }
         _target = ComponentFactory.Instance.creat("prayIndiana.target");
         var _loc1_:Number = Math.random() * 295;
         _target.x = _loc1_ < 85?85:Number(_loc1_);
         _target.y = 420;
         addToContent(_target);
      }
      
      override public function dispose() : void
      {
         isFlag = false;
         InviteManager.Instance.enabled = true;
         removeEvent();
         if(_lotteryBtn)
         {
            ObjectUtils.disposeObject(_lotteryBtn);
         }
         _lotteryBtn = null;
         if(_refreshBtn)
         {
            ObjectUtils.disposeObject(_refreshBtn);
         }
         _refreshBtn = null;
         if(_prayBtn)
         {
            ObjectUtils.disposeObject(_prayBtn);
         }
         _prayBtn = null;
         if(_perfectPrayBtn)
         {
            ObjectUtils.disposeObject(_perfectPrayBtn);
         }
         _perfectPrayBtn = null;
         if(_timerGoods)
         {
            ObjectUtils.disposeObject(_timerGoods);
         }
         _timerGoods = null;
         if(_slide)
         {
            _slide.dispose();
            ObjectUtils.disposeObject(_slide);
            _slide = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
