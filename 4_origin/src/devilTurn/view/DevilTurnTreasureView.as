package devilTurn.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import devilTurn.DevilTurnManager;
   import devilTurn.event.DevilTurnEvent;
   import devilTurn.model.DevilTurnBoxItem;
   import devilTurn.model.DevilTurnModel;
   import devilTurn.model.DevilTurnRankInfo;
   import devilTurn.model.DevilTurnRankRewardItem;
   import devilTurn.view.mornui.DevilTurnTreasureViewUI;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import morn.core.components.Box;
   import morn.core.components.Label;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   
   public class DevilTurnTreasureView extends DevilTurnTreasureViewUI
   {
      
      private static var _buyConfirmAlertData:ConfirmAlertData = new ConfirmAlertData();
       
      
      private var _model:DevilTurnModel;
      
      private var _lotteryView:DevilTurnLotteryView;
      
      private var _totalFreeLotteryTimes:int;
      
      private var _timer:Timer;
      
      private var _currentTime:int;
      
      private var _jackpotTimer:Timer;
      
      private var _type:int;
      
      public function DevilTurnTreasureView()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         _model = DevilTurnManager.instance.model;
         _totalFreeLotteryTimes = ServerConfigManager.instance.devilTurnFreeLotteryCount;
         _timer = new Timer(1000);
         _timer.stop();
         _jackpotTimer = new Timer(60000);
         _jackpotTimer.stop();
         super.preinitialize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         boxConversionBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label9");
         shopBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label10");
         continueCheckBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label11");
         text12.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label12");
         text13.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label13");
         text14.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label14");
         text15.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label15");
         text16.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label16");
         _lotteryView = new DevilTurnLotteryView(this);
         addChild(_lotteryView);
         PositionUtils.setPos(_lotteryView,"devilTurn.lotteryViewPos");
         activateTimeText.text = LanguageMgr.GetTranslation("tank.devilTurn.activateDate",_model.activityDate);
         continueCheckBtn.clickHandler = new Handler(onContinuousClick);
         sacrificeBtn1.clickHandler = new Handler(onClickSacrifice,[1]);
         sacrificeBtn2.clickHandler = new Handler(onClickSacrifice,[10]);
         shopBtn.clickHandler = new Handler(onOpenShopView);
         boxConversionBtn.clickHandler = new Handler(onOpenBoxConversionView);
         rankTab.selectHandler = new Handler(onClickSelectRankList);
         rankTab.selectedIndex = 0;
         boxList.renderHandler = new Handler(onRenderBoxConver);
         boxList.array = _model.boxConverList;
         rankList.renderHandler = new Handler(onRenderRankList);
         rankList.array = _model.rankList;
         rankAwardList.renderHandler = new Handler(onRenderRankAwardList);
         rankAwardList.array = _model.rankAwardList;
         updateViewInfo();
         var _loc1_:GoodTipInfo = new GoodTipInfo();
         _loc1_.itemInfo = ItemManager.Instance.getTemplateById(EquipType.DEVIL_TURN_BEADLIST[0]);
         beadTips1.tipData = _loc1_;
         var _loc5_:GoodTipInfo = new GoodTipInfo();
         _loc5_.itemInfo = ItemManager.Instance.getTemplateById(EquipType.DEVIL_TURN_BEADLIST[1]);
         beadTips2.tipData = _loc5_;
         var _loc4_:GoodTipInfo = new GoodTipInfo();
         _loc4_.itemInfo = ItemManager.Instance.getTemplateById(EquipType.DEVIL_TURN_BEADLIST[2]);
         beadTips3.tipData = _loc4_;
         var _loc3_:GoodTipInfo = new GoodTipInfo();
         _loc3_.itemInfo = ItemManager.Instance.getTemplateById(EquipType.DEVIL_TURN_BEADLIST[3]);
         beadTips4.tipData = _loc3_;
         var _loc2_:GoodTipInfo = new GoodTipInfo();
         _loc2_.itemInfo = ItemManager.Instance.getTemplateById(EquipType.DEVIL_TURN_BEADLIST[4]);
         beadTips5.tipData = _loc2_;
         scoreRankText.text = _model.myRank.toString();
         __onUpdateJackpot(null);
         DevilTurnManager.instance.addEventListener("updateinfo",__onUpdateInfo);
         DevilTurnManager.instance.addEventListener("updateranklist",__onUpdateRankInfo);
         DevilTurnManager.instance.addEventListener("updatejackpot",__onUpdateJackpot);
         DevilTurnManager.instance.addEventListener("updateActivityState",__onUpdateActivityState);
         _timer.addEventListener("timer",__onTimer);
         _jackpotTimer.addEventListener("timer",_onJackpotTimer);
         if(DevilTurnManager.instance.activityState == 1)
         {
            _jackpotTimer.start();
         }
      }
      
      private function onContinuousClick() : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __onUpdateActivityState(param1:DevilTurnEvent) : void
      {
         if(DevilTurnManager.instance.activityState != 1)
         {
            _jackpotTimer.stop();
            _onJackpotTimer(null);
         }
      }
      
      private function _onJackpotTimer(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.sendDevilTurnUpdateJackpot();
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = _model.freeDate - TimeManager.Instance.NowTime() / 1000;
         if(_loc2_ >= 0 && _model.freeTimes > 0)
         {
            _loc3_ = DateUtils.shorTimeRemainArr(_loc2_);
            _loc4_ = _loc3_[1] + ":" + _loc3_[2];
            freeDateText.text = LanguageMgr.GetTranslation("tank.devilTurn.freeSacrificeTips",_loc4_,_model.freeTimes,_totalFreeLotteryTimes);
         }
         else
         {
            _timer.stop();
            updateViewInfo();
         }
      }
      
      private function updateViewInfo() : void
      {
         beadCountText1.text = _model.beadCount1.toString();
         beadCountText2.text = _model.beadCount2.toString();
         beadCountText3.text = _model.beadCount3.toString();
         beadCountText4.text = _model.beadCount4.toString();
         beadCountText5.text = _model.beadCount5.toString();
         scoreText.text = _model.myRankScore.toString();
         if(_model.freeDate < TimeManager.Instance.NowTime() / 1000 && _model.freeTimes > 0)
         {
            freeCountText.text = LanguageMgr.GetTranslation("tank.devilTurn.freeSacrifice");
            _timer.stop();
            freeDateText.text = "";
         }
         else
         {
            freeCountText.text = LanguageMgr.GetTranslation("tank.devilTurn.sacrifice");
            if(_model.freeTimes <= 0)
            {
               _timer.stop();
               freeDateText.text = LanguageMgr.GetTranslation("tank.devilTurn.notFreeSacrificeTips");
            }
            else
            {
               __onTimer(null);
               if(!_timer.running)
               {
                  _timer.start();
               }
            }
         }
      }
      
      private function __onUpdateInfo(param1:DevilTurnEvent) : void
      {
         updateViewInfo();
      }
      
      private function __onUpdateRankInfo(param1:DevilTurnEvent) : void
      {
         rankList.array = _model.rankList;
         scoreRankText.text = _model.myRank.toString();
      }
      
      private function __onUpdateJackpot(param1:DevilTurnEvent) : void
      {
         jackpot.count = int(_model.jackpot);
         jackpotMovie.index = int(_model.jackpot / _model.totalJackpot * 100) - 1;
      }
      
      private function onRenderBoxConver(param1:Box, param2:int) : void
      {
         var _loc3_:DevilTurnBox = param1 as DevilTurnBox;
         if(param2 < boxList.array.length)
         {
            _loc3_.info = boxList.array[param2] as DevilTurnBoxItem;
         }
         else
         {
            _loc3_.info = null;
         }
      }
      
      private function onRenderRankList(param1:Box, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc3_:Label = param1.getChildByName("rank") as Label;
         var _loc4_:Label = param1.getChildByName("name") as Label;
         var _loc5_:Label = param1.getChildByName("score") as Label;
         if(param2 < rankList.array.length)
         {
            _loc6_ = rankList.array[param2] as DevilTurnRankInfo;
            _loc3_.text = _loc6_.rank.toString();
            _loc4_.text = _loc6_.name;
            param1.tipData = _loc6_.area;
            var _loc7_:* = true;
            param1.mouseChildren = _loc7_;
            param1.mouseEnabled = _loc7_;
            _loc5_.text = _loc6_.score.toString();
         }
         else
         {
            _loc7_ = "";
            _loc5_.text = _loc7_;
            _loc7_ = _loc7_;
            _loc4_.text = _loc7_;
            _loc3_.text = _loc7_;
            _loc7_ = false;
            param1.mouseChildren = _loc7_;
            param1.mouseEnabled = _loc7_;
            param1.tipData = null;
         }
      }
      
      private function onRenderRankAwardList(param1:Box, param2:int) : void
      {
         var _loc5_:* = null;
         var _loc3_:Label = param1.getChildByName("rank") as Label;
         var _loc4_:Label = param1.getChildByName("score") as Label;
         if(param2 < rankAwardList.array.length)
         {
            _loc5_ = rankAwardList.array[param2] as DevilTurnRankRewardItem;
            _loc3_.text = _loc5_.rank;
            var _loc6_:* = _loc5_.Desc;
            _loc4_.text = _loc6_;
            param1.tipData = _loc6_;
         }
         else
         {
            _loc6_ = "";
            _loc4_.text = _loc6_;
            _loc3_.text = _loc6_;
         }
      }
      
      private function onOpenShopView() : void
      {
         if(_lotteryView.isRunning)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.lotteryRunning"));
            return;
         }
         SocketManager.Instance.out.sendPersonalLimitShop(19);
         var _loc1_:DevilTurnShopView = new DevilTurnShopView();
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      private function onOpenBoxConversionView() : void
      {
         SoundManager.instance.playButtonSound();
         if(_lotteryView.isRunning)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.lotteryRunning"));
            return;
         }
         var _loc1_:DevilTurnBoxConvertView = new DevilTurnBoxConvertView();
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      private function onClickSelectRankList(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         rankBg.index = param1;
         rankList.visible = param1 == 0;
         rankAwardList.visible = param1 == 1;
      }
      
      private function onClickSacrifice(param1:int) : void
      {
         type = param1;
         onUsePropConfirm = function(param1:BaseAlerFrame):void
         {
            _buyConfirmAlertData.notShowAlertAgain = param1["isNoPrompt"];
         };
         onUsePropCheckOut = function():void
         {
            _buyConfirmAlertData.isBind = CheckMoneyUtils.instance.isBind;
            if(DevilTurnManager.instance.activityState == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
               return;
            }
            if(DevilTurnManager.instance.activityState == 2)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityOver"));
               return;
            }
            SocketManager.Instance.out.sendDevilTurnSacrifice(false,type == 1?1:2,CheckMoneyUtils.instance.isBind);
         };
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(getTimer() - _currentTime < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _currentTime = getTimer();
         if(_lotteryView.isRunning)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.lotteryRunning"));
            return;
         }
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         if(DevilTurnManager.instance.activityState == 2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityOver"));
            return;
         }
         _type = type;
         if(type == 1)
         {
            if(_model.freeDate < TimeManager.Instance.NowTime() / 1000 && _model.freeTimes > 0)
            {
               SocketManager.Instance.out.sendDevilTurnSacrifice(true,1);
               return;
            }
            _buyConfirmAlertData.moneyNeeded = ServerConfigManager.instance.devilTurnLotteryOneCost;
         }
         else if(type == 10)
         {
            _buyConfirmAlertData.moneyNeeded = ServerConfigManager.instance.devilTurnLotteryTenCost;
         }
         if(_buyConfirmAlertData.notShowAlertAgain)
         {
            CheckMoneyUtils.instance.checkMoney(_buyConfirmAlertData.isBind,_buyConfirmAlertData.moneyNeeded,onUsePropCheckOut);
         }
         else
         {
            var msg:String = LanguageMgr.GetTranslation("tank.devilTurn.lotteryTips",_buyConfirmAlertData.moneyNeeded,type);
            HelperBuyAlert.getInstance().alert(msg,_buyConfirmAlertData,"SimpleAlertWithNotShowAgain",onUsePropCheckOut,onUsePropConfirm);
         }
      }
      
      public function get isRunning() : Boolean
      {
         return _lotteryView.isRunning;
      }
      
      public function get isContinue() : Boolean
      {
         return continueCheckBtn.selected;
      }
      
      public function continueLottery() : void
      {
         if(isContinue)
         {
            onClickSacrifice(_type);
         }
      }
      
      override public function dispose() : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",__onTimer);
         _timer = null;
         _jackpotTimer.removeEventListener("timer",_onJackpotTimer);
         _jackpotTimer = null;
         DevilTurnManager.instance.removeEventListener("updateinfo",__onUpdateInfo);
         DevilTurnManager.instance.removeEventListener("updateranklist",__onUpdateRankInfo);
         DevilTurnManager.instance.removeEventListener("updatejackpot",__onUpdateJackpot);
         DevilTurnManager.instance.removeEventListener("updateActivityState",__onUpdateActivityState);
         _model = null;
         ObjectUtils.disposeObject(_lotteryView);
         _lotteryView = null;
         super.dispose();
      }
   }
}
