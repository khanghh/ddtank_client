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
      
      public function DrgnBoatGamePlayer(param1:DrgnBoatPlayerInfo)
      {
         var _loc2_:int = 0;
         _buffCountDownList = new DictionaryData();
         super();
         _playerInfo = param1;
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
            _loc2_ = _playerInfo.index >= 2?_playerInfo.index + 1:_playerInfo.index;
            this.y = 200 + 75 * _loc2_;
         }
         this.x = 280 + _playerInfo.posX;
         _playerMc = new MovieClip();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
         _loc3_.x = -50;
         _loc3_.y = -100;
         _playerMc.addChild(_loc3_);
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
      
      public function set destinationX(param1:Number) : void
      {
         _destinationX = param1 + 280;
         var _loc2_:Number = _carInfo.speed;
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc2_ = _loc2_ * DrgnBoatManager.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc2_ = _loc2_ * DrgnBoatManager.instance.decelerateRate / 100;
         }
         if(_destinationX - x > _loc2_ * 40)
         {
            x = x + _loc2_ * 37;
         }
      }
      
      private function loadRes() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(DrgnBoatManager.instance.getPlayerResUrl(_playerInfo.isSelf,_playerInfo.carType),4);
         _loc1_.addEventListener("complete",onLoadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function onLoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",onLoadComplete);
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
      
      private function moveTimerHandler(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.sendEscortMove();
      }
      
      private function showOrHideLeapArrow(param1:DrgnBoatEvent) : void
      {
         _leapArrow.visible = param1.data.isShow;
      }
      
      public function refreshBuffCountDown() : void
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc1_:Boolean = false;
         var _loc5_:Date = TimeManager.Instance.Now();
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            if(_playerMc.currentFrameLabel != "moderate")
            {
               _playerMc.gotoAndPlay("moderate");
            }
            _loc1_ = true;
            if(_buffCountDownList.hasKey("2"))
            {
               (_buffCountDownList["2"] as DrgnBoatBuffCountDown).endTime = _playerInfo.deceleEndTime;
            }
            else
            {
               _loc7_ = new DrgnBoatBuffCountDown(_playerInfo.deceleEndTime,2,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("2",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("2"))
         {
            _loc2_ = _buffCountDownList["2"] as DrgnBoatBuffCountDown;
            _loc2_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(_loc2_);
            _buffCountDownList.remove(_loc2_.type);
         }
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            if(_playerMc.currentFrameLabel != "accelerate")
            {
               _playerMc.gotoAndPlay("accelerate");
            }
            _loc1_ = true;
            if(_buffCountDownList.hasKey("1"))
            {
               (_buffCountDownList["1"] as DrgnBoatBuffCountDown).endTime = _playerInfo.acceleEndTime;
            }
            else
            {
               _loc7_ = new DrgnBoatBuffCountDown(_playerInfo.acceleEndTime,1,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("1",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("1"))
         {
            _loc4_ = _buffCountDownList["1"] as DrgnBoatBuffCountDown;
            _loc4_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(_loc4_);
            _buffCountDownList.remove(_loc4_.type);
         }
         if(_playerInfo.invisiEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
         {
            if(_playerMc.currentFrameLabel != "transparent")
            {
               _playerMc.gotoAndPlay("transparent");
            }
            _loc1_ = true;
            if(_buffCountDownList.hasKey("3"))
            {
               (_buffCountDownList["3"] as DrgnBoatBuffCountDown).endTime = _playerInfo.invisiEndTime;
            }
            else
            {
               _loc7_ = new DrgnBoatBuffCountDown(_playerInfo.invisiEndTime,3,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("3",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("3"))
         {
            _loc6_ = _buffCountDownList["3"] as DrgnBoatBuffCountDown;
            _loc6_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(_loc6_);
            _buffCountDownList.remove(_loc6_.type);
         }
         if(_playerInfo.missileLaunchEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
         {
            if(_playerMc.currentFrameLabel != "beat")
            {
               _playerMc.gotoAndPlay("beat");
            }
            _loc1_ = true;
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
            _loc1_ = true;
            if(_buffCountDownList.hasKey("4"))
            {
               (_buffCountDownList["4"] as DrgnBoatBuffCountDown).endTime = _playerInfo.missileEndTime;
            }
            else
            {
               _loc7_ = new DrgnBoatBuffCountDown(_playerInfo.missileEndTime,4,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("4",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("4"))
         {
            _loc3_ = _buffCountDownList["4"] as DrgnBoatBuffCountDown;
            _loc3_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(_loc3_);
            _buffCountDownList.remove(_loc3_.type);
         }
         if(!_loc1_)
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
            for each(var _loc8_ in _buffCountDownList)
            {
               _loc8_.visible = false;
            }
         }
      }
      
      protected function __enterFrame(param1:Event) : void
      {
         if(_playerMc && _playerMc.currentFrame == _playerMc.totalFrames)
         {
            _playerMc.removeEventListener("enterFrame",__enterFrame);
            refreshBuffCountDown();
         }
      }
      
      protected function __bufTimerHandler(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.target as Timer;
         if(_bufTime - TimeManager.Instance.Now().getTime() <= 0)
         {
            _loc2_.stop();
            _loc2_.removeEventListener("timer",__bufTimerHandler);
            _loc2_ = null;
            refreshBuffCountDown();
         }
      }
      
      private function buffCountDownEnd(param1:Event) : void
      {
         var _loc2_:DrgnBoatBuffCountDown = param1.target as DrgnBoatBuffCountDown;
         _loc2_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
         ObjectUtils.disposeObject(_loc2_);
         _buffCountDownList.remove(_loc2_.type);
         refreshBuffCountDown();
      }
      
      public function updatePlayer() : void
      {
         var _loc1_:Number = _carInfo.speed;
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc1_ = _loc1_ * DrgnBoatManager.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc1_ = _loc1_ * DrgnBoatManager.instance.decelerateRate / 100;
         }
         if(x < _destinationX)
         {
            x = x + _loc1_;
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
