package sevenDouble.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import flash.geom.Rectangle;   import road7th.data.DictionaryData;   import sevenDouble.SevenDoubleControl;   import sevenDouble.SevenDoubleManager;   import sevenDouble.data.SevenDoublePlayerInfo;   import sevenDouble.event.SevenDoubleEvent;   import sevenDouble.player.SevenDoubleGameItem;   import sevenDouble.player.SevenDoubleGamePlayer;      public class SevenDoubleMapView extends Sprite implements Disposeable   {                   private var _mapLayer:Sprite;            private var _playerLayer:Sprite;            private var _playerList:Vector.<SevenDoubleGamePlayer>;            private var _selfPlayer:SevenDoubleGamePlayer;            private var _itemList:DictionaryData;            private var _playerItemList:Array;            private var _rankArriveList:Array;            private var _needRankList:DictionaryData;            private var _isStartGame:Boolean = false;            private var _mapBitmapData:BitmapData;            private var _startOrEndIcon:BitmapData;            private var _finishCowboy:MovieClip;            private var _runPercent:SevenDoubleRunPercentView;            private var _enterFrameCount:int = 0;            private var _isTween:Boolean = false;            public function SevenDoubleMapView() { super(); }
            public function set runPercent(value:SevenDoubleRunPercentView) : void { }
            private function initView() : void { }
            private function initMapLayer() : void { }
            private function initPlayer() : void { }
            private function initEvent() : void { }
            private function rankArriveListChangeHandler(event:SevenDoubleEvent) : void { }
            private function refreshNeedRankList() : void { }
            private function updateRankList() : void { }
            private function playerFightStateChangeHandler(event:SevenDoubleEvent) : void { }
            private function createPlayerHandler(event:Event) : void { }
            private function useSkillHandler(event:SevenDoubleEvent) : void { }
            private function refreshBuffHandler(event:SevenDoubleEvent) : void { }
            private function refreshItemHandler(event:SevenDoubleEvent) : void { }
            private function playerItemDepth() : void { }
            private function moveHandler(event:SevenDoubleEvent) : void { }
            private function updateMap(event:Event) : void { }
            private function setCenter(isNeedTween:Boolean = true) : void { }
            private function tweenComplete() : void { }
            public function startGame() : void { }
            public function endGame() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}