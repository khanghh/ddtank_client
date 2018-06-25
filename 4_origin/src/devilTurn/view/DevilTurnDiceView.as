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
      
      public function DevilTurnDiceView(id:int)
      {
         _id = id;
         _boxList = DevilTurnManager.instance.model.getBoxListByID(id);
         super();
      }
      
      override protected function initialize() : void
      {
         var i:int = 0;
         var cell:* = null;
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
         for(i = 0; i < 5; )
         {
            cell = new BagCell(i,ItemManager.Instance.getTemplateById(int(_boxList[i])),false,getCellBg());
            PositionUtils.setPos(cell,"devilTurn.diceCellPos" + i);
            addChild(cell);
            _cellList.push(cell);
            i++;
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
            onUsePropConfirm = function(frame:BaseAlerFrame):void
            {
               _buyConfirmAlertData.notShowAlertAgain = frame["isNoPrompt"];
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
         var tip:String = LanguageMgr.GetTranslation("tank.devilTurn.abandonTips");
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),tip,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         alertFrame.addEventListener("response",__onAlertAbandonView);
      }
      
      private function __onAlertAbandonView(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertAbandonView);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendDevilTurnBoxAbandon(_id);
            alertFrame.dispose();
            dispose();
         }
         else
         {
            alertFrame.dispose();
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
         var tip:String = LanguageMgr.GetTranslation("tank.devilTurn.getTips");
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),tip,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
         alertFrame.addEventListener("response",__onAlertGetView);
      }
      
      private function __onAlertGetView(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertGetView);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendDevilTurnGetBox(_id);
            alertFrame.dispose();
            dispose();
         }
         else
         {
            alertFrame.dispose();
         }
      }
      
      private function __onDiceResult(e:PkgEvent) : void
      {
         var num:int = e.pkg.readByte();
         var state:int = e.pkg.readByte();
         _state = state;
         _actionRunning = true;
         playAction(num);
      }
      
      private function playAction(num:int) : void
      {
         _rightDiceValue = 0;
         _leftDiceValue = 0;
         while(_leftDiceValue > 6 || _rightDiceValue > 6 || _leftDiceValue + _rightDiceValue != num)
         {
            _leftDiceValue = int(Math.random() * num);
            _leftDiceValue = _leftDiceValue <= 0?1:_leftDiceValue;
            _rightDiceValue = num - _leftDiceValue;
         }
         _actionTimer.reset();
         _actionTimer.start();
         _leftDice.gotoAndStop(_leftDiceValue);
      }
      
      private function __onPlayRightAction(e:TimerEvent) : void
      {
         if(_actionTimer.currentCount == 1)
         {
            updateIndex(_leftDiceValue);
            _rightDice.gotoAndStop(_rightDiceValue);
         }
      }
      
      private function __onAcitonComplate(e:TimerEvent) : void
      {
         _leftDice.gotoAndStop(_leftDiceValue + 6);
         _rightDice.gotoAndStop(_rightDiceValue + 6);
         _actionTimer.stop();
         updateIndex(_leftDiceValue + _rightDiceValue);
         updateState(_state);
         _actionRunning = false;
      }
      
      private function __onUpdateDiceView(e:PkgEvent) : void
      {
         var state:int = e.pkg.readByte();
         var phase:int = e.pkg.readByte();
         var rate:int = e.pkg.readInt();
         var start:int = e.pkg.readByte();
         var end:int = e.pkg.readByte();
         var count:int = e.pkg.readInt();
         _money = e.pkg.readInt();
         var num:int = e.pkg.readByte();
         updateIndex(num);
         updateBoxPhase(phase);
         _state = state;
         updateState(state);
         updateDiceRange(start,end);
         updateRate(rate,count);
      }
      
      private function updateIndex(index:int) : void
      {
         if(index == 0)
         {
            indexImg.x = 41;
         }
         else
         {
            indexImg.x = (index - 1) * 42 + 65;
         }
      }
      
      private function updateState(state:int) : void
      {
         startBtn.visible = state == 1;
         continueBtn.visible = state != 1;
         abandonBtn.visible = state == 3;
         getBtn.visible = state == 2;
         if(state == 3)
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
      
      private function updateBoxPhase(phase:int) : void
      {
         _phase = phase;
         shine.x = 76 + 96 * (phase - 1);
      }
      
      private function updateRate(rate:int, count:int) : void
      {
         rateText.text = LanguageMgr.GetTranslation("tank.devilTurn.currentRate",rate);
         _rateCell.setCount(count);
         _rateCell.visible = true;
      }
      
      private function __onDiceRange(e:PkgEvent) : void
      {
         var start:int = e.pkg.readByte();
         var end:int = e.pkg.readByte();
         updateDiceRange(start,end);
      }
      
      private function updateDiceRange(begin:int, end:int) : void
      {
         var i:int = 0;
         var isVisible:Boolean = false;
         for(i = 1; i <= 12; )
         {
            isVisible = i >= begin && i <= end;
            this["rangeNum" + i].visible = isVisible;
            this["rangeImg" + i].visible = isVisible;
            i++;
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
         var cellBg:Shape = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,52,52);
         cellBg.graphics.endFill();
         return cellBg;
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
