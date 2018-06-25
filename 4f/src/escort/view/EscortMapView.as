package escort.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import escort.EscortControl;   import escort.EscortManager;   import escort.data.EscortPlayerInfo;   import escort.event.EscortEvent;   import escort.player.EscortGameItem;   import escort.player.EscortGamePlayer;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import road7th.data.DictionaryData;      public class EscortMapView extends Sprite implements Disposeable   {                   private var _mapLayer:Sprite;            private var _playerLayer:Sprite;            private var _playerList:Vector.<EscortGamePlayer>;            private var _selfPlayer:EscortGamePlayer;            private var _itemList:DictionaryData;            private var _playerItemList:Array;            private var _rankArriveList:Array;            private var _needRankList:DictionaryData;            private var _isStartGame:Boolean = false;            private var _mapBitmapData:BitmapData;            private var _startMc:MovieClip;            private var _endMc:MovieClip;            private var _finishTag:Bitmap;            private var _runPercent:EscortRunPercentView;            private var _enterFrameCount:int = 0;            private var _isTween:Boolean = false;            public function EscortMapView() { super(); }
            public function set runPercent(value:EscortRunPercentView) : void { }
            private function initView() : void { }
            private function initMapLayer() : void { }
            private function initPlayer() : void { }
            private function initEvent() : void { }
            private function rankArriveListChangeHandler(event:EscortEvent) : void { }
            private function refreshNeedRankList() : void { }
            private function updateRankList() : void { }
            private function playerFightStateChangeHandler(event:EscortEvent) : void { }
            private function createPlayerHandler(event:Event) : void { }
            private function useSkillHandler(event:EscortEvent) : void { }
            private function refreshBuffHandler(event:EscortEvent) : void { }
            private function refreshItemHandler(event:Object) : void { }
            private function playerItemDepth() : void { }
            private function moveHandler(event:EscortEvent) : void { }
            private function updateMap(event:Event) : void { }
            private function setCenter(isNeedTween:Boolean = true) : void { }
            private function tweenComplete() : void { }
            public function startGame() : void { }
            public function endGame() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}