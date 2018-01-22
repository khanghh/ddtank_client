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
      
      protected function __btnHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(param1.target == _openBtn)
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
         if(param1.target == _openBtn)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("worldboss.helper.isOpen"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc2_.addEventListener("response",__alertOpenHelper);
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
         var _loc1_:WorldBossHelperEvent = new WorldBossHelperEvent("changeHelperState");
         _loc1_.state = _openBtn.visible;
         dispatchEvent(_loc1_);
      }
      
      protected function __alertOpenHelper(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(WorldBossManager.Instance.bossInfo)
               {
                  _loc3_ = WorldBossHelperController.Instance.data.buffNum - WorldBossManager.Instance.bossInfo.myPlayerVO.buffLevel;
                  if(_loc3_ <= 0)
                  {
                     _loc3_ = 0;
                  }
               }
               else
               {
                  _loc3_ = WorldBossHelperController.Instance.data.buffNum;
               }
               _loc5_ = ServerConfigManager.instance.findInfoByName("BuyBossBufferMoney");
               if(_loc5_ && _loc5_.Value)
               {
                  _loc4_ = _loc5_.Value;
               }
               else
               {
                  _loc4_ = 30;
               }
               _loc8_ = ServerConfigManager.instance.findInfoByName("WorldBossAssistantFightMoney");
               if(_loc8_ && _loc8_.Value)
               {
                  _loc6_ = _loc8_.Value;
               }
               else
               {
                  _loc6_ = 10;
               }
               if(PlayerManager.Instance.Self.DDTMoney < _loc6_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.worldBoss.notEnoughtmedal"));
                  break;
               }
               if(WorldBossHelperController.Instance.monkeyType == 1)
               {
                  _loc7_ = 10;
               }
               else if(WorldBossHelperController.Instance.monkeyType == 2)
               {
                  _loc7_ = 12;
               }
               else
               {
                  _loc7_ = 0;
               }
               if(PlayerManager.Instance.Self.Money < _loc3_ * _loc4_ + _loc7_)
               {
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
                  _loc2_.addEventListener("response",_response);
                  param1.currentTarget.removeEventListener("response",__alertOpenHelper);
                  ObjectUtils.disposeObject(param1.currentTarget);
                  return;
               }
               dispatchHelperEvent();
               break;
         }
         param1.currentTarget.removeEventListener("response",__alertOpenHelper);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_response);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function fightFailDescription() : void
      {
         var _loc1_:* = null;
         stopAndDisposeTimer();
         if(_vBox.numChildren > 0)
         {
            _loc1_ = _vBox.getChildAt(_vBox.numChildren - 1) as FilterFrameText;
            _loc1_.text = LanguageMgr.GetTranslation("worldboss.helper.fightFail",WorldBossHelperManager.Instance.num);
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
      
      public function set state(param1:Boolean) : void
      {
         _state = param1;
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
      
      private function startTimerHandler(param1:TimerEvent) : void
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
      
      protected function __timerHandler(param1:TimerEvent) : void
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
      
      public function addDescription(param1:Boolean, param2:int, param3:Array, param4:int) : void
      {
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         if(WorldBossHelperManager.Instance.isFighting)
         {
            if(param1)
            {
               _allHonorTxt.text = "" + WorldBossHelperManager.Instance.allHonor;
               _allMoneyTxt.text = "" + WorldBossHelperManager.Instance.allMoney;
               _allMedalTxt.text = "" + WorldBossHelperManager.Instance.allMedal;
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.infoText");
               if(param3.length > 0)
               {
                  _loc8_ = _titleTxtArr[param2 - 1];
                  _loc8_.text = LanguageMgr.GetTranslation("worldboss.helper.fightTitleTxt",param2);
               }
               _loc9_ = 0;
               while(_loc9_ < param3.length)
               {
                  _loc7_ = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.infoText");
                  _loc7_.text = LanguageMgr.GetTranslation("worldboss.helper.fightHurt",_countArr[_loc9_],param3[_loc9_]);
                  _loc7_.x = _loc8_.x + 40;
                  _vBox.addChild(_loc7_);
                  _loc9_++;
               }
               _loc5_.text = LanguageMgr.GetTranslation("worldboss.helper.fightHonor",param4);
               _loc5_.x = _loc8_.x + 40;
               _vBox.addChild(_loc5_);
               _receieveData = true;
            }
            else
            {
               _loc6_ = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.titleInfoText");
               _loc6_.text = LanguageMgr.GetTranslation("worldboss.helper.fighting",param2);
               _vBox.addChild(_loc6_);
               _titleTxtArr.push(_loc6_);
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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < _titleTxtArr.length)
         {
            if(_titleTxtArr[_loc1_])
            {
               ObjectUtils.disposeObject(_titleTxtArr[_loc1_]);
               _titleTxtArr[_loc1_] = null;
            }
            _loc1_++;
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
