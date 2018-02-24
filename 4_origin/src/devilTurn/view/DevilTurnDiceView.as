package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import ddt.utils.PositionUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.view.mornui.DevilTurnDiceViewUI;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import morn.core.handlers.Handler;
   
   public class DevilTurnDiceView extends DevilTurnDiceViewUI
   {
      
      private static const RANGE_WIDTH:int = 42;
      
      private static var _buyConfirmAlertData:ConfirmAlertData = new ConfirmAlertData();
       
      
      private var _cellList:Vector.<BagCell>;
      
      private var _boxList:Array;
      
      private var _id:int;
      
      private var _currentTime:int;
      
      private var _phase:int;
      
      private var _rateCell:BagCell;
      
      private var _isFreeDice:Boolean;
      
      private var _state:int;
      
      private var _money:int;
      
      private var _leftDice:MovieClip;
      
      private var _rightDice:MovieClip;
      
      private var _actionRunning:Boolean;
      
      private var _time:int;
      
      private var _actionTimer:Timer;
      
      private var _leftDiceValue:int;
      
      private var _rightDiceValue:int;
      
      public function DevilTurnDiceView(param1:int)
      {
         _id = param1;
         _boxList = DevilTurnManager.instance.model.getBoxListByID(param1);
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         abandonBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label1");
         startBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label2");
         continueBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label3");
         getBtn.label = LanguageMgr.GetTranslation("devilTurn.mornUI.label17");
         text4.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label4");
         _actionTimer = new Timer(800,2);
         _actionTimer.addEventListener("timer",__onPlayRightAction);
         _actionTimer.addEventListener("timerComplete",__onAcitonComplate);
         _actionTimer.stop();
         closeBtn.clickHandler = new Handler(onClickClose);
         startBtn.clickHandler = new Handler(onClickStart);
         abandonBtn.clickHandler = new Handler(onClickAbandon);
         continueBtn.clickHandler = new Handler(onClickContinue);
         getBtn.clickHandler = new Handler(onClickGet);
         _cellList = new Vector.<BagCell>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new BagCell(_loc2_,ItemManager.Instance.getTemplateById(int(_boxList[_loc2_])),false,getCellBg());
            PositionUtils.setPos(_loc1_,"devilTurn.diceCellPos" + _loc2_);
            addChild(_loc1_);
            _cellList.push(_loc1_);
            _loc2_++;
         }
         _rateCell = new BagCell(0,ItemManager.Instance.getTemplateById(ServerConfigManager.instance.devilTurnTemplateID),false,getCellBg());
         PositionUtils.setPos(_rateCell,"devilTurn.diceView.rateCell");
         _rateCell.visible = false;
         addChild(_rateCell);
         _leftDice = ComponentFactory.Instance.creatCustomObject("devilTurn.diceView.leftAction");
         _rightDice = ComponentFactory.Instance.creatCustomObject("devilTurn.diceView.rightAction");
         _leftDice.gotoAndStop(7);
         _rightDice.gotoAndStop(7);
         addChild(_leftDice);
         addChild(_rightDice);
         addChild(coverFrontImg);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,16),__onDiceResult);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,21),__onDiceRange);
         SocketManager.Instance.addEventListener(PkgEvent.format(608,23),__onUpdateDiceView);
      }
      
      private function onClickContinue() : void
      {
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
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         if(_state == 2)
         {
            if(_phase == 5)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.maxPhase"));
               return;
            }
            SocketManager.Instance.out.sendDevilTurnContinueDice(_id,_buyConfirmAlertData.isBind);
         }
         else
         {
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
               SocketManager.Instance.out.sendDevilTurnContinueDice(_id,_buyConfirmAlertData.isBind);
            };
            _buyConfirmAlertData.moneyNeeded = _money;
            if(_buyConfirmAlertData.notShowAlertAgain)
            {
               CheckMoneyUtils.instance.checkMoney(_buyConfirmAlertData.isBind,_buyConfirmAlertData.moneyNeeded,onUsePropCheckOut);
            }
            else
            {
               var msg:String = LanguageMgr.GetTranslation("tank.devilTurn.diceTips",_buyConfirmAlertData.moneyNeeded);
               HelperBuyAlert.getInstance().alert(msg,_buyConfirmAlertData,"SimpleAlertWithNotShowAgain",onUsePropCheckOut,onUsePropConfirm);
            }
         }
      }
      
      private function onClickAbandon() : void
      {
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
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("tank.devilTurn.abandonTips");
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         _loc1_.addEventListener("response",__onAlertAbandonView);
      }
      
      private function __onAlertAbandonView(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertAbandonView);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendDevilTurnBoxAbandon(_id);
            _loc2_.dispose();
            dispose();
         }
         else
         {
            _loc2_.dispose();
         }
      }
      
      private function onClickGet() : void
      {
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
         if(_state == 2 && _phase == 5)
         {
            SocketManager.Instance.out.sendDevilTurnGetBox(_id);
            dispose();
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("tank.devilTurn.getTips");
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         _loc1_.addEventListener("response",__onAlertGetView);
      }
      
      private function __onAlertGetView(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertGetView);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendDevilTurnGetBox(_id);
            _loc2_.dispose();
            dispose();
         }
         else
         {
            _loc2_.dispose();
         }
      }
      
      private function __onDiceResult(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readByte();
         var _loc3_:int = param1.pkg.readByte();
         _state = _loc3_;
         _actionRunning = true;
         playAction(_loc2_);
      }
      
      private function playAction(param1:int) : void
      {
         _rightDiceValue = 0;
         _leftDiceValue = 0;
         while(_leftDiceValue > 6 || _rightDiceValue > 6 || _leftDiceValue + _rightDiceValue != param1)
         {
            _leftDiceValue = int(Math.random() * param1);
            _leftDiceValue = _leftDiceValue <= 0?1:_leftDiceValue;
            _rightDiceValue = param1 - _leftDiceValue;
         }
         _actionTimer.reset();
         _actionTimer.start();
         _leftDice.gotoAndStop(_leftDiceValue);
      }
      
      private function __onPlayRightAction(param1:TimerEvent) : void
      {
         if(_actionTimer.currentCount == 1)
         {
            updateIndex(_leftDiceValue);
            _rightDice.gotoAndStop(_rightDiceValue);
         }
      }
      
      private function __onAcitonComplate(param1:TimerEvent) : void
      {
         _leftDice.gotoAndStop(_leftDiceValue + 6);
         _rightDice.gotoAndStop(_rightDiceValue + 6);
         _actionTimer.stop();
         updateIndex(_leftDiceValue + _rightDiceValue);
         updateState(_state);
         _actionRunning = false;
      }
      
      private function __onUpdateDiceView(param1:PkgEvent) : void
      {
         var _loc6_:int = param1.pkg.readByte();
         var _loc7_:int = param1.pkg.readByte();
         var _loc3_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readByte();
         var _loc8_:int = param1.pkg.readByte();
         var _loc4_:int = param1.pkg.readInt();
         _money = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readByte();
         updateIndex(_loc2_);
         updateBoxPhase(_loc7_);
         _state = _loc6_;
         updateState(_loc6_);
         updateDiceRange(_loc5_,_loc8_);
         updateRate(_loc3_,_loc4_);
      }
      
      private function updateIndex(param1:int) : void
      {
         if(param1 == 0)
         {
            indexImg.x = 41;
         }
         else
         {
            indexImg.x = (param1 - 1) * 42 + 65;
         }
      }
      
      private function updateState(param1:int) : void
      {
         startBtn.visible = param1 == 1;
         continueBtn.visible = param1 != 1;
         abandonBtn.visible = param1 == 3;
         getBtn.visible = param1 == 2;
         if(param1 == 3)
         {
            continueBtn.tipData = LanguageMgr.GetTranslation("tank.devilTurn.diceContinueTips",_money);
            continueBtn.tipStyle = "ddt.view.tips.OneLineTip";
         }
         else
         {
            continueBtn.dispatchEvent(new MouseEvent("rollOut"));
            continueBtn.tipData = null;
            continueBtn.tipStyle = null;
         }
      }
      
      private function updateBoxPhase(param1:int) : void
      {
         _phase = param1;
         shine.x = 76 + 96 * (param1 - 1);
      }
      
      private function updateRate(param1:int, param2:int) : void
      {
         rateText.text = LanguageMgr.GetTranslation("tank.devilTurn.currentRate",param1);
         _rateCell.setCount(param2);
         _rateCell.visible = true;
      }
      
      private function __onDiceRange(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readByte();
         var _loc3_:int = param1.pkg.readByte();
         updateDiceRange(_loc2_,_loc3_);
      }
      
      private function updateDiceRange(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         _loc4_ = 1;
         while(_loc4_ <= 12)
         {
            _loc3_ = _loc4_ >= param1 && _loc4_ <= param2;
            this["rangeNum" + _loc4_].visible = _loc3_;
            this["rangeImg" + _loc4_].visible = _loc3_;
            _loc4_++;
         }
      }
      
      private function onClickStart() : void
      {
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
         if(_actionRunning)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.diceRuuning"));
            return;
         }
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         SocketManager.Instance.out.sendDevilTurnDiceStart(_id);
      }
      
      private function getCellBg() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,52,52);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function onClickClose() : void
      {
         SoundManager.instance.playButtonSound();
         if(_actionRunning)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.diceRuuning"));
            return;
         }
         dispose();
      }
      
      override public function dispose() : void
      {
         _actionTimer.stop();
         _actionTimer.removeEventListener("timer",__onPlayRightAction);
         _actionTimer.removeEventListener("timerComplete",__onAcitonComplate);
         _actionTimer = null;
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,16),__onDiceResult);
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,21),__onDiceRange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(608,23),__onUpdateDiceView);
         while(_cellList.length)
         {
            ObjectUtils.disposeObject(_cellList.pop());
         }
         _cellList = null;
         _boxList.splice(0,_boxList.length);
         _boxList = null;
         ObjectUtils.disposeObject(_rateCell);
         _rateCell = null;
         ObjectUtils.disposeObject(_leftDice);
         _leftDice = null;
         ObjectUtils.disposeObject(_rightDice);
         _rightDice = null;
         super.dispose();
      }
   }
}
