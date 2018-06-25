package worldBossHelper.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ServerConfigInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import worldBossHelper.WorldBossHelperController;
   import worldBossHelper.WorldBossHelperManager;
   import worldBossHelper.event.WorldBossHelperEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossHelperLeftView extends Sprite implements Disposeable
   {
       
      
      private var _infoBg:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _receieveData:Boolean;
      
      private var _state:Boolean;
      
      private var _openStateTxt:FilterFrameText;
      
      private var _closeStateTxt:FilterFrameText;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _date1:Date;
      
      private var _date2:Date;
      
      private var _timer:Timer;
      
      private var _remainTime:int;
      
      private var _count:int;
      
      private var _countArr:Array;
      
      private var _titleTxtArr:Array;
      
      private var _allHonorTxt:FilterFrameText;
      
      private var _allMoneyTxt:FilterFrameText;
      
      private var _allMedalTxt:FilterFrameText;
      
      private var _startTimer:Timer;
      
      public function WorldBossHelperLeftView()
      {
         super();
         _countArr = ["一","二","三"];
         _titleTxtArr = [];
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _openBtn.addEventListener("click",__btnHandler);
         _closeBtn.addEventListener("click",__btnHandler);
      }
      
      protected function __btnHandler(event:MouseEvent) : void
      {
         var alertAsk:* = null;
         SoundManager.instance.play("008");
         if(event.target == _openBtn)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
         }
         if(!_date1)
         {
            _date1 = TimeManager.Instance.Now();
         }
         else
         {
            _date2 = TimeManager.Instance.Now();
            if(_date2.time - _date1.time < 10000)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("worldboss.helper.click"));
               return;
            }
            _date1 = _date2;
         }
         if(event.target == _openBtn)
         {
            alertAsk = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("worldboss.helper.isOpen"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alertAsk.addEventListener("response",__alertOpenHelper);
         }
         else
         {
            if(!_openBtn.visible)
            {
               fightFailDescription();
            }
            dispatchHelperEvent();
         }
      }
      
      public function dispatchHelperEvent() : void
      {
         var newEvent:WorldBossHelperEvent = new WorldBossHelperEvent("changeHelperState");
         newEvent.state = _openBtn.visible;
         dispatchEvent(newEvent);
      }
      
      protected function __alertOpenHelper(event:FrameEvent) : void
      {
         var buffNum:int = 0;
         var money:int = 0;
         var moneyNumInfo:* = null;
         var money1:int = 0;
         var moneyNumInfo1:* = null;
         var buffType:int = 0;
         var alertFrame:* = null;
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               if(WorldBossManager.Instance.bossInfo)
               {
                  buffNum = WorldBossHelperController.Instance.data.buffNum - WorldBossManager.Instance.bossInfo.myPlayerVO.buffLevel;
                  if(buffNum <= 0)
                  {
                     buffNum = 0;
                  }
               }
               else
               {
                  buffNum = WorldBossHelperController.Instance.data.buffNum;
               }
               moneyNumInfo = ServerConfigManager.instance.findInfoByName("BuyBossBufferMoney");
               if(moneyNumInfo && moneyNumInfo.Value)
               {
                  money = moneyNumInfo.Value;
               }
               else
               {
                  money = 30;
               }
               moneyNumInfo1 = ServerConfigManager.instance.findInfoByName("WorldBossAssistantFightMoney");
               if(moneyNumInfo1 && moneyNumInfo1.Value)
               {
                  money1 = moneyNumInfo1.Value;
               }
               else
               {
                  money1 = 10;
               }
               if(PlayerManager.Instance.Self.DDTMoney < money1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.worldBoss.notEnoughtmedal"));
                  break;
               }
               if(WorldBossHelperController.Instance.monkeyType == 1)
               {
                  buffType = 10;
               }
               else if(WorldBossHelperController.Instance.monkeyType == 2)
               {
                  buffType = 12;
               }
               else
               {
                  buffType = 0;
               }
               if(PlayerManager.Instance.Self.Money < buffNum * money + buffType)
               {
                  alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  alertFrame.addEventListener("response",_response);
                  event.currentTarget.removeEventListener("response",__alertOpenHelper);
                  ObjectUtils.disposeObject(event.currentTarget);
                  return;
               }
               dispatchHelperEvent();
               break;
         }
         event.currentTarget.removeEventListener("response",__alertOpenHelper);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function fightFailDescription() : void
      {
         var child:* = null;
         stopAndDisposeTimer();
         if(_vBox.numChildren > 0)
         {
            child = _vBox.getChildAt(_vBox.numChildren - 1) as FilterFrameText;
            child.text = LanguageMgr.GetTranslation("worldboss.helper.fightFail",WorldBossHelperManager.Instance.num);
         }
      }
      
      private function stopAndDisposeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
      }
      
      public function get state() : Boolean
      {
         return _state;
      }
      
      public function set state(value:Boolean) : void
      {
         _state = value;
      }
      
      private function initView() : void
      {
         _infoBg = ComponentFactory.Instance.creat("worldBossHelper.info");
         addChild(_infoBg);
         _allHonorTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.allHonorAndMoneyText");
         addChild(_allHonorTxt);
         _allHonorTxt.text = "0";
         PositionUtils.setPos(_allHonorTxt,"worldBossHelper.view.allHonorPos");
         _allMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.allHonorAndMoneyText");
         addChild(_allMoneyTxt);
         _allMoneyTxt.text = "0";
         PositionUtils.setPos(_allMoneyTxt,"worldBossHelper.view.allMoneyPos");
         _allMedalTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.allHonorAndMoneyText");
         addChild(_allMedalTxt);
         _allMedalTxt.text = "0";
         PositionUtils.setPos(_allMedalTxt,"worldBossHelper.view.allMedalPos");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.scrollPanel");
         _scrollPanel.setView(_vBox);
         addChild(_scrollPanel);
         _openStateTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.helperStateText");
         _openStateTxt.text = LanguageMgr.GetTranslation("worldbosshelper.open");
         addChild(_openStateTxt);
         _closeStateTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.helperStateText");
         _closeStateTxt.text = LanguageMgr.GetTranslation("worldbosshelper.close");
         addChild(_closeStateTxt);
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.openBtn");
         _openBtn.tipData = LanguageMgr.GetTranslation("worldboss.helper.openTip");
         addChild(_openBtn);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.closeBtn");
         addChild(_closeBtn);
      }
      
      public function changeState() : void
      {
         _state = WorldBossHelperController.Instance.data.isOpen;
         if(_state)
         {
            var _loc1_:Boolean = false;
            _openBtn.visible = _loc1_;
            _closeStateTxt.visible = _loc1_;
            _loc1_ = true;
            _closeBtn.visible = _loc1_;
            _openStateTxt.visible = _loc1_;
            if(WorldBossManager.Instance.bossInfo && !WorldBossManager.Instance.bossInfo.fightOver)
            {
               startFight();
            }
         }
         else
         {
            WorldBossHelperManager.Instance.isFighting = false;
            _loc1_ = true;
            _openBtn.visible = _loc1_;
            _closeStateTxt.visible = _loc1_;
            _loc1_ = false;
            _closeBtn.visible = _loc1_;
            _openStateTxt.visible = _loc1_;
         }
      }
      
      private function checkTrueStart() : Boolean
      {
         if(!WorldBossHelperController.Instance.data.isOpen)
         {
            return false;
         }
         if(WorldBossManager.Instance.bossInfo && !WorldBossManager.Instance.bossInfo.fightOver && WorldBossManager.Instance.beforeStartTime <= 0)
         {
            return true;
         }
         if(!_startTimer)
         {
            _startTimer = new Timer(1000);
            _startTimer.addEventListener("timer",startTimerHandler,false,0,true);
         }
         _startTimer.start();
         return false;
      }
      
      private function startTimerHandler(event:TimerEvent) : void
      {
         if(WorldBossManager.Instance.bossInfo && !WorldBossManager.Instance.bossInfo.fightOver && WorldBossManager.Instance.beforeStartTime <= 0)
         {
            startFight();
            disposeStartTimer();
         }
      }
      
      private function disposeStartTimer() : void
      {
         if(_startTimer)
         {
            _startTimer.removeEventListener("timer",startTimerHandler);
            _startTimer.stop();
            _startTimer = null;
         }
      }
      
      public function startFight() : void
      {
         if(!checkTrueStart())
         {
            return;
         }
         WorldBossHelperManager.Instance.isFighting = true;
         addDescription(false,WorldBossHelperManager.Instance.num,null,0);
         if(WorldBossHelperController.Instance.data.type == 0)
         {
            if(WorldBossHelperManager.Instance.WorldBossAssistantTimeInfo1)
            {
               _remainTime = int(WorldBossHelperManager.Instance.WorldBossAssistantTimeInfo1.Value);
            }
            else
            {
               _remainTime = 90;
            }
         }
         else if(WorldBossHelperController.Instance.data.type == 1)
         {
            if(WorldBossHelperManager.Instance.WorldBossAssistantTimeInfo2)
            {
               _remainTime = int(WorldBossHelperManager.Instance.WorldBossAssistantTimeInfo2.Value);
            }
            else
            {
               _remainTime = 70;
            }
         }
         else if(WorldBossHelperController.Instance.data.type == 2)
         {
            if(WorldBossHelperManager.Instance.WorldBossAssistantTimeInfo3)
            {
               _remainTime = int(WorldBossHelperManager.Instance.WorldBossAssistantTimeInfo3.Value);
            }
            else
            {
               _remainTime = 65;
            }
         }
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      protected function __timerHandler(event:TimerEvent) : void
      {
         if(_count != _remainTime)
         {
            _count = Number(_count) + 1;
         }
         if(_count == _remainTime)
         {
            if(!_receieveData)
            {
               WorldBossHelperController.Instance.data.requestType = 3;
               SocketManager.Instance.out.openOrCloseWorldBossHelper(WorldBossHelperController.Instance.data);
            }
            else
            {
               _receieveData = false;
               _count = 0;
               addDescription(false,WorldBossHelperManager.Instance.num,null,0);
            }
         }
      }
      
      public function addDescription(isFightOver:Boolean, num:int, hurtArr:Array, honor:int) : void
      {
         var honorTxt:* = null;
         var fightTitleTxt:* = null;
         var i:int = 0;
         var descriptionTxt:* = null;
         var fightTitleDescriptionTxt:* = null;
         if(WorldBossHelperManager.Instance.isFighting)
         {
            if(isFightOver)
            {
               _allHonorTxt.text = "" + WorldBossHelperManager.Instance.allHonor;
               _allMoneyTxt.text = "" + WorldBossHelperManager.Instance.allMoney;
               _allMedalTxt.text = "" + WorldBossHelperManager.Instance.allMedal;
               honorTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.infoText");
               if(hurtArr.length > 0)
               {
                  fightTitleTxt = _titleTxtArr[num - 1];
                  fightTitleTxt.text = LanguageMgr.GetTranslation("worldboss.helper.fightTitleTxt",num);
               }
               i = 0;
               while(i < hurtArr.length)
               {
                  descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.infoText");
                  descriptionTxt.text = LanguageMgr.GetTranslation("worldboss.helper.fightHurt",_countArr[i],hurtArr[i]);
                  descriptionTxt.x = fightTitleTxt.x + 40;
                  _vBox.addChild(descriptionTxt);
                  i++;
               }
               honorTxt.text = LanguageMgr.GetTranslation("worldboss.helper.fightHonor",honor);
               honorTxt.x = fightTitleTxt.x + 40;
               _vBox.addChild(honorTxt);
               _receieveData = true;
            }
            else
            {
               fightTitleDescriptionTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.titleInfoText");
               fightTitleDescriptionTxt.text = LanguageMgr.GetTranslation("worldboss.helper.fighting",num);
               _vBox.addChild(fightTitleDescriptionTxt);
               _titleTxtArr.push(fightTitleDescriptionTxt);
            }
         }
         else
         {
            fightFailDescription();
         }
         _scrollPanel.invalidateViewport(true);
      }
      
      private function removeEvent() : void
      {
         _openBtn.removeEventListener("click",__btnHandler);
         _closeBtn.removeEventListener("click",__btnHandler);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         disposeStartTimer();
         stopAndDisposeTimer();
         removeEvent();
         _infoBg.bitmapData.dispose();
         _infoBg = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_allHonorTxt);
         _allHonorTxt = null;
         ObjectUtils.disposeObject(_allMoneyTxt);
         _allMoneyTxt = null;
         ObjectUtils.disposeObject(_allMedalTxt);
         _allMedalTxt = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_openStateTxt);
         _openStateTxt = null;
         ObjectUtils.disposeObject(_closeStateTxt);
         _closeStateTxt = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         for(i = 0; i < _titleTxtArr.length; )
         {
            if(_titleTxtArr[i])
            {
               ObjectUtils.disposeObject(_titleTxtArr[i]);
               _titleTxtArr[i] = null;
            }
            i++;
         }
         _titleTxtArr = null;
         _date1 = null;
         _date2 = null;
         _countArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
