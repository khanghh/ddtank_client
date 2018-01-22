package floatParade.views
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import floatParade.FloatParadeEvent;
   import floatParade.FloatParadeManager;
   import floatParade.components.FloatParadeNPCpaopao;
   import floatParade.data.FloatParadeCarInfo;
   import floatParade.data.FloatParadePlayerInfo;
   import floatParade.player.FloatParadeGameItem;
   import floatParade.player.FloatParadeGamePlayer;
   import road7th.data.DictionaryData;
   
   public class FloatParadeMapView extends Sprite implements Disposeable
   {
      
      public static const LEN:int = 33600;
      
      public static const INIT_X:int = 280;
       
      
      private var _mapLayer:Sprite;
      
      private var _playerLayer:Sprite;
      
      private var _playerList:Vector.<FloatParadeGamePlayer>;
      
      private var _selfPlayer:FloatParadeGamePlayer;
      
      private var _itemList:DictionaryData;
      
      private var _playerItemList:Array;
      
      private var _rankArriveList:Array;
      
      private var _needRankList:DictionaryData;
      
      private var _isStartGame:Boolean = false;
      
      private var _mapBitmapData:BitmapData;
      
      private var _startMc:MovieClip;
      
      private var _endMc:MovieClip;
      
      private var _boguArr:Array;
      
      private var _finishTag:Bitmap;
      
      private var _runPercent:FloatParadeRunPercent;
      
      private var _arriveCountDown:FloatParadeArriveCountDown;
      
      private var _npcArriveTime:Date;
      
      private var _npcPlayer:FloatParadeGamePlayer;
      
      private var _paopaoView:FloatParadeNPCpaopao;
      
      private var _enterFrameCount:int = 0;
      
      private var _secondCount:int = 0;
      
      private var _beyondNPC:Boolean;
      
      private var _endFlag:Boolean = false;
      
      private var _isTween:Boolean = false;
      
      public function FloatParadeMapView()
      {
         _itemList = new DictionaryData();
         _playerItemList = [];
         _rankArriveList = [];
         super();
         initView();
         initEvent();
      }
      
      public function set runPercent(param1:FloatParadeRunPercent) : void
      {
         _runPercent = param1;
      }
      
      public function set arriveCountDown(param1:FloatParadeArriveCountDown) : void
      {
         _arriveCountDown = param1;
      }
      
      private function initView() : void
      {
         initMapLayer();
         initPlayer();
      }
      
      private function initMapLayer() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _mapLayer = new Sprite();
         addChild(_mapLayer);
         _mapBitmapData = ComponentFactory.Instance.creatBitmapData("floatParade.mapBg");
         var _loc3_:int = Math.ceil(33600 / 1589);
         _loc4_ = 0;
         while(_loc4_ <= _loc3_)
         {
            _loc2_ = new Bitmap(_mapBitmapData);
            _loc2_.x = _loc4_ * 1589;
            _mapLayer.addChild(_loc2_);
            _loc4_++;
         }
         _startMc = ComponentFactory.Instance.creat("floatParade.StartEndTagMC");
         _startMc.gotoAndStop(1);
         _startMc.x = 280;
         _startMc.y = 174;
         _endMc = ComponentFactory.Instance.creat("floatParade.StartEndTagMC");
         _endMc.gotoAndStop(1);
         _endMc.x = 280 + 33600;
         _endMc.y = 174;
         _boguArr = [];
         _loc4_ = 0;
         while(_loc4_ <= 2)
         {
            _loc1_ = ComponentFactory.Instance.creat("floatParade.bogu" + _loc4_);
            _loc1_.gotoAndPlay(1);
            _loc1_.x = 300 + _loc4_ * 1000;
            _loc1_.y = 178;
            _boguArr.push(_loc1_);
            _mapLayer.addChild(_loc1_);
            _loc4_++;
         }
         _mapLayer.addChild(_startMc);
         _mapLayer.addChild(_endMc);
      }
      
      private function initPlayer() : void
      {
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _playerLayer = new Sprite();
         addChild(_playerLayer);
         var _loc3_:Vector.<FloatParadePlayerInfo> = FloatParadeManager.instance.playerList;
         if(!_loc3_)
         {
            return;
         }
         _playerList = new Vector.<FloatParadeGamePlayer>();
         _needRankList = new DictionaryData();
         var _loc4_:int = _loc3_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc8_];
            _loc1_ = new FloatParadeGamePlayer(_loc2_);
            _playerLayer.addChild(_loc1_);
            _playerList.push(_loc1_);
            _playerItemList.push(_loc1_);
            _needRankList.add(_loc8_.toString(),_loc8_);
            if(_loc2_.isSelf)
            {
               _selfPlayer = _loc1_;
               FloatParadeManager.instance.selfPlayer = _selfPlayer;
            }
            _loc8_++;
         }
         var _loc7_:FloatParadePlayerInfo = new FloatParadePlayerInfo();
         _loc7_.carType = 3;
         _loc7_.name = "巴罗夫";
         if(_npcArriveTime)
         {
            _loc6_ = ServerConfigManager.instance.dragonBoatFastTime * 1000;
            _loc5_ = _npcArriveTime.getTime() - TimeManager.Instance.Now().getTime();
            _loc5_ = _loc5_ > 0?_loc5_:0;
            _loc7_.posX = 280 + 33600 - _loc5_ / _loc6_ * 33600;
         }
         _npcPlayer = new FloatParadeGamePlayer(_loc7_);
         _playerLayer.addChild(_npcPlayer);
         _playerList.push(_npcPlayer);
         _playerItemList.push(_npcPlayer);
         _needRankList.add(_loc8_.toString(),_loc8_);
         playerItemDepth();
         refreshNeedRankList();
         setCenter(false);
      }
      
      private function initEvent() : void
      {
         addEventListener("enterFrame",updateMap,false,0,true);
         FloatParadeManager.instance.addEventListener("floatParadeMove",moveHandler);
         FloatParadeManager.instance.addEventListener("floatParadeAppearItem",refreshItemHandler);
         FloatParadeManager.instance.addEventListener("floatParadeRefreshBuff",refreshBuffHandler);
         FloatParadeManager.instance.addEventListener("floatParadeUseSkill",useSkillHandler);
         FloatParadeManager.instance.addEventListener("launchMissile",playLaunchMcHandler);
         FloatParadeManager.instance.addEventListener("floatParadeReEnterAllInfo",createPlayerHandler);
         FloatParadeManager.instance.addEventListener("floatParadeFightStateChange",playerFightStateChangeHandler);
         FloatParadeManager.instance.addEventListener("",rankArriveListChangeHandler);
      }
      
      private function rankArriveListChangeHandler(param1:FloatParadeEvent) : void
      {
         _rankArriveList = param1.data as Array;
         refreshNeedRankList();
      }
      
      private function refreshNeedRankList() : void
      {
         if(!_playerList || !_rankArriveList)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _needRankList;
         for each(var _loc2_ in _needRankList)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _rankArriveList;
            for each(var _loc3_ in _rankArriveList)
            {
               if(_loc3_.id == _playerList[_loc2_].playerInfo.id && _loc3_.zoneId == _playerList[_loc2_].playerInfo.zoneId)
               {
                  _loc4_.push(_loc2_);
                  break;
               }
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = _loc4_;
         for each(var _loc1_ in _loc4_)
         {
            _needRankList.remove(_loc1_.toString());
         }
      }
      
      private function updateRankList() : void
      {
         var _loc5_:int = 0;
         if(!_playerList)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _needRankList;
         for each(var _loc6_ in _needRankList)
         {
            _loc2_.push(_playerList[_loc6_]);
         }
         _loc2_.sortOn("x",16 | 2);
         var _loc1_:Array = [];
         var _loc4_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc1_.push({
               "name":_loc2_[_loc5_].playerInfo.name,
               "carType":_loc2_[_loc5_].playerInfo.carType,
               "isSelf":_loc2_[_loc5_].playerInfo.isSelf
            });
            _loc5_++;
         }
         var _loc3_:FloatParadeEvent = new FloatParadeEvent("floatParadeRankList");
         _loc3_.data = _rankArriveList.concat(_loc1_);
         FloatParadeManager.instance.dispatchEvent(_loc3_);
      }
      
      private function playerFightStateChangeHandler(param1:FloatParadeEvent) : void
      {
         var _loc2_:Object = param1.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var _loc3_ in _playerList)
         {
            if(_loc3_.playerInfo.zoneId == _loc2_.zoneId && _loc3_.playerInfo.id == _loc2_.id)
            {
               _loc3_.playerInfo.fightState = _loc2_.fightState;
               _loc3_.refreshFightMc();
               _loc3_.x = _loc2_.posX + 280;
               break;
            }
         }
      }
      
      private function createPlayerHandler(param1:Event) : void
      {
         initPlayer();
      }
      
      private function useSkillHandler(param1:FloatParadeEvent) : void
      {
         var _loc2_:Object = param1.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var _loc3_ in _playerList)
         {
            if(_loc3_.playerInfo.zoneId == _loc2_.zoneId && _loc3_.playerInfo.id == _loc2_.id)
            {
               if(_loc2_.sound)
               {
                  SoundManager.instance.play("escort04");
               }
               _loc3_.x = _loc2_.leapX + 280;
               break;
            }
         }
      }
      
      private function refreshBuffHandler(param1:FloatParadeEvent) : void
      {
         var _loc2_:Object = param1.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var _loc3_ in _playerList)
         {
            if(_loc3_.playerInfo.zoneId == _loc2_.zoneId && _loc3_.playerInfo.id == _loc2_.id)
            {
               if(_loc3_.playerInfo.isSelf)
               {
                  if((_loc2_.acceleEndTime as Date).getTime() - _loc3_.playerInfo.acceleEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("escort01");
                  }
                  if((_loc2_.deceleEndTime as Date).getTime() - _loc3_.playerInfo.deceleEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("escort02");
                  }
                  else if((_loc2_.deceleEndTime as Date).getTime() - _loc3_.playerInfo.deceleEndTime.getTime() < -1000)
                  {
                     SoundManager.instance.play("escort05");
                  }
                  if((_loc2_.invisiEndTime as Date).getTime() - _loc3_.playerInfo.invisiEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("escort03");
                  }
                  if((_loc2_.missileEndTime as Date).getTime() - _loc3_.playerInfo.missileEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("087");
                  }
                  else if((_loc2_.missileEndTime as Date).getTime() - _loc3_.playerInfo.missileEndTime.getTime() < -1000)
                  {
                     SoundManager.instance.play("escort05");
                  }
               }
               _loc3_.playerInfo.acceleEndTime = _loc2_.acceleEndTime;
               _loc3_.playerInfo.deceleEndTime = _loc2_.deceleEndTime;
               _loc3_.playerInfo.invisiEndTime = _loc2_.invisiEndTime;
               _loc3_.playerInfo.missileEndTime = _loc2_.missileEndTime;
               _loc3_.playerInfo.missileHitEndTime = new Date(TimeManager.Instance.Now().getTime() + 1000);
               _loc3_.refreshBuffCountDown();
               break;
            }
         }
      }
      
      private function refreshItemHandler(param1:FloatParadeEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc2_:Object = param1.data;
         var _loc6_:Array = _loc2_.itemList;
         var _loc9_:int = 0;
         var _loc8_:* = _loc6_;
         for each(var _loc5_ in _loc6_)
         {
            _loc4_ = _itemList[_loc5_.index];
            ObjectUtils.disposeObject(_loc4_);
            if(_loc4_)
            {
               _playerItemList.splice(_playerItemList.indexOf(_loc4_),1);
            }
            _loc3_ = _loc5_.tag;
            if(_loc3_ == 0)
            {
               _itemList.remove(_loc5_.index);
            }
            else
            {
               _loc7_ = new FloatParadeGameItem(_loc5_.index,_loc5_.type,_loc5_.posX);
               _playerLayer.addChild(_loc7_);
               _itemList.add(_loc5_.index,_loc7_);
               _playerItemList.push(_loc7_);
            }
         }
         playerItemDepth();
      }
      
      private function playerItemDepth() : void
      {
         var _loc2_:int = 0;
         _playerItemList.sortOn("y",16);
         var _loc1_:int = _playerItemList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _playerLayer.addChild(_playerItemList[_loc2_]);
            _loc2_++;
         }
      }
      
      private function moveHandler(param1:FloatParadeEvent) : void
      {
         var _loc2_:Object = param1.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var _loc3_ in _playerList)
         {
            if(_loc3_.playerInfo.zoneId == _loc2_.zoneId && _loc3_.playerInfo.id == _loc2_.id)
            {
               _loc3_.destinationX = _loc2_.destX;
               break;
            }
         }
      }
      
      private function updateMap(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         if(!_isStartGame)
         {
            return;
         }
         _enterFrameCount = Number(_enterFrameCount) + 1;
         if(_enterFrameCount > 25)
         {
            updateRankList();
            calibrateNpcPos();
            _enterFrameCount = 0;
            _secondCount = Number(_secondCount) + 1;
            if(_secondCount % 60 == 0)
            {
               if(!_beyondNPC && !_endFlag)
               {
                  npcChat(LanguageMgr.GetTranslation("floatParade.npc.beyond"),1);
               }
            }
         }
         if(_npcPlayer.x >= 280 + 33600)
         {
            if(!_endFlag)
            {
               if(_beyondNPC)
               {
                  npcChat(LanguageMgr.GetTranslation("floatParade.npc.loseEnd"),1);
               }
               else
               {
                  npcChat(LanguageMgr.GetTranslation("floatParade.npc.winEnd"),1);
               }
               _endFlag = true;
            }
         }
         else
         {
            _npcPlayer.x = _npcPlayer.x + FloatParadeManager.instance.npcSpeed;
         }
         var _loc2_:Boolean = false;
         var _loc7_:int = 0;
         var _loc6_:* = _playerList;
         for each(var _loc4_ in _playerList)
         {
            _loc4_.updatePlayer();
            if(_loc4_.x > _npcPlayer.x)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_ && !_beyondNPC && !_endFlag)
         {
            npcChat(LanguageMgr.GetTranslation("floatParade.npc.beyonded"));
         }
         _beyondNPC = _loc2_;
         setCenter();
         if(_selfPlayer.x >= _boguArr[1].x)
         {
            _loc3_ = _boguArr.shift() as MovieClip;
            _loc3_.x = _loc3_.x + 3000;
            _boguArr.push(_loc3_);
         }
         if(_selfPlayer && _arriveCountDown)
         {
            _loc5_ = FloatParadeManager.instance.dataInfo.carInfo[_selfPlayer.playerInfo.carType];
            _arriveCountDown.refreshView(_selfPlayer.x,_loc5_.speed);
         }
      }
      
      private function calibrateNpcPos() : void
      {
         var _loc3_:int = ServerConfigManager.instance.dragonBoatFastTime * 1000;
         var _loc2_:int = _npcArriveTime.getTime() - TimeManager.Instance.Now().getTime();
         _loc2_ = _loc2_ > 0?_loc2_:0;
         var _loc1_:int = 280 + 33600 - _loc2_ / _loc3_ * 33600;
         if(Math.abs(_loc1_ - _npcPlayer.x) >= 50)
         {
            _npcPlayer.x = _loc1_;
         }
      }
      
      private function setCenter(param1:Boolean = true) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         if(_isTween)
         {
            return;
         }
         var _loc3_:* = Number(350 - _selfPlayer.x);
         if(_loc3_ > 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ < 1000 - _mapLayer.width)
         {
            _loc3_ = Number(1000 - _mapLayer.width);
         }
         var _loc2_:Number = Math.abs(x - _loc3_);
         if(param1 && _loc2_ > 14)
         {
            TweenLite.to(this,_loc2_ / 400 * 0.5,{
               "x":_loc3_,
               "onComplete":tweenComplete
            });
            _isTween = true;
         }
         else
         {
            x = _loc3_;
         }
      }
      
      private function tweenComplete() : void
      {
         _isTween = false;
      }
      
      public function startGame() : void
      {
         _isStartGame = true;
         var _loc3_:int = 0;
         var _loc2_:* = _playerList;
         for each(var _loc1_ in _playerList)
         {
            _loc1_.startGame();
         }
      }
      
      public function endGame() : void
      {
         _isStartGame = false;
         var _loc3_:int = 0;
         var _loc2_:* = _playerList;
         for each(var _loc1_ in _playerList)
         {
            _loc1_.endGame();
         }
      }
      
      private function playLaunchMcHandler(param1:FloatParadeEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:Object = param1.data;
         var _loc6_:int = 0;
         var _loc5_:* = _playerList;
         for each(var _loc3_ in _playerList)
         {
            if(_loc3_.playerInfo.id == _loc4_.id && _loc3_.playerInfo.zoneId == _loc4_.zoneId)
            {
               if(_loc3_.playerInfo.isSelf)
               {
                  _loc2_ = new Timer(2000,1);
                  _loc2_.addEventListener("timerComplete",__launchTimerComplete);
                  _loc2_.start();
               }
               _loc3_.playerInfo.missileLaunchEndTime = new Date(TimeManager.Instance.Now().getTime() + 2000);
               _loc3_.refreshBuffCountDown();
               break;
            }
         }
      }
      
      protected function __launchTimerComplete(param1:TimerEvent) : void
      {
         var _loc3_:Timer = param1.target as Timer;
         _loc3_.removeEventListener("timerComplete",__launchTimerComplete);
         _loc3_.stop();
         var _loc2_:Array = FloatParadeManager.instance.missileArgArr;
         SocketManager.Instance.out.sendEscortUseSkill(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc2_[4]);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",updateMap);
         FloatParadeManager.instance.removeEventListener("floatParadeMove",moveHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeAppearItem",refreshItemHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeRefreshBuff",refreshBuffHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeUseSkill",useSkillHandler);
         FloatParadeManager.instance.removeEventListener("launchMissile",playLaunchMcHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeReEnterAllInfo",createPlayerHandler);
         FloatParadeManager.instance.removeEventListener("floatParadeFightStateChange",playerFightStateChangeHandler);
         FloatParadeManager.instance.removeEventListener("",rankArriveListChangeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_startMc)
         {
            _startMc.gotoAndStop(2);
         }
         if(_endMc)
         {
            _endMc.gotoAndStop(2);
         }
         ObjectUtils.disposeObject(_npcPlayer);
         _npcPlayer = null;
         if(_paopaoView)
         {
            _paopaoView.removeEventListener("complete",__paopaoViewHide);
         }
         ObjectUtils.disposeObject(_paopaoView);
         _paopaoView = null;
         ObjectUtils.disposeAllChildren(_mapLayer);
         ObjectUtils.disposeAllChildren(_playerLayer);
         ObjectUtils.disposeAllChildren(this);
         _mapLayer = null;
         _playerLayer = null;
         _playerList = null;
         _selfPlayer = null;
         _itemList = null;
         _rankArriveList = null;
         if(_mapBitmapData)
         {
            _mapBitmapData.dispose();
         }
         _mapBitmapData = null;
         _runPercent = null;
         _startMc = null;
         _endMc = null;
         _finishTag = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get selfPlayer() : FloatParadeGamePlayer
      {
         return _selfPlayer;
      }
      
      public function set npcArriveTime(param1:Date) : void
      {
         _npcArriveTime = param1;
         var _loc3_:int = ServerConfigManager.instance.dragonBoatFastTime * 1000;
         var _loc2_:int = _npcArriveTime.getTime() - TimeManager.Instance.Now().getTime();
         _loc2_ = _loc2_ > 0?_loc2_:0;
         _npcPlayer.x = 280 + 33600 - _loc2_ / _loc3_ * 33600;
      }
      
      public function npcChat(param1:String, param2:int = 0) : void
      {
         if(_paopaoView)
         {
            _paopaoView.removeEventListener("complete",__paopaoViewHide);
         }
         ObjectUtils.disposeObject(_paopaoView);
         _paopaoView = null;
         _paopaoView = new FloatParadeNPCpaopao(param2);
         _paopaoView.addEventListener("complete",__paopaoViewHide);
         _npcPlayer.addChild(_paopaoView);
         _paopaoView.setTxt(param1);
      }
      
      protected function __paopaoViewHide(param1:Event) : void
      {
         _paopaoView.removeEventListener("complete",__paopaoViewHide);
         ObjectUtils.disposeObject(_paopaoView);
         _paopaoView = null;
      }
   }
}
