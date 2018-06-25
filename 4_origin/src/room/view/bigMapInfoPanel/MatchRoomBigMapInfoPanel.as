package room.view.bigMapInfoPanel
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.MainToolBar;
   import ddt.view.SelectStateButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class MatchRoomBigMapInfoPanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _png:Bitmap;
      
      private var _info:RoomInfo;
      
      private var _guildModeBtn:SelectStateButton;
      
      private var _freeModeBtn:SelectStateButton;
      
      private var _smallBg:Bitmap;
      
      private var _gameModeIcon:ScaleFrameImage;
      
      private var _matchingPic:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _eliteGame:Bitmap;
      
      private var _battleGame:Bitmap;
      
      private var _eliteGameTimer:Timer;
      
      private var _eliteTime:int;
      
      private var _teamBattle:Bitmap;
      
      public function MatchRoomBigMapInfoPanel()
      {
         super();
         initView();
         _freeModeBtn.addEventListener("click",__freeClickHandler);
         _guildModeBtn.addEventListener("click",__guildClickHandler);
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.bigMapinfo.bg");
         addChild(_bg);
         _freeModeBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.bigMapInfoPanel.freeModeButton");
         _freeModeBtn.backGround = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.freeModeBtn");
         _freeModeBtn.overBackGround = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.freeModeBtnOver");
         addChild(_freeModeBtn);
         _guildModeBtn = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.bigMapInfoPanel.guildModeButton");
         _guildModeBtn.backGround = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.guildModeBtn");
         _guildModeBtn.overBackGround = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.guildModeBtnOver");
         addChild(_guildModeBtn);
         _eliteGame = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.eliteGamebtn");
         addChild(_eliteGame);
         _eliteGame.visible = false;
         _battleGame = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.battleModeBtn");
         addChild(_battleGame);
         _battleGame.visible = false;
         _teamBattle = ComponentFactory.Instance.creatBitmap("asset.teamRoom.text");
         addChild(_teamBattle);
         _teamBattle.visible = false;
         var _loc1_:* = false;
         _guildModeBtn.enable = _loc1_;
         _loc1_ = _loc1_;
         _guildModeBtn.selected = _loc1_;
         _loc1_ = _loc1_;
         _freeModeBtn.enable = _loc1_;
         _freeModeBtn.selected = _loc1_;
         _loc1_ = true;
         _freeModeBtn.gray = _loc1_;
         _freeModeBtn.gray = _loc1_;
         _smallBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.smallBg");
         addChild(_smallBg);
         _smallBg.visible = false;
         _gameModeIcon = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.bigMapinfo.gameModeIcon");
         _gameModeIcon.setFrame(1);
         addChild(_gameModeIcon);
         _gameModeIcon.visible = false;
         _matchingPic = ComponentFactory.Instance.creatBitmap("asset.ddtroom.bigMapInfo.matchingTxt");
         _matchingPic.visible = false;
         addChild(_matchingPic);
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.bigMapinfo.timeTxt");
         addChild(_timeTxt);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timer);
      }
      
      private function setPngBitmap() : void
      {
         var asLink:* = null;
         if(_info.type == 58)
         {
            asLink = "asset.teamRoom.bg";
         }
         else
         {
            asLink = _info.type == 68?"asset.ddtroom.polarRegion.map":"asset.ddtroom.charecaterPng";
         }
         if(!_png)
         {
            _png = ComponentFactory.Instance.creatBitmap(asLink);
            addChildAt(_png,1);
         }
      }
      
      public function set info(value:RoomInfo) : void
      {
         if(_info)
         {
            _info.removeEventListener("gameModeChange",__update);
            _info.removeEventListener("startedChanged",__startedHandler);
            _info.removeEventListener("playerStateChanged",__update);
            _info.removeEventListener("addPlayer",__update);
            _info.removeEventListener("removePlayer",__update);
            _info.removeEventListener("roomplaceChanged",__update);
            _info = null;
         }
         _info = value;
         if(_info)
         {
            _info.addEventListener("gameModeChange",__update);
            _info.addEventListener("startedChanged",__startedHandler);
            _info.addEventListener("playerStateChanged",__update);
            _info.addEventListener("addPlayer",__update);
            _info.addEventListener("removePlayer",__update);
            _info.addEventListener("roomplaceChanged",__update);
         }
         updateView();
         updateBtns();
      }
      
      private function __eliteGameTimerHandler(event:TimerEvent) : void
      {
         _eliteTime = Number(_eliteTime) - 1;
         _eliteTime = _eliteTime < 0?0:_eliteTime;
         _timeTxt.text = _eliteTime < 10?"0" + _eliteTime:_eliteTime + "";
      }
      
      private function __update(evt:RoomEvent) : void
      {
         updateView();
         updateBtns();
      }
      
      private function __startedHandler(evt:RoomEvent) : void
      {
         RoomManager.Instance.isMatch = _info.started;
         if(_info.started)
         {
            if(!_timer.running)
            {
               if(_eliteGameTimer)
               {
                  _eliteGameTimer.removeEventListener("timer",__eliteGameTimerHandler);
                  _eliteGameTimer = null;
               }
               _timeTxt.text = "00";
               _timer.start();
            }
         }
         else
         {
            _timer.stop();
            _timer.reset();
            if(_info.gameMode == 4 && _info.selfRoomPlayer.isHost)
            {
               SocketManager.Instance.out.sendGameStyle(1);
            }
         }
         updateView();
         updateBtns();
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         var min:uint = _timer.currentCount / 60;
         var sec:uint = _timer.currentCount % 60;
         _timeTxt.text = sec > 9?sec.toString():"0" + sec;
         if(_timer.currentCount == 20)
         {
            if(!_info.selfRoomPlayer.isHost && !_info.selfRoomPlayer.isViewer)
            {
               MainToolBar.Instance.setReturnEnable(true);
               dispatchEvent(new RoomEvent("tweentySec"));
            }
         }
      }
      
      private function updateView() : void
      {
         if(_freeModeBtn && _gameModeIcon && _matchingPic && _smallBg)
         {
            if(_info)
            {
               setPngBitmap();
               if(_info.type == 41 || _info.type == 42)
               {
                  var _loc1_:* = false;
                  _guildModeBtn.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _freeModeBtn.visible = _loc1_;
                  _eliteGame.visible = _loc1_;
                  _loc1_ = _info.started;
                  _smallBg.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _timeTxt.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _matchingPic.visible = _loc1_;
                  _gameModeIcon.visible = _loc1_;
               }
               else if(_info.type == 13)
               {
                  _loc1_ = true;
                  _smallBg.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _timeTxt.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _matchingPic.visible = _loc1_;
                  _gameModeIcon.visible = _loc1_;
                  _matchingPic.visible = _info.started;
                  _loc1_ = false;
                  _guildModeBtn.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _freeModeBtn.visible = _loc1_;
                  _eliteGame.visible = _loc1_;
                  _gameModeIcon.setFrame(3);
               }
               else if(_info.type == 12)
               {
                  _loc1_ = _info.started;
                  _smallBg.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _timeTxt.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _matchingPic.visible = _loc1_;
                  _gameModeIcon.visible = _loc1_;
                  _eliteGame.visible = !_info.started;
                  _loc1_ = false;
                  _guildModeBtn.visible = _loc1_;
                  _freeModeBtn.visible = _loc1_;
                  _gameModeIcon.setFrame(3);
               }
               else if(_info.type == 58)
               {
                  _loc1_ = _info.started;
                  _matchingPic.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _gameModeIcon.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _smallBg.visible = _loc1_;
                  _timeTxt.visible = _loc1_;
                  _battleGame.visible = false;
                  _loc1_ = false;
                  _guildModeBtn.visible = _loc1_;
                  _freeModeBtn.visible = _loc1_;
                  _teamBattle.visible = !_info.started;
                  _gameModeIcon.setFrame(6);
               }
               else if(_info.type == 120)
               {
                  _loc1_ = _info.started;
                  _matchingPic.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _gameModeIcon.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _smallBg.visible = _loc1_;
                  _timeTxt.visible = _loc1_;
                  _battleGame.visible = !_info.started;
                  _loc1_ = false;
                  _guildModeBtn.visible = _loc1_;
                  _freeModeBtn.visible = _loc1_;
                  _gameModeIcon.setFrame(5);
               }
               else if(_info.type == 68)
               {
                  _loc1_ = false;
                  _eliteGame.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _matchingPic.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _guildModeBtn.visible = _loc1_;
                  _freeModeBtn.visible = _loc1_;
                  _loc1_ = _info.started;
                  _timeTxt.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _matchingPic.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _gameModeIcon.visible = _loc1_;
                  _smallBg.visible = _loc1_;
                  _gameModeIcon.setFrame(4);
               }
               else
               {
                  _eliteGame.visible = false;
                  _loc1_ = !_info.started;
                  _guildModeBtn.visible = _loc1_;
                  _freeModeBtn.visible = _loc1_;
                  _loc1_ = _info.started;
                  _smallBg.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _timeTxt.visible = _loc1_;
                  _loc1_ = _loc1_;
                  _matchingPic.visible = _loc1_;
                  _gameModeIcon.visible = _loc1_;
                  if(_info.gameMode != 4)
                  {
                     _gameModeIcon.setFrame(_info.gameMode + 1);
                  }
                  if(_info.gameMode == 12)
                  {
                     _gameModeIcon.setFrame(1);
                  }
                  if(_info.gameMode == 13)
                  {
                     _gameModeIcon.setFrame(2);
                  }
               }
            }
            else
            {
               _loc1_ = false;
               _smallBg.visible = _loc1_;
               _loc1_ = _loc1_;
               _timeTxt.visible = _loc1_;
               _loc1_ = _loc1_;
               _matchingPic.visible = _loc1_;
               _loc1_ = _loc1_;
               _gameModeIcon.visible = _loc1_;
               _loc1_ = _loc1_;
               _guildModeBtn.visible = _loc1_;
               _loc1_ = _loc1_;
               _freeModeBtn.visible = _loc1_;
               _eliteGame.visible = _loc1_;
            }
         }
      }
      
      private function updateBtns() : void
      {
         var canPlayeGuildMode:Boolean = _info.canPlayGuidMode();
         if(_freeModeBtn && _gameModeIcon)
         {
            _guildModeBtn.selected = _info && _info.gameMode == 1 || _info && _info.gameMode == 13;
            _freeModeBtn.selected = _info && _info.gameMode == 0 || _info && _info.gameMode == 12;
            var _loc2_:* = _info && _info.selfRoomPlayer.isHost;
            _freeModeBtn.buttonMode = _loc2_;
            _freeModeBtn.enable = _loc2_;
            _loc2_ = _info && _info.selfRoomPlayer.isHost && canPlayeGuildMode;
            _guildModeBtn.buttonMode = _loc2_;
            _guildModeBtn.enable = _loc2_;
            _freeModeBtn.gray = false;
            _freeModeBtn.buttonMode = _info && canPlayeGuildMode && _info.selfRoomPlayer.isHost;
            _guildModeBtn.gray = !(_info && canPlayeGuildMode);
         }
      }
      
      private function __freeClickHandler(evt:MouseEvent) : void
      {
         if(_info && _info.canPlayGuidMode())
         {
            SoundManager.instance.play("008");
         }
         SocketManager.Instance.out.sendGameStyle(0);
      }
      
      private function __guildClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendGameStyle(1);
      }
      
      private function removeEvents() : void
      {
         if(_info)
         {
            _info.removeEventListener("gameModeChange",__update);
            _info.removeEventListener("startedChanged",__startedHandler);
            _info.removeEventListener("playerStateChanged",__update);
            _info.removeEventListener("addPlayer",__update);
            _info.removeEventListener("removePlayer",__update);
         }
         if(_eliteGameTimer)
         {
            _eliteGameTimer.removeEventListener("timer",__eliteGameTimerHandler);
            _eliteGameTimer.stop();
         }
         _timer.removeEventListener("timer",__timer);
         _freeModeBtn.removeEventListener("click",__freeClickHandler);
         _guildModeBtn.removeEventListener("click",__guildClickHandler);
      }
      
      public function dispose() : void
      {
         RoomManager.Instance.isMatch = false;
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         ObjectUtils.disposeObject(_png);
         _png = null;
         ObjectUtils.disposeObject(_guildModeBtn);
         _guildModeBtn = null;
         ObjectUtils.disposeObject(_freeModeBtn);
         _freeModeBtn = null;
         ObjectUtils.disposeObject(_gameModeIcon);
         _gameModeIcon = null;
         ObjectUtils.disposeObject(_smallBg);
         _smallBg = null;
         ObjectUtils.disposeObject(_matchingPic);
         _matchingPic = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_battleGame);
         _battleGame = null;
         ObjectUtils.disposeObject(_teamBattle);
         _teamBattle = null;
         _timer.stop();
         _timer = null;
         _eliteGameTimer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
