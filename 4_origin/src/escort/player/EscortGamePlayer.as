package escort.player
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
   import escort.EscortControl;
   import escort.EscortManager;
   import escort.data.EscortCarInfo;
   import escort.data.EscortPlayerInfo;
   import escort.event.EscortEvent;
   import escort.view.EscortBuffCountDownView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.data.DictionaryData;
   
   public class EscortGamePlayer extends Sprite implements Disposeable
   {
       
      
      private var _playerInfo:EscortPlayerInfo;
      
      private var _playerMc:MovieClip;
      
      private var _destinationX:int;
      
      private var _carInfo:EscortCarInfo;
      
      private var _moveTimer:Timer;
      
      private var _nameTxt:FilterFrameText;
      
      private var _buffCountDownList:DictionaryData;
      
      private var _isDispose:Boolean = false;
      
      private var _fightMc:MovieClip;
      
      private var _leapArrow:Bitmap;
      
      public function EscortGamePlayer(param1:EscortPlayerInfo)
      {
         _buffCountDownList = new DictionaryData();
         super();
         _playerInfo = param1;
         _carInfo = EscortControl.instance.dataInfo.carInfo[_playerInfo.carType];
         this.x = 280 + _playerInfo.posX;
         this.y = 150 + 65 * param1.index;
         _playerMc = new MovieClip();
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
         _loc2_.x = -50;
         _loc2_.y = -100;
         _playerMc.addChild(_loc2_);
         addChild(_playerMc);
         loadRes();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("escort.game.playerNameTxt");
         _nameTxt.text = LanguageMgr.GetTranslation("escort.game.playerNameTxt" + _carInfo.type,_playerInfo.name);
         if(_carInfo.type == 1)
         {
            _nameTxt.textColor = 710173;
         }
         else if(_carInfo.type == 2)
         {
            _nameTxt.textColor = 16711680;
         }
         addChild(_nameTxt);
         _fightMc = ComponentFactory.Instance.creat("asset.escort.playerFighting");
         _fightMc.gotoAndStop(2);
         PositionUtils.setPos(_fightMc,"escort.gamePlayer.fightMcPos");
         addChild(_fightMc);
         refreshFightMc();
         _leapArrow = ComponentFactory.Instance.creatBitmap("asset.escort.leapPromptArrow");
         addChild(_leapArrow);
         _leapArrow.visible = false;
         if(_playerInfo.isSelf)
         {
            _moveTimer = new Timer(1000);
            _moveTimer.addEventListener("timer",moveTimerHandler,false,0,true);
            EscortManager.instance.addEventListener("escortLeapPromptShowHide",showOrHideLeapArrow);
         }
      }
      
      public function get playerInfo() : EscortPlayerInfo
      {
         return _playerInfo;
      }
      
      public function set destinationX(param1:Number) : void
      {
         _destinationX = param1 + 280;
         var _loc2_:Number = _carInfo.speed;
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc2_ = _loc2_ * EscortControl.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc2_ = _loc2_ * EscortControl.instance.decelerateRate / 100;
         }
         if(_destinationX - x > _loc2_ * 30)
         {
            x = x + _loc2_ * 25;
         }
      }
      
      private function loadRes() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(EscortManager.instance.getPlayerResUrl(_playerInfo.isSelf,_playerInfo.carType),4);
         _loc1_.addEventListener("complete",onLoadComplete);
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function onLoadComplete(param1:LoaderEvent) : void
      {
         var _loc2_:* = null;
         param1.loader.removeEventListener("complete",onLoadComplete);
         if(_isDispose)
         {
            return;
         }
         if(_playerMc && _playerMc.parent)
         {
            _playerMc.parent.removeChild(_playerMc);
         }
         if(_playerInfo.isSelf)
         {
            _loc2_ = "self";
         }
         else
         {
            _loc2_ = "other";
         }
         _playerMc = ComponentFactory.Instance.creat("asset.escort." + _loc2_ + _playerInfo.carType);
         _playerMc.gotoAndPlay("stand");
         addChildAt(_playerMc,0);
         refreshBuffCountDown();
      }
      
      private function moveTimerHandler(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.sendEscortMove();
      }
      
      private function showOrHideLeapArrow(param1:EscortEvent) : void
      {
         _leapArrow.visible = param1.data.isShow;
      }
      
      public function refreshBuffCountDown() : void
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc1_:Boolean = false;
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _playerMc.gotoAndPlay("moderate");
            _loc1_ = true;
            if(_buffCountDownList.hasKey("2"))
            {
               (_buffCountDownList["2"] as EscortBuffCountDownView).endTime = _playerInfo.deceleEndTime;
            }
            else
            {
               _loc5_ = new EscortBuffCountDownView(_playerInfo.deceleEndTime,2,_buffCountDownList.length);
               _loc5_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc5_);
               _buffCountDownList.add("2",_loc5_);
            }
         }
         else if(_buffCountDownList.hasKey("2"))
         {
            _loc2_ = _buffCountDownList["2"] as EscortBuffCountDownView;
            _loc2_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(_loc2_);
            _buffCountDownList.remove(_loc2_.type);
         }
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _playerMc.gotoAndPlay("accelerate");
            _loc1_ = true;
            if(_buffCountDownList.hasKey("1"))
            {
               (_buffCountDownList["1"] as EscortBuffCountDownView).endTime = _playerInfo.acceleEndTime;
            }
            else
            {
               _loc5_ = new EscortBuffCountDownView(_playerInfo.acceleEndTime,1,_buffCountDownList.length);
               _loc5_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc5_);
               _buffCountDownList.add("1",_loc5_);
            }
         }
         else if(_buffCountDownList.hasKey("1"))
         {
            _loc3_ = _buffCountDownList["1"] as EscortBuffCountDownView;
            _loc3_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(_loc3_);
            _buffCountDownList.remove(_loc3_.type);
         }
         if(_playerInfo.invisiEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
         {
            _playerMc.gotoAndPlay("transparent");
            _loc1_ = true;
            if(_buffCountDownList.hasKey("3"))
            {
               (_buffCountDownList["3"] as EscortBuffCountDownView).endTime = _playerInfo.invisiEndTime;
            }
            else
            {
               _loc5_ = new EscortBuffCountDownView(_playerInfo.invisiEndTime,3,_buffCountDownList.length);
               _loc5_.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(_loc5_);
               _buffCountDownList.add("3",_loc5_);
            }
         }
         else if(_buffCountDownList.hasKey("3"))
         {
            _loc4_ = _buffCountDownList["3"] as EscortBuffCountDownView;
            _loc4_.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(_loc4_);
            _buffCountDownList.remove(_loc4_.type);
         }
         if(!_loc1_)
         {
            _playerMc.gotoAndPlay("stand");
         }
         if(!playerInfo.isSelf)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _buffCountDownList;
            for each(var _loc6_ in _buffCountDownList)
            {
               _loc6_.visible = false;
            }
         }
      }
      
      private function buffCountDownEnd(param1:Event) : void
      {
         var _loc2_:EscortBuffCountDownView = param1.target as EscortBuffCountDownView;
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
            _loc1_ = _loc1_ * EscortControl.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _loc1_ = _loc1_ * EscortControl.instance.decelerateRate / 100;
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
         EscortManager.instance.removeEventListener("escortLeapPromptShowHide",showOrHideLeapArrow);
         if(_playerMc)
         {
            _playerMc.gotoAndStop(_playerMc.totalFrames);
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
