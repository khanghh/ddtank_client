package ddtKingFloat.player
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
   import ddtKingFloat.DDTKingFloatEvent;
   import ddtKingFloat.DDTKingFloatManager;
   import ddtKingFloat.data.DDTKingFloatCarInfo;
   import ddtKingFloat.data.DDTKingFloatPlayerInfo;
   import ddtKingFloat.views.DDTKingFloatBuffCountDown;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class DDTKingFloatGamePlayer extends Sprite implements Disposeable
   {
       
      
      private var _playerInfo:DDTKingFloatPlayerInfo;
      
      private var _playerMc:MovieClip;
      
      private var _destinationX:int;
      
      private var _carInfo:DDTKingFloatCarInfo;
      
      private var _moveTimer:Timer;
      
      private var _nameTxt:FilterFrameText;
      
      private var _buffCountDownList:DictionaryData;
      
      private var _isDispose:Boolean = false;
      
      private var _fightMc:MovieClip;
      
      private var _leapArrow:Bitmap;
      
      private var _tmpTimer:Timer;
      
      private var _bufTime:Number;
      
      public function DDTKingFloatGamePlayer(param1:DDTKingFloatPlayerInfo)
      {
         var _loc2_:int = 0;
         _buffCountDownList = new DictionaryData();
         super();
         _playerInfo = param1;
         if(_playerInfo.carType == 3)
         {
            _carInfo = new DDTKingFloatCarInfo();
            _carInfo.type = 3;
            _carInfo.speed = DDTKingFloatManager.instance.npcSpeed;
            this.y = 330;
         }
         else
         {
            _carInfo = DDTKingFloatManager.instance.dataInfo.carInfo[_playerInfo.carType];
            _loc2_ = _playerInfo.index >= 2?_playerInfo.index + 1:_playerInfo.index;
            this.y = 200 + 65 * _loc2_;
         }
         this.x = 280 + _playerInfo.posX;
         _playerMc = new MovieClip();
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
         _loc3_.x = -50;
         _loc3_.y = -100;
         _playerMc.addChild(_loc3_);
         addChild(_playerMc);
         loadRes();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.game.playerNameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("ddtKing.playerNameTxt" + _carInfo.type,_playerInfo.name);
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
         _fightMc = ComponentFactory.Instance.creat("ddtKing.playerFighting");
         _fightMc.gotoAndStop(2);
         PositionUtils.setPos(_fightMc,"ddtKing.gamePlayer.fightMcPos");
         addChild(_fightMc);
         refreshFightMc();
         _leapArrow = ComponentFactory.Instance.creatBitmap("ddtKing.leapPromptArrow");
         addChild(_leapArrow);
         _leapArrow.visible = false;
         if(_playerInfo.isSelf)
         {
            _moveTimer = new Timer(1000);
            _moveTimer.addEventListener("timer",moveTimerHandler,false,0,true);
            DDTKingFloatManager.instance.addEventListener("floatParadeLeapPromptShowHide",showOrHideLeapArrow);
         }
      }
      
      public function get playerInfo() : DDTKingFloatPlayerInfo
      {
         return _playerInfo;
      }
      
      public function set destinationX(param1:Number) : void
      {
         _destinationX = param1 + 280;
         var _loc2_:Number = _carInfo.speed;
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc2_ = _loc2_ * DDTKingFloatManager.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc2_ = _loc2_ * DDTKingFloatManager.instance.decelerateRate / 100;
         }
         if(_destinationX - x > _loc2_ * 40)
         {
            x = x + _loc2_ * 37;
         }
      }
      
      private function loadRes() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(DDTKingFloatManager.instance.getPlayerResUrl(_playerInfo.isSelf,_playerInfo.carType),4);
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
         _playerMc = ComponentFactory.Instance.creat("asset.floatParade" + _playerInfo.carType);
         _playerMc.gotoAndPlay("stand");
         addChildAt(_playerMc,0);
         refreshBuffCountDown();
      }
      
      private function moveTimerHandler(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.sendEscortMove();
      }
      
      private function showOrHideLeapArrow(param1:DDTKingFloatEvent) : void
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
               (_buffCountDownList["2"] as DDTKingFloatBuffCountDown).endTime = _playerInfo.deceleEndTime;
            }
            else
            {
               _loc7_ = new DDTKingFloatBuffCountDown(_playerInfo.deceleEndTime,2,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("2",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("2"))
         {
            _loc2_ = _buffCountDownList["2"] as DDTKingFloatBuffCountDown;
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
               (_buffCountDownList["1"] as DDTKingFloatBuffCountDown).endTime = _playerInfo.acceleEndTime;
            }
            else
            {
               _loc7_ = new DDTKingFloatBuffCountDown(_playerInfo.acceleEndTime,1,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("1",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("1"))
         {
            _loc4_ = _buffCountDownList["1"] as DDTKingFloatBuffCountDown;
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
               (_buffCountDownList["3"] as DDTKingFloatBuffCountDown).endTime = _playerInfo.invisiEndTime;
            }
            else
            {
               _loc7_ = new DDTKingFloatBuffCountDown(_playerInfo.invisiEndTime,3,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("3",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("3"))
         {
            _loc6_ = _buffCountDownList["3"] as DDTKingFloatBuffCountDown;
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
         var _loc8_:Date = TimeManager.Instance.Now();
         if(_playerInfo.missileEndTime.getTime() - _loc8_.getTime() > 0)
         {
            if(_playerInfo.missileHitEndTime.getTime() - _loc8_.getTime() > 0)
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
               (_buffCountDownList["4"] as DDTKingFloatBuffCountDown).endTime = _playerInfo.missileEndTime;
            }
            else
            {
               _loc7_ = new DDTKingFloatBuffCountDown(_playerInfo.missileEndTime,4,_buffCountDownList.length);
               _loc7_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc7_);
               _buffCountDownList.add("4",_loc7_);
            }
         }
         else if(_buffCountDownList.hasKey("4"))
         {
            _loc3_ = _buffCountDownList["4"] as DDTKingFloatBuffCountDown;
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
            var _loc11_:int = 0;
            var _loc10_:* = _buffCountDownList;
            for each(var _loc9_ in _buffCountDownList)
            {
               _loc9_.visible = false;
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
         var _loc2_:DDTKingFloatBuffCountDown = param1.target as DDTKingFloatBuffCountDown;
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
            _loc1_ = _loc1_ * DDTKingFloatManager.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc1_ = _loc1_ * DDTKingFloatManager.instance.decelerateRate / 100;
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
         DDTKingFloatManager.instance.removeEventListener("floatParadeLeapPromptShowHide",showOrHideLeapArrow);
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
