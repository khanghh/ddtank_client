package drgnBoat.views
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import drgnBoat.DrgnBoatManager;
   import drgnBoat.data.DrgnBoatCarInfo;
   import drgnBoat.data.DrgnBoatPlayerInfo;
   import drgnBoat.event.DrgnBoatEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class DrgnBoatGamePlayer extends Sprite implements Disposeable
   {
       
      
      private var _playerInfo:DrgnBoatPlayerInfo;
      
      private var _playerMc:MovieClip;
      
      private var _destinationX:int;
      
      private var _carInfo:DrgnBoatCarInfo;
      
      private var _moveTimer:Timer;
      
      private var _nameTxt:FilterFrameText;
      
      private var _buffCountDownList:DictionaryData;
      
      private var _isDispose:Boolean = false;
      
      private var _fightMc:MovieClip;
      
      private var _leapArrow:Bitmap;
      
      private var _tmpTimer:Timer;
      
      private var _bufTime:Number;
      
      public function DrgnBoatGamePlayer(playerInfo:DrgnBoatPlayerInfo)
      {
         var t:int = 0;
         _buffCountDownList = new DictionaryData();
         super();
         _playerInfo = playerInfo;
         if(_playerInfo.carType == 3)
         {
            _carInfo = new DrgnBoatCarInfo();
            _carInfo.type = 3;
            _carInfo.speed = DrgnBoatManager.instance.npcSpeed;
            this.y = 350;
         }
         else
         {
            _carInfo = DrgnBoatManager.instance.dataInfo.carInfo[_playerInfo.carType];
            t = _playerInfo.index >= 2?_playerInfo.index + 1:_playerInfo.index;
            this.y = 200 + 75 * t;
         }
         this.x = 280 + _playerInfo.posX;
         _playerMc = new MovieClip();
         var tmp:Bitmap = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
         tmp.x = -50;
         tmp.y = -100;
         _playerMc.addChild(tmp);
         addChild(_playerMc);
         loadRes();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.game.playerNameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("drgnBoat.playerNameTxt" + _carInfo.type,_playerInfo.name);
         if(_carInfo.type == 3)
         {
            _nameTxt.textColor = 710173;
         }
         else if(_playerInfo.isSelf)
         {
            _nameTxt.textColor = 52479;
         }
         else
         {
            _nameTxt.textColor = 16711680;
         }
         addChild(_nameTxt);
         _fightMc = ComponentFactory.Instance.creat("drgnBoat.playerFighting");
         _fightMc.gotoAndStop(2);
         PositionUtils.setPos(_fightMc,"drgnBoat.gamePlayer.fightMcPos");
         addChild(_fightMc);
         refreshFightMc();
         _leapArrow = ComponentFactory.Instance.creatBitmap("drgnBoat.leapPromptArrow");
         addChild(_leapArrow);
         _leapArrow.visible = false;
         if(_playerInfo.isSelf)
         {
            _moveTimer = new Timer(1000);
            _moveTimer.addEventListener("timer",moveTimerHandler,false,0,true);
            DrgnBoatManager.instance.addEventListener("drgnBoatLeapPromptShowHide",showOrHideLeapArrow);
         }
      }
      
      public function get playerInfo() : DrgnBoatPlayerInfo
      {
         return _playerInfo;
      }
      
      public function set destinationX(value:Number) : void
      {
         _destinationX = value + 280;
         var tmpSpeed:Number = _carInfo.speed;
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            tmpSpeed = tmpSpeed * DrgnBoatManager.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            tmpSpeed = tmpSpeed * DrgnBoatManager.instance.decelerateRate / 100;
         }
         if(_destinationX - x > tmpSpeed * 40)
         {
            x = x + tmpSpeed * 37;
         }
      }
      
      private function loadRes() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(DrgnBoatManager.instance.getPlayerResUrl(_playerInfo.isSelf,_playerInfo.carType),4);
         loader.addEventListener("complete",onLoadComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function onLoadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",onLoadComplete);
         if(_isDispose)
         {
            return;
         }
         if(_playerMc && _playerMc.parent)
         {
            _playerMc.parent.removeChild(_playerMc);
         }
         _playerMc = ComponentFactory.Instance.creat("asset.drgnBoat" + _playerInfo.carType);
         _playerMc.gotoAndPlay("stand");
         addChildAt(_playerMc,0);
         refreshBuffCountDown();
      }
      
      private function moveTimerHandler(event:TimerEvent) : void
      {
         SocketManager.Instance.out.sendEscortMove();
      }
      
      private function showOrHideLeapArrow(event:DrgnBoatEvent) : void
      {
         _leapArrow.visible = event.data.isShow;
      }
      
      public function refreshBuffCountDown() : void
      {
         var tmpBuffCDV:* = null;
         var tmp2:* = null;
         var tmp3:* = null;
         var tmp:* = null;
         var tmp4:* = null;
         var isHasBuff:Boolean = false;
         var now:Date = TimeManager.Instance.Now();
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            if(_playerMc.currentFrameLabel != "moderate")
            {
               _playerMc.gotoAndPlay("moderate");
            }
            isHasBuff = true;
            if(_buffCountDownList.hasKey("2"))
            {
               (_buffCountDownList["2"] as DrgnBoatBuffCountDown).endTime = _playerInfo.deceleEndTime;
            }
            else
            {
               tmpBuffCDV = new DrgnBoatBuffCountDown(_playerInfo.deceleEndTime,2,_buffCountDownList.length);
               tmpBuffCDV.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(tmpBuffCDV);
               _buffCountDownList.add("2",tmpBuffCDV);
            }
         }
         else if(_buffCountDownList.hasKey("2"))
         {
            tmp2 = _buffCountDownList["2"] as DrgnBoatBuffCountDown;
            tmp2.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(tmp2);
            _buffCountDownList.remove(tmp2.type);
         }
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            if(_playerMc.currentFrameLabel != "accelerate")
            {
               _playerMc.gotoAndPlay("accelerate");
            }
            isHasBuff = true;
            if(_buffCountDownList.hasKey("1"))
            {
               (_buffCountDownList["1"] as DrgnBoatBuffCountDown).endTime = _playerInfo.acceleEndTime;
            }
            else
            {
               tmpBuffCDV = new DrgnBoatBuffCountDown(_playerInfo.acceleEndTime,1,_buffCountDownList.length);
               tmpBuffCDV.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(tmpBuffCDV);
               _buffCountDownList.add("1",tmpBuffCDV);
            }
         }
         else if(_buffCountDownList.hasKey("1"))
         {
            tmp3 = _buffCountDownList["1"] as DrgnBoatBuffCountDown;
            tmp3.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(tmp3);
            _buffCountDownList.remove(tmp3.type);
         }
         if(_playerInfo.invisiEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
         {
            if(_playerMc.currentFrameLabel != "transparent")
            {
               _playerMc.gotoAndPlay("transparent");
            }
            isHasBuff = true;
            if(_buffCountDownList.hasKey("3"))
            {
               (_buffCountDownList["3"] as DrgnBoatBuffCountDown).endTime = _playerInfo.invisiEndTime;
            }
            else
            {
               tmpBuffCDV = new DrgnBoatBuffCountDown(_playerInfo.invisiEndTime,3,_buffCountDownList.length);
               tmpBuffCDV.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(tmpBuffCDV);
               _buffCountDownList.add("3",tmpBuffCDV);
            }
         }
         else if(_buffCountDownList.hasKey("3"))
         {
            tmp = _buffCountDownList["3"] as DrgnBoatBuffCountDown;
            tmp.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(tmp);
            _buffCountDownList.remove(tmp.type);
         }
         if(_playerInfo.missileLaunchEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
         {
            if(_playerMc.currentFrameLabel != "beat")
            {
               _playerMc.gotoAndPlay("beat");
            }
            isHasBuff = true;
            _tmpTimer = new Timer(500);
            _bufTime = _playerInfo.missileLaunchEndTime.getTime();
            _tmpTimer.addEventListener("timer",__bufTimerHandler);
            _tmpTimer.start();
         }
         if(_playerInfo.missileEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
         {
            if(_playerInfo.missileHitEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
            {
               if(_playerMc.currentFrameLabel != "cryA")
               {
                  _playerMc.gotoAndPlay("cryA");
               }
               _tmpTimer = new Timer(500);
               _bufTime = _playerInfo.missileHitEndTime.getTime();
               _tmpTimer.addEventListener("timer",__bufTimerHandler);
               _tmpTimer.start();
            }
            else if(_playerMc.currentFrameLabel != "cryC")
            {
               _playerMc.gotoAndPlay("cryC");
            }
            isHasBuff = true;
            if(_buffCountDownList.hasKey("4"))
            {
               (_buffCountDownList["4"] as DrgnBoatBuffCountDown).endTime = _playerInfo.missileEndTime;
            }
            else
            {
               tmpBuffCDV = new DrgnBoatBuffCountDown(_playerInfo.missileEndTime,4,_buffCountDownList.length);
               tmpBuffCDV.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(tmpBuffCDV);
               _buffCountDownList.add("4",tmpBuffCDV);
            }
         }
         else if(_buffCountDownList.hasKey("4"))
         {
            tmp4 = _buffCountDownList["4"] as DrgnBoatBuffCountDown;
            tmp4.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(tmp4);
            _buffCountDownList.remove(tmp4.type);
         }
         if(!isHasBuff)
         {
            if(_playerMc.currentLabel == "cryC")
            {
               _playerMc.gotoAndPlay("cryB");
               _playerMc.addEventListener("enterFrame",__enterFrame);
            }
            else
            {
               _playerMc.gotoAndPlay("stand");
            }
         }
         if(!playerInfo.isSelf)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _buffCountDownList;
            for each(var tmppp in _buffCountDownList)
            {
               tmppp.visible = false;
            }
         }
      }
      
      protected function __enterFrame(event:Event) : void
      {
         if(_playerMc && _playerMc.currentFrame == _playerMc.totalFrames)
         {
            _playerMc.removeEventListener("enterFrame",__enterFrame);
            refreshBuffCountDown();
         }
      }
      
      protected function __bufTimerHandler(event:TimerEvent) : void
      {
         var timer:Timer = event.target as Timer;
         if(_bufTime - TimeManager.Instance.Now().getTime() <= 0)
         {
            timer.stop();
            timer.removeEventListener("timer",__bufTimerHandler);
            timer = null;
            refreshBuffCountDown();
         }
      }
      
      private function buffCountDownEnd(event:Event) : void
      {
         var tmp:DrgnBoatBuffCountDown = event.target as DrgnBoatBuffCountDown;
         tmp.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
         ObjectUtils.disposeObject(tmp);
         _buffCountDownList.remove(tmp.type);
         refreshBuffCountDown();
      }
      
      public function updatePlayer() : void
      {
         var tmpSpeed:Number = _carInfo.speed;
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            tmpSpeed = tmpSpeed * DrgnBoatManager.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            tmpSpeed = tmpSpeed * DrgnBoatManager.instance.decelerateRate / 100;
         }
         if(x < _destinationX)
         {
            x = x + tmpSpeed;
         }
      }
      
      public function refreshFightMc() : void
      {
         if(_playerInfo.fightState == 1)
         {
            _fightMc.gotoAndStop(1);
            if(_moveTimer && _moveTimer.running)
            {
               _moveTimer.stop();
            }
            if(_tmpTimer && _tmpTimer.running)
            {
               _tmpTimer.stop();
            }
         }
         else
         {
            _fightMc.gotoAndStop(2);
            if(_moveTimer && !_moveTimer.running)
            {
               _moveTimer.start();
            }
         }
      }
      
      public function startGame() : void
      {
         if(_playerInfo.isSelf)
         {
            _moveTimer.start();
            moveTimerHandler(null);
         }
      }
      
      public function endGame() : void
      {
         if(_moveTimer && _moveTimer.running)
         {
            _moveTimer.stop();
         }
      }
      
      public function dispose() : void
      {
         DrgnBoatManager.instance.removeEventListener("drgnBoatLeapPromptShowHide",showOrHideLeapArrow);
         if(_playerMc)
         {
            _playerMc.gotoAndStop(_playerMc.totalFrames);
            _playerMc.removeEventListener("enterFrame",__enterFrame);
         }
         if(_fightMc)
         {
            _fightMc.gotoAndStop(2);
         }
         if(_moveTimer)
         {
            _moveTimer.removeEventListener("timer",moveTimerHandler);
            _moveTimer.stop();
         }
         _moveTimer = null;
         if(_tmpTimer)
         {
            _tmpTimer.removeEventListener("timer",__bufTimerHandler);
            _tmpTimer.stop();
         }
         _tmpTimer = null;
         _carInfo = null;
         _playerInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _playerMc = null;
         _nameTxt = null;
         _buffCountDownList = null;
         _fightMc = null;
         _isDispose = true;
      }
   }
}
