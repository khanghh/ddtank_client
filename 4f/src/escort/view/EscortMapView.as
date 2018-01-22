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
      
      public function EscortMapView(){super();}
      
      public function set runPercent(param1:EscortRunPercentView) : void{}
      
      private function initView() : void{}
      
      private function initMapLayer() : void{}
      
      private function initPlayer() : void{}
      
      private function initEvent() : void{}
      
      private function rankArriveListChangeHandler(param1:EscortEvent) : void{}
      
      private function refreshNeedRankList() : void{}
      
      private function updateRankList() : void{}
      
      private function playerFightStateChangeHandler(param1:EscortEvent) : void{}
      
      private function createPlayerHandler(param1:Event) : void{}
      
      private function useSkillHandler(param1:EscortEvent) : void{}
      
      private function refreshBuffHandler(param1:EscortEvent) : void{}
      
      private function refreshItemHandler(param1:Object) : void{}
      
      private function playerItemDepth() : void{}
      
      private function moveHandler(param1:EscortEvent) : void{}
      
      private function updateMap(param1:Event) : void{}
      
      private function setCenter(param1:Boolean = true) : void{}
      
      private function tweenComplete() : void{}
      
      public function startGame() : void{}
      
      public function endGame() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
