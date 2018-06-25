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
      
      public function EscortGamePlayer(playerInfo:EscortPlayerInfo)
      {
         _buffCountDownList = new DictionaryData();
         super();
         _playerInfo = playerInfo;
         _carInfo = EscortControl.instance.dataInfo.carInfo[_playerInfo.carType];
         this.x = 280 + _playerInfo.posX;
         this.y = 150 + 65 * playerInfo.index;
         _playerMc = new MovieClip();
         var tmp:Bitmap = ComponentFactory.Instance.creatBitmap("game.player.defaultPlayerCharacter");
         tmp.x = -50;
         tmp.y = -100;
         _playerMc.addChild(tmp);
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
      
      public function set destinationX(value:Number) : void
      {
         _destinationX = value + 280;
         var tmpSpeed:Number = _carInfo.speed;
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            tmpSpeed = tmpSpeed * EscortControl.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            tmpSpeed = tmpSpeed * EscortControl.instance.decelerateRate / 100;
         }
         if(_destinationX - x > tmpSpeed * 30)
         {
            x = x + tmpSpeed * 25;
         }
      }
      
      private function loadRes() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(EscortManager.instance.getPlayerResUrl(_playerInfo.isSelf,_playerInfo.carType),4);
         loader.addEventListener("complete",onLoadComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function onLoadComplete(event:LoaderEvent) : void
      {
         var tmpStr:* = null;
         event.loader.removeEventListener("complete",onLoadComplete);
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
            tmpStr = "self";
         }
         else
         {
            tmpStr = "other";
         }
         _playerMc = ComponentFactory.Instance.creat("asset.escort." + tmpStr + _playerInfo.carType);
         _playerMc.gotoAndPlay("stand");
         addChildAt(_playerMc,0);
         refreshBuffCountDown();
      }
      
      private function moveTimerHandler(event:TimerEvent) : void
      {
         SocketManager.Instance.out.sendEscortMove();
      }
      
      private function showOrHideLeapArrow(event:EscortEvent) : void
      {
         _leapArrow.visible = event.data.isShow;
      }
      
      public function refreshBuffCountDown() : void
      {
         var tmpBuffCDV:* = null;
         var tmp2:* = null;
         var tmp3:* = null;
         var tmp:* = null;
         var isHasBuff:Boolean = false;
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _playerMc.gotoAndPlay("moderate");
            isHasBuff = true;
            if(_buffCountDownList.hasKey("2"))
            {
               (_buffCountDownList["2"] as EscortBuffCountDownView).endTime = _playerInfo.deceleEndTime;
            }
            else
            {
               tmpBuffCDV = new EscortBuffCountDownView(_playerInfo.deceleEndTime,2,_buffCountDownList.length);
               tmpBuffCDV.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(tmpBuffCDV);
               _buffCountDownList.add("2",tmpBuffCDV);
            }
         }
         else if(_buffCountDownList.hasKey("2"))
         {
            tmp2 = _buffCountDownList["2"] as EscortBuffCountDownView;
            tmp2.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(tmp2);
            _buffCountDownList.remove(tmp2.type);
         }
         if(_playerInfo.acceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            _playerMc.gotoAndPlay("accelerate");
            isHasBuff = true;
            if(_buffCountDownList.hasKey("1"))
            {
               (_buffCountDownList["1"] as EscortBuffCountDownView).endTime = _playerInfo.acceleEndTime;
            }
            else
            {
               tmpBuffCDV = new EscortBuffCountDownView(_playerInfo.acceleEndTime,1,_buffCountDownList.length);
               tmpBuffCDV.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(tmpBuffCDV);
               _buffCountDownList.add("1",tmpBuffCDV);
            }
         }
         else if(_buffCountDownList.hasKey("1"))
         {
            tmp3 = _buffCountDownList["1"] as EscortBuffCountDownView;
            tmp3.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(tmp3);
            _buffCountDownList.remove(tmp3.type);
         }
         if(_playerInfo.invisiEndTime.getTime() - TimeManager.Instance.Now().getTime() > 0)
         {
            _playerMc.gotoAndPlay("transparent");
            isHasBuff = true;
            if(_buffCountDownList.hasKey("3"))
            {
               (_buffCountDownList["3"] as EscortBuffCountDownView).endTime = _playerInfo.invisiEndTime;
            }
            else
            {
               tmpBuffCDV = new EscortBuffCountDownView(_playerInfo.invisiEndTime,3,_buffCountDownList.length);
               tmpBuffCDV.addEventListener("EscortBuffCountDownEnd",buffCountDownEnd,false,0,true);
               addChild(tmpBuffCDV);
               _buffCountDownList.add("3",tmpBuffCDV);
            }
         }
         else if(_buffCountDownList.hasKey("3"))
         {
            tmp = _buffCountDownList["3"] as EscortBuffCountDownView;
            tmp.removeEventListener("EscortBuffCountDownEnd",buffCountDownEnd);
            ObjectUtils.disposeObject(tmp);
            _buffCountDownList.remove(tmp.type);
         }
         if(!isHasBuff)
         {
            _playerMc.gotoAndPlay("stand");
         }
         if(!playerInfo.isSelf)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _buffCountDownList;
            for each(var tmppp in _buffCountDownList)
            {
               tmppp.visible = false;
            }
         }
      }
      
      private function buffCountDownEnd(event:Event) : void
      {
         var tmp:EscortBuffCountDownView = event.target as EscortBuffCountDownView;
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
            tmpSpeed = tmpSpeed * EscortControl.instance.accelerateRate / 100;
         }
         if(_playerInfo.deceleEndTime.getTime() > TimeManager.Instance.Now().getTime())
         {
            tmpSpeed = tmpSpeed * EscortControl.instance.decelerateRate / 100;
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
