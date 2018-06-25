package gameCommon.view.playerThumbnail{   import ddt.events.GameEvent;   import flash.display.Sprite;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import gameCommon.model.Player;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import room.RoomManager;      public class PlayerThumbnailController extends Sprite   {                   private var _info:GameInfo;            private var _team1:DictionaryData;            private var _team2:DictionaryData;            private var _list1:PlayerThumbnailList;            private var _list2:PlayerThumbnailList;            private var _bossThumbnailContainer:BossThumbnail;            public function PlayerThumbnailController(info:GameInfo) { super(); }
            private function init() : void { }
            private function initInfo() : void { }
            public function addNewLiving(player:Living) : void { }
            public function set currentBoss(living:Living) : void { }
            public function removeThumbnailContainer() : void { }
            public function addLiving(living:Living) : void { }
            public function updateHeadFigure(living:*, flag:Boolean) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __thumbnailListHandle(e:GameEvent) : void { }
            private function __removePlayer(evt:DictionaryEvent) : void { }
            public function dispose() : void { }
   }}