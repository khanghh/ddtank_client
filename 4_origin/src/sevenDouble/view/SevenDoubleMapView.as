package sevenDouble.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.data.DictionaryData;
   import sevenDouble.SevenDoubleControl;
   import sevenDouble.SevenDoubleManager;
   import sevenDouble.data.SevenDoublePlayerInfo;
   import sevenDouble.event.SevenDoubleEvent;
   import sevenDouble.player.SevenDoubleGameItem;
   import sevenDouble.player.SevenDoubleGamePlayer;
   
   public class SevenDoubleMapView extends Sprite implements Disposeable
   {
       
      
      private var _mapLayer:Sprite;
      
      private var _playerLayer:Sprite;
      
      private var _playerList:Vector.<SevenDoubleGamePlayer>;
      
      private var _selfPlayer:SevenDoubleGamePlayer;
      
      private var _itemList:DictionaryData;
      
      private var _playerItemList:Array;
      
      private var _rankArriveList:Array;
      
      private var _needRankList:DictionaryData;
      
      private var _isStartGame:Boolean = false;
      
      private var _mapBitmapData:BitmapData;
      
      private var _startOrEndIcon:BitmapData;
      
      private var _finishCowboy:MovieClip;
      
      private var _runPercent:SevenDoubleRunPercentView;
      
      private var _enterFrameCount:int = 0;
      
      private var _isTween:Boolean = false;
      
      public function SevenDoubleMapView()
      {
         _itemList = new DictionaryData();
         _playerItemList = [];
         _rankArriveList = [];
         super();
         initView();
         initEvent();
      }
      
      public function set runPercent(value:SevenDoubleRunPercentView) : void
      {
         _runPercent = value;
      }
      
      private function initView() : void
      {
         initMapLayer();
         initPlayer();
      }
      
      private function initMapLayer() : void
      {
         var i:int = 0;
         var bitmap:* = null;
         _mapLayer = new Sprite();
         addChild(_mapLayer);
         _mapBitmapData = ComponentFactory.Instance.creatBitmapData("asset.sevenDouble.mapBg");
         for(i = 0; i < 12; )
         {
            bitmap = new Bitmap(_mapBitmapData);
            bitmap.x = i * 1862;
            _mapLayer.addChild(bitmap);
            i++;
         }
         var tmp:BitmapData = new BitmapData(884,600);
         tmp.copyPixels(_mapBitmapData,new Rectangle(0,0,884,600),new Point(0,0));
         var tmpBitmap:Bitmap = new Bitmap(tmp);
         tmpBitmap.x = 22344;
         _mapLayer.addChild(tmpBitmap);
         _startOrEndIcon = ComponentFactory.Instance.creatBitmapData("asset.sevenDouble.gameStartEndTagIcon");
         var startIcon:Bitmap = new Bitmap(_startOrEndIcon);
         startIcon.x = 232;
         startIcon.y = -5;
         var endIcon:Bitmap = new Bitmap(_startOrEndIcon);
         endIcon.x = 22732;
         endIcon.y = -5;
         _finishCowboy = ComponentFactory.Instance.creat("asset.sevenDouble.gameFinishCowboy");
         _finishCowboy.gotoAndStop(1);
         _finishCowboy.scaleX = 0.7;
         _finishCowboy.scaleY = 0.7;
         _finishCowboy.x = 22956;
         _finishCowboy.y = 316;
         _mapLayer.addChild(startIcon);
         _mapLayer.addChild(endIcon);
         _mapLayer.addChild(_finishCowboy);
      }
      
      private function initPlayer() : void
      {
         var i:int = 0;
         var tmp:* = null;
         var tmpP:* = null;
         _playerLayer = new Sprite();
         addChild(_playerLayer);
         var playerInfoList:Vector.<SevenDoublePlayerInfo> = SevenDoubleControl.instance.playerList;
         if(!playerInfoList)
         {
            return;
         }
         _playerList = new Vector.<SevenDoubleGamePlayer>();
         _needRankList = new DictionaryData();
         var len:int = playerInfoList.length;
         for(i = 0; i < len; )
         {
            tmp = playerInfoList[i];
            tmpP = new SevenDoubleGamePlayer(tmp);
            _playerLayer.addChild(tmpP);
            _playerList.push(tmpP);
            _playerItemList.push(tmpP);
            _needRankList.add(i.toString(),i);
            if(tmp.isSelf)
            {
               _selfPlayer = tmpP;
            }
            i++;
         }
         playerItemDepth();
         refreshNeedRankList();
         setCenter(false);
      }
      
      private function initEvent() : void
      {
         addEventListener("enterFrame",updateMap,false,0,true);
         SevenDoubleManager.instance.addEventListener("sevenDoubleMove",moveHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleAppearItem",refreshItemHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleRefreshBuff",refreshBuffHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleUseSkill",useSkillHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleReEnterAllInfo",createPlayerHandler);
         SevenDoubleManager.instance.addEventListener("sevenDoubleFightStateChange",playerFightStateChangeHandler);
         SevenDoubleManager.instance.addEventListener("",rankArriveListChangeHandler);
      }
      
      private function rankArriveListChangeHandler(event:SevenDoubleEvent) : void
      {
         _rankArriveList = event.data as Array;
         refreshNeedRankList();
      }
      
      private function refreshNeedRankList() : void
      {
         if(!_playerList || !_rankArriveList)
         {
            return;
         }
         var needDelete:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _needRankList;
         for each(var tmp in _needRankList)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _rankArriveList;
            for each(var obj in _rankArriveList)
            {
               if(obj.id == _playerList[tmp].playerInfo.id && obj.zoneId == _playerList[tmp].playerInfo.zoneId)
               {
                  needDelete.push(tmp);
                  break;
               }
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = needDelete;
         for each(var tmp2 in needDelete)
         {
            _needRankList.remove(tmp2.toString());
         }
      }
      
      private function updateRankList() : void
      {
         var j:int = 0;
         if(!_playerList)
         {
            return;
         }
         var tmpPlayerList:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = _needRankList;
         for each(var i in _needRankList)
         {
            tmpPlayerList.push(_playerList[i]);
         }
         tmpPlayerList.sortOn("x",16 | 2);
         var rankList:Array = [];
         var len:int = tmpPlayerList.length;
         for(j = 0; j < len; )
         {
            rankList.push({
               "name":tmpPlayerList[j].playerInfo.name,
               "carType":tmpPlayerList[j].playerInfo.carType
            });
            j++;
         }
         var tmpEvent:SevenDoubleEvent = new SevenDoubleEvent("sevenDoubleRankList");
         tmpEvent.data = _rankArriveList.concat(rankList);
         SevenDoubleManager.instance.dispatchEvent(tmpEvent);
      }
      
      private function playerFightStateChangeHandler(event:SevenDoubleEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               tmp.playerInfo.fightState = dataInfo.fightState;
               tmp.refreshFightMc();
               tmp.x = dataInfo.posX + 280;
               break;
            }
         }
      }
      
      private function createPlayerHandler(event:Event) : void
      {
         initPlayer();
      }
      
      private function useSkillHandler(event:SevenDoubleEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               if(dataInfo.sound)
               {
                  SoundManager.instance.play("sevenDouble04");
               }
               tmp.x = dataInfo.leapX + 280;
               break;
            }
         }
      }
      
      private function refreshBuffHandler(event:SevenDoubleEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               if(tmp.playerInfo.isSelf)
               {
                  if((dataInfo.acceleEndTime as Date).getTime() - tmp.playerInfo.acceleEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("sevenDouble01");
                  }
                  if((dataInfo.deceleEndTime as Date).getTime() - tmp.playerInfo.deceleEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("sevenDouble02");
                  }
                  else if((dataInfo.deceleEndTime as Date).getTime() - tmp.playerInfo.deceleEndTime.getTime() < -1000)
                  {
                     SoundManager.instance.play("sevenDouble05");
                  }
                  if((dataInfo.invisiEndTime as Date).getTime() - tmp.playerInfo.invisiEndTime.getTime() > 1000)
                  {
                     SoundManager.instance.play("sevenDouble03");
                  }
               }
               tmp.playerInfo.acceleEndTime = dataInfo.acceleEndTime;
               tmp.playerInfo.deceleEndTime = dataInfo.deceleEndTime;
               tmp.playerInfo.invisiEndTime = dataInfo.invisiEndTime;
               tmp.refreshBuffCountDown();
               break;
            }
         }
      }
      
      private function refreshItemHandler(event:SevenDoubleEvent) : void
      {
         var tmpItem:* = null;
         var tag:int = 0;
         var addItem:* = null;
         var itemData:Object = event.data;
         var tmpItemList:Array = itemData.itemList;
         var _loc9_:int = 0;
         var _loc8_:* = tmpItemList;
         for each(var obj in tmpItemList)
         {
            tmpItem = _itemList[obj.index];
            ObjectUtils.disposeObject(tmpItem);
            if(tmpItem)
            {
               _playerItemList.splice(_playerItemList.indexOf(tmpItem),1);
            }
            tag = obj.tag;
            if(tag == 0)
            {
               _itemList.remove(obj.index);
            }
            else
            {
               addItem = new SevenDoubleGameItem(obj.index,obj.type,obj.posX);
               _playerLayer.addChild(addItem);
               _itemList.add(obj.index,addItem);
               _playerItemList.push(addItem);
            }
         }
         playerItemDepth();
      }
      
      private function playerItemDepth() : void
      {
         var i:int = 0;
         _playerItemList.sortOn("y",16);
         var len:int = _playerItemList.length;
         for(i = 0; i < len; )
         {
            _playerLayer.addChild(_playerItemList[i]);
            i++;
         }
      }
      
      private function moveHandler(event:SevenDoubleEvent) : void
      {
         var dataInfo:Object = event.data;
         var _loc5_:int = 0;
         var _loc4_:* = _playerList;
         for each(var tmp in _playerList)
         {
            if(tmp.playerInfo.zoneId == dataInfo.zoneId && tmp.playerInfo.id == dataInfo.id)
            {
               tmp.destinationX = dataInfo.destX;
               break;
            }
         }
      }
      
      private function updateMap(event:Event) : void
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
         for each(var tmp in _playerList)
         {
            tmp.updatePlayer();
         }
         setCenter();
         if(_selfPlayer && _runPercent)
         {
            _runPercent.refreshView(_selfPlayer.x);
         }
      }
      
      private function setCenter(isNeedTween:Boolean = true) : void
      {
         if(!_selfPlayer)
         {
            return;
         }
         if(_isTween)
         {
            return;
         }
         var xf:* = Number(350 - _selfPlayer.x);
         if(xf > 0)
         {
            xf = 0;
         }
         if(xf < 1000 - _mapLayer.width)
         {
            xf = Number(1000 - _mapLayer.width);
         }
         var tmp:Number = Math.abs(x - xf);
         if(isNeedTween && tmp > 14)
         {
            TweenLite.to(this,tmp / 400 * 0.5,{
               "x":xf,
               "onComplete":tweenComplete
            });
            _isTween = true;
         }
         else
         {
            x = xf;
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
         for each(var tmp in _playerList)
         {
            tmp.startGame();
         }
      }
      
      public function endGame() : void
      {
         _isStartGame = false;
         var _loc3_:int = 0;
         var _loc2_:* = _playerList;
         for each(var tmp in _playerList)
         {
            tmp.endGame();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",updateMap);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleMove",moveHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleAppearItem",refreshItemHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleRefreshBuff",refreshBuffHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleUseSkill",useSkillHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleReEnterAllInfo",createPlayerHandler);
         SevenDoubleManager.instance.removeEventListener("sevenDoubleFightStateChange",playerFightStateChangeHandler);
         SevenDoubleManager.instance.removeEventListener("",rankArriveListChangeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_finishCowboy)
         {
            _finishCowboy.gotoAndStop(2);
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
         if(_startOrEndIcon)
         {
            _startOrEndIcon.dispose();
         }
         _startOrEndIcon = null;
         _finishCowboy = null;
         _runPercent = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
