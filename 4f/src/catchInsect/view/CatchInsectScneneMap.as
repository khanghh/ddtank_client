package catchInsect.view{   import catchInsect.CatchInsectControl;   import catchInsect.CatchInsectManager;   import catchInsect.CatchInsectMonsterManager;   import catchInsect.CatchInsectRoomModel;   import catchInsect.PlayerVO;   import catchInsect.data.InsectInfo;   import catchInsect.event.CatchInsectRoomEvent;   import catchInsect.player.CatchInsectMonster;   import catchInsect.player.CatchInsectRoomPlayer;   import church.vo.SceneMapVO;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import hall.event.NewHallEvent;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;      public class CatchInsectScneneMap extends Sprite implements Disposeable   {            public static var packsNum:int = 1;                   protected var articleLayer:Sprite;            protected var meshLayer:Sprite;            protected var bgLayer:Sprite;            protected var skyLayer:Sprite;            protected var snowLayer:Sprite;            public var sceneScene:SceneScene;            protected var _data:DictionaryData;            protected var _characters:DictionaryData;            public var selfPlayer:CatchInsectRoomPlayer;            private var _isUpdateComplete:Boolean;            private var _updateState:int;            private var last_click:Number;            private var current_display_fire:int = 0;            private var _currentLoadingPlayer:CatchInsectRoomPlayer;            private var _isShowName:Boolean = true;            private var _isChatBall:Boolean = true;            private var _clickInterval:Number = 200;            private var _lastClick:Number = 0;            private var _sceneMapVO:SceneMapVO;            private var _model:CatchInsectRoomModel;            private var armyPos:Point;            private var decorationLayer:Sprite;            protected var _mapObjs:DictionaryData;            protected var _monsters:DictionaryData;            private var _mouseMovie:MovieClip;            private var r:int = 250;            private var auto:Point;            private var autoMove:Boolean = false;            private var _entering:Boolean = false;            private var endPoint:Point;            protected var reference:CatchInsectRoomPlayer;            public function CatchInsectScneneMap(model:CatchInsectRoomModel, sceneScene:SceneScene, data:DictionaryData, objData:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null, decoration:Sprite = null, snow:Sprite = null) { super(); }
            private function checkDistance() : Boolean { return false; }
            public function set enterIng(value:Boolean) : void { }
            public function get sceneMapVO() : SceneMapVO { return null; }
            public function set sceneMapVO(value:SceneMapVO) : void { }
            protected function init() : void { }
            protected function addEvent() : void { }
            protected function __onSetSelfPlayerPos(event:NewHallEvent) : void { }
            private function __addMonster(pEvent:DictionaryEvent) : void { }
            private function __removeMonster(pEvent:DictionaryEvent) : void { }
            private function __onMonsterUpdate(pEvent:DictionaryEvent) : void { }
            private function menuChange(evt:CatchInsectRoomEvent) : void { }
            public function nameVisible() : void { }
            protected function updateMap(event:Event) : void { }
            protected function __click(event:MouseEvent) : void { }
            public function sendMyPosition(p:Array) : void { }
            public function movePlayer(id:int, p:Array) : void { }
            public function updatePlayersStauts(id:int, stauts:int, point:Point) : void { }
            public function __otherPlayrStartFight(evt:CatchInsectRoomEvent) : void { }
            public function updateSelfStatus(value:int) : void { }
            public function checkSelfStatus() : int { return 0; }
            public function setCenter(event:SceneCharacterEvent = null) : void { }
            public function addSelfPlayer() : void { }
            protected function ajustScreen(christmasRoomPlayer:CatchInsectRoomPlayer) : void { }
            protected function __addPlayer(event:DictionaryEvent) : void { }
            private function addPlayerCallBack(roomPlayer:CatchInsectRoomPlayer, isLoadSucceed:Boolean, vFlag:int) : void { }
            private function playerActionChange(evt:SceneCharacterEvent) : void { }
            private function __walkEndHandler(event:SceneCharacterEvent) : void { }
            protected function __removePlayer(event:DictionaryEvent) : void { }
            protected function BuildEntityDepth() : void { }
            protected function getPointDepth(x:Number, y:Number) : Number { return 0; }
            protected function removeEvent() : void { }
            public function dispose() : void { }
   }}