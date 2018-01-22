package escort.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import escort.EscortControl;
   import escort.EscortManager;
   import escort.data.EscortPlayerInfo;
   import escort.event.EscortEvent;
   import escort.player.EscortGameItem;
   import escort.player.EscortGamePlayer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.data.DictionaryData;
   
   public class EscortMapView extends Sprite implements Disposeable
   {
       
      
      private var _mapLayer:Sprite;
      
      private var _playerLayer:Sprite;
      
      private var _playerList:Vector.<EscortGamePlayer>;
      
      private var _selfPlayer:EscortGamePlayer;
      
      private var _itemList:DictionaryData;
      
      private var _playerItemList:Array;
      
      private var _rankArriveList:Array;
      
      private var _needRankList:DictionaryData;
      
      private var _isStartGame:Boolean = false;
      
      private var _mapBitmapData:BitmapData;
      
      private var _startMc:MovieClip;
      
      private var _endMc:MovieClip;
      
      private var _finishTag:Bitmap;
      
      private var _runPercent:EscortRunPercentView;
      
      private var _enterFrameCount:int = 0;
      
      private var _isTween:Boolean = false;
      
      public function EscortMapView()
      {
         _itemList = new DictionaryData();
         _playerItemList = [];
         _rankArriveList = [];
         super();
         initView();
         initEvent();
      }
      
      public function set runPercent(param1:EscortRunPercentView) : void
      {
         _runPercent = param1;
      }
      
      private function initView() : void
      {
         initMapLayer();
         initPlayer();
      }
      
      private function initMapLayer() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _mapLayer = new Sprite();
         addChild(_mapLayer);
         _mapBitmapData = ComponentFactory.Instance.creatBitmapData("asset.escort.mapBg");
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc1_ = new Bitmap(_mapBitmapData);
            _loc1_.x = _loc4_ * 1978;
            _mapLayer.addChild(_loc1_);
            _loc4_++;
         }
         var _loc2_:BitmapData = new BitmapData(884,600);
         _loc2_.copyPixels(_mapBitmapData,new Rectangle(0,0,884,600),new Point(0,0));
         var _loc3_:Bitmap = new Bitmap(_loc2_);
         _loc3_.x = 23736;
         _mapLayer.addChild(_loc3_);
         _startMc = ComponentFactory.Instance.creat("asset.escort.gameStartTagMC");
         _startMc.gotoAndStop(1);
         _startMc.x = 67;
         _startMc.y = -5;
         _endMc = ComponentFactory.Instance.creat("asset.escort.gameEndTagMC");
         _endMc.gotoAndStop(1);
         _endMc.x = 22739;
         _endMc.y = -5;
         _mapLayer.addChild(_startMc);
         _mapLayer.addChild(_endMc);
      }
      
      private function initPlayer() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _playerLayer = new Sprite();
         addChild(_playerLayer);
         var _loc3_:Vector.<EscortPlayerInfo> = EscortControl.instance.playerList;
         if(!_loc3_)
         {
            return;
         }
         _playerList = new Vector.<EscortGamePlayer>();
         _needRankList = new DictionaryData();
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc5_];
            _loc1_ = new EscortGamePlayer(_loc2_);
            _playerLayer.addChild(_loc1_);
            _playerList.push(_loc1_);
            _playerItemList.push(_loc1_);
            _needRankList.add(_loc5_.toString(),_loc5_);
            if(_loc2_.isSelf)
            {
               _selfPlayer = _loc1_;
            }
            _loc5_++;
         }
         playerItemDepth();
         refreshNeedRankList();
         setCenter(false);
      }
      
      private function initEvent() : void
      {
         addEventListener("enterFrame",updateMap,false,0,true);
         EscortManager.instance.addEventListener("escortMove",moveHandler);
         EscortManager.instance.addEventListener("escortAppearItem",refreshItemHandler);
         EscortManager.instance.addEventListener("escortRefreshBuff",refreshBuffHandler);
         EscortManager.instance.addEventListener("escortUseSkill",useSkillHandler);
         EscortManager.instance.addEventListener("escortReEnterAllInfo",createPlayerHandler);
         EscortManager.instance.addEventListener("escortFightStateChange",playerFightStateChangeHandler);
         EscortManager.instance.addEventListener("",rankArriveListChangeHandler);
      }
      
      private function rankArriveListChangeHandler(param1:EscortEvent) : void
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
               "carType":_loc2_[_loc5_].playerInfo.carType
            });
            _loc5_++;
         }
         var _loc3_:EscortEvent = new EscortEvent("escortRankList");
         _loc3_.data = _rankArriveList.concat(_loc1_);
         EscortManager.instance.dispatchEvent(_loc3_);
      }
      
      private function playerFightStateChangeHandler(param1:EscortEvent) : void
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
      
      private function useSkillHandler(param1:EscortEvent) : void
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
      
      private function refreshBuffHandler(param1:EscortEvent) : void
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
               }
               _loc3_.playerInfo.acceleEndTime = _loc2_.acceleEndTime;
               _loc3_.playerInfo.deceleEndTime = _loc2_.deceleEndTime;
               _loc3_.playerInfo.invisiEndTime = _loc2_.invisiEndTime;
               _loc3_.refreshBuffCountDown();
               break;
            }
         }
      }
      
      private function refreshItemHandler(param1:Object) : void
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
               _loc7_ = new EscortGameItem(_loc5_.index,_loc5_.type,_loc5_.posX);
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
      
      private function moveHandler(param1:EscortEvent) : void
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
         if(!_isStartGame)
         {
            return;
         }
         _enterFrameCount = Number(_enterFrameCount) + 1;
         if(_enterFrameCount > 25)
         {
            updateRankList();
            _enterFrameCount = 0;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _playerList;
         for each(var _loc2_ in _playerList)
         {
            _loc2_.updatePlayer();
         }
         setCenter();
         if(_selfPlayer && _runPercent)
         {
            _runPercent.refreshView(_selfPlayer.x);
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
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",updateMap);
         EscortManager.instance.removeEventListener("escortMove",moveHandler);
         EscortManager.instance.removeEventListener("escortAppearItem",refreshItemHandler);
         EscortManager.instance.removeEventListener("escortRefreshBuff",refreshBuffHandler);
         EscortManager.instance.removeEventListener("escortUseSkill",useSkillHandler);
         EscortManager.instance.removeEventListener("escortReEnterAllInfo",createPlayerHandler);
         EscortManager.instance.removeEventListener("escortFightStateChange",playerFightStateChangeHandler);
         EscortManager.instance.removeEventListener("",rankArriveListChangeHandler);
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
   }
}
