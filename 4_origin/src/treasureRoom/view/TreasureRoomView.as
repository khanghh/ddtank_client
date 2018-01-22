package treasureRoom.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mark.MarkMgr;
   import mark.event.MarkEvent;
   import treasureRoom.mornui.TreasureRoomViewUI;
   
   public class TreasureRoomView extends TreasureRoomViewUI
   {
       
      
      private var _freeTimeNum:Number;
      
      private var _time:Timer;
      
      private var _btnHelp:BaseButton;
      
      private var _redEgg:MovieClip;
      
      private var _blueEgg:MovieClip;
      
      private var _fireballEgg:MovieClip;
      
      private var _rewardView:TreasureRoomRewardView;
      
      private var _index:int;
      
      private var _mask:Sprite;
      
      private var _configArr:Array;
      
      private var _totalFreeNum:int;
      
      private var _freeArr:Array;
      
      public function TreasureRoomView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _configArr = ServerConfigManager.instance.getEngraveVaults;
         _totalFreeNum = ServerConfigManager.instance.getEngraveVaultsFreeTimes;
         feeText1.text = LanguageMgr.GetTranslation("ddt.bandMoney") + _configArr[0][1];
         feeText2.text = LanguageMgr.GetTranslation("ddt.money") + _configArr[1][1];
         _blueEgg = ComponentFactory.Instance.creat("asset.treasureRoom.view.blueMov");
         PositionUtils.setPos(_blueEgg,"asset.treasureRoom.view.blueMovPos");
         addChild(_blueEgg);
         _redEgg = ComponentFactory.Instance.creat("asset.treasureRoom.view.redMov");
         PositionUtils.setPos(_redEgg,"asset.treasureRoom.view.redMovPos");
         addChild(_redEgg);
         _fireballEgg = ComponentFactory.Instance.creat("asset.treasureRoom.view.fireballMov");
         PositionUtils.setPos(_fireballEgg,"asset.treasureRoom.view.fireballMovPos");
         addChild(_fireballEgg);
         label13.text = LanguageMgr.GetTranslation("mark.mornUI.label13");
         countdownText.visible = false;
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"core.TreasureRoomFrame.helpBtn",{
            "x":812,
            "y":10
         },LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.treasureRoom.view.help",408,488);
         _mask = new Sprite();
         _mask.graphics.beginFill(16777215);
         _mask.graphics.drawRect(96,342,652,60);
         _mask.graphics.endFill();
         _mask.alpha = 0.01;
         addChild(_mask);
         _mask.visible = false;
      }
      
      private function addTimer() : void
      {
         countdownText.visible = true;
         if(_time == null)
         {
            _time = new Timer(1000);
            _time.addEventListener("timer",__onUpdateCountDown);
         }
         _time.start();
      }
      
      protected function __onUpdateCountDown(param1:TimerEvent) : void
      {
         _freeTimeNum = Number(_freeTimeNum) - 1;
         if(_freeTimeNum >= 0)
         {
            countdownText.text = LanguageMgr.GetTranslation("tank.game.GameView.countdownText",transSecond(_freeTimeNum),_freeArr[1],_totalFreeNum);
            oneTreasureBtn.skin = "asset.treasureRoom.view.oneTreasureBtn";
         }
         else
         {
            _time.stop();
            _time.reset();
            countdownText.visible = false;
            oneTreasureBtn.skin = "asset.treasureRoom.view.oneFreeBtn";
         }
      }
      
      private function transSecond(param1:Number) : String
      {
         var _loc2_:int = param1 / 3600;
         param1 = param1 - _loc2_ * 3600;
         return String((String("0" + Math.floor(param1 / 60))).substr(-2) + ":" + (String("0" + Math.floor(param1 % 60))).substr(-2));
      }
      
      private function addEvent() : void
      {
         oneTreasureBtn.addEventListener("click",__onClickHandler);
         tenTreasureBtn.addEventListener("click",__onClickHandler);
         markBtn.addEventListener("click",__onClickHandler);
         MarkMgr.inst.addEventListener("vaultsData",updateTimerHandler);
         MarkMgr.inst.addEventListener("vaultsReward",showRewardViewHandler);
      }
      
      private function showRewardViewHandler(param1:MarkEvent) : void
      {
         _index = param1.data;
         _mask.visible = true;
         if(_index == 0)
         {
            _blueEgg.gotoAndPlay(3);
         }
         else
         {
            _redEgg.gotoAndPlay(3);
         }
         _fireballEgg.gotoAndPlay(3);
         _fireballEgg.addEventListener("enterFrame",__onMovieFrame);
      }
      
      protected function __onMovieFrame(param1:Event) : void
      {
         if(_fireballEgg.currentFrame == _fireballEgg.totalFrames)
         {
            _fireballEgg.gotoAndStop(1);
            if(!MarkMgr.inst.isFull)
            {
               _rewardView = new TreasureRoomRewardView(_index,MarkMgr.inst.treasureRoomRewardArr);
               PositionUtils.setPos(_rewardView,"asset.treasureRoom.view.rewardViewPos" + _index);
               addChild(_rewardView);
               _rewardView.addEventListener("CLOSE",__rewardClose);
            }
            _fireballEgg.removeEventListener("enterFrame",__onMovieFrame);
            _blueEgg.gotoAndStop(1);
            _redEgg.gotoAndStop(1);
            _mask.visible = false;
         }
      }
      
      protected function __rewardClose(param1:Event) : void
      {
         if(_rewardView)
         {
            _rewardView.removeEventListener("CLOSE",__rewardClose);
            _rewardView.parent.removeChild(_rewardView);
            ObjectUtils.disposeObject(_rewardView);
            _rewardView = null;
         }
      }
      
      private function updateTimerHandler(param1:MarkEvent) : void
      {
         _freeArr = param1.data as Array;
         _freeTimeNum = _freeArr[0];
         if(_freeArr[1] > 0)
         {
            if(_freeTimeNum > 0)
            {
               countdownText.text = LanguageMgr.GetTranslation("tank.game.GameView.countdownText",transSecond(_freeTimeNum),_freeArr[1],_totalFreeNum);
               addTimer();
               oneTreasureBtn.skin = "asset.treasureRoom.view.oneTreasureBtn";
            }
            else
            {
               countdownText.visible = false;
               oneTreasureBtn.skin = "asset.treasureRoom.view.oneFreeBtn";
            }
         }
         else
         {
            countdownText.visible = false;
            oneTreasureBtn.skin = "asset.treasureRoom.view.oneTreasureBtn";
         }
      }
      
      protected function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(param1.target == oneTreasureBtn)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            __rewardClose(null);
            if(_freeTimeNum <= 0 && _freeArr[1] != 0)
            {
               SocketManager.Instance.out.sendTreasureRoomReward(0,false,true);
            }
            else
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.game.GameView.TreasureRoomViewConfirm1",_configArr[0][1],_configArr[0][0],_configArr[0][2]),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
               _loc3_.addEventListener("response",__alertAllBack);
            }
         }
         else if(param1.target == tenTreasureBtn)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            __rewardClose(null);
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.game.GameView.TreasureRoomViewConfirm2",_configArr[1][1],_configArr[1][0],_configArr[1][2]),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,0);
            _loc2_.addEventListener("response",__alertAllBack2);
         }
         else if(param1.target == markBtn)
         {
            __rewardClose(null);
            MarkMgr.inst.showMark();
         }
      }
      
      private function __alertAllBack(param1:FrameEvent) : void
      {
         event = param1;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(frame.isBand,_configArr[0][1],function():void
               {
                  SocketManager.Instance.out.sendTreasureRoomReward(0,true,CheckMoneyUtils.instance.isBind);
               });
         }
         frame.dispose();
      }
      
      private function __alertAllBack2(param1:FrameEvent) : void
      {
         event = param1;
         var frame:BaseAlerFrame = event.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__alertAllBack);
         SoundManager.instance.playButtonSound();
         switch(int(event.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(false,_configArr[1][1],function():void
               {
                  SocketManager.Instance.out.sendTreasureRoomReward(1,true,CheckMoneyUtils.instance.isBind);
               });
         }
         frame.dispose();
      }
      
      private function removeEvent() : void
      {
         oneTreasureBtn.removeEventListener("click",__onClickHandler);
         tenTreasureBtn.removeEventListener("click",__onClickHandler);
         markBtn.removeEventListener("click",__onClickHandler);
         MarkMgr.inst.removeEventListener("vaultsData",updateTimerHandler);
         MarkMgr.inst.removeEventListener("vaultsReward",showRewardViewHandler);
      }
      
      protected function disposeView(param1:Event) : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_time != null)
         {
            _time.stop();
            _time.reset();
            _time.removeEventListener("timer",__onUpdateCountDown);
            _time = null;
         }
         if(_btnHelp)
         {
            ObjectUtils.disposeObject(_btnHelp);
         }
         _btnHelp = null;
         if(_fireballEgg)
         {
            _fireballEgg.removeEventListener("enterFrame",__onMovieFrame);
            ObjectUtils.disposeObject(_fireballEgg);
            _fireballEgg = null;
         }
         if(_blueEgg)
         {
            ObjectUtils.disposeObject(_blueEgg);
         }
         _blueEgg = null;
         if(_redEgg)
         {
            ObjectUtils.disposeObject(_redEgg);
         }
         _redEgg = null;
         if(_rewardView)
         {
            _rewardView.removeEventListener("CLOSE",__rewardClose);
            ObjectUtils.disposeObject(_rewardView);
            _rewardView = null;
         }
         if(_mask)
         {
            ObjectUtils.disposeObject(_mask);
         }
         _mask = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
