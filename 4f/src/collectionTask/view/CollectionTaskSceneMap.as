package collectionTask.view{   import church.vo.SceneMapVO;   import collectionTask.CollectionTaskManager;   import collectionTask.event.CollectionTaskEvent;   import collectionTask.model.CollectionTaskModel;   import collectionTask.player.CollectionTaskPlayer;   import collectionTask.vo.CollectionRobertVo;   import collectionTask.vo.PlayerVO;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.PlayerInfo;   import ddt.events.SceneCharacterEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.getTimer;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class CollectionTaskSceneMap extends Sprite implements Disposeable   {                   private var _model:CollectionTaskModel;            protected var articleLayer:Sprite;            protected var meshLayer:Sprite;            protected var bgLayer:Sprite;            protected var skyLayer:Sprite;            protected var animalLayer:Sprite;            public var sceneScene:SceneScene;            private var _sceneMapVO:SceneMapVO;            public var _selfPlayer:CollectionTaskPlayer;            private var _currentLoadingPlayer:CollectionTaskPlayer;            private var _mouseMovie:MovieClip;            protected var _characters:DictionaryData;            private var _clickInterval:Number = 200;            private var _lastClick:Number = 0;            private var _players:DictionaryData;            private var _red_tree:MovieClip;            private var _green_tree:MovieClip;            private var _yellow_tree:MovieClip;            private var _bee_BoxUp:MovieClip;            private var _bee_BoxDown:MovieClip;            private var _movieClipId:int;            private var _collectMovie:MovieClip;            private var _movieClipPosVector:Vector.<Point>;            private var _playCollectMovieFunc:Function;            private var _stopCollectFunc:Function;            private var _addRobertCount:int;            private var _redTxt:FilterFrameText;            private var _yellowTxt:FilterFrameText;            private var _blueTxt:FilterFrameText;            private var _beeTxt:FilterFrameText;            private var _beeTxt1:FilterFrameText;            private var _addRobertTimer:TimerJuggler;            protected var reference:CollectionTaskPlayer;            public function CollectionTaskSceneMap(model:CollectionTaskModel, scene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, animal:Sprite = null, sky:Sprite = null, article:Sprite = null) { super(); }
            private function init() : void { }
            private function addEvent() : void { }
            protected function _menuChangeHandler(event:CollectionTaskEvent) : void { }
            public function nameVisible() : void { }
            public function chatBallVisible() : void { }
            public function playerVisible() : void { }
            protected function __collectHandler(event:MouseEvent) : void { }
            public function checkPonitDistance(p:Point) : void { }
            public function setPlayProgressFunc(fun:Function = null) : void { }
            public function setStopProgressFunc(fun:Function = null) : void { }
            protected function __removeRebortPlayer(event:CollectionTaskEvent) : void { }
            protected function __removePlayer(event:DictionaryEvent) : void { }
            protected function __addPlayer(event:DictionaryEvent) : void { }
            protected function __click(event:MouseEvent) : void { }
            public function sendMyPosition(p:Array) : void { }
            public function movePlayer(id:int, p:Array) : void { }
            protected function updateMap(event:Event) : void { }
            protected function BuildEntityDepth() : void { }
            protected function getPointDepth(x:Number, y:Number) : Number { return 0; }
            public function addRobertPlayer(len:int) : void { }
            private function __addRebortPlayerHandler(event:Event) : void { }
            public function addSelfPlayer() : void { }
            private function addPlayerCallBack(player:CollectionTaskPlayer, isLoadSucceed:Boolean, vFlag:int) : void { }
            public function get characters() : DictionaryData { return null; }
            public function set sceneMapVO(value:SceneMapVO) : void { }
            public function get sceneMapVO() : SceneMapVO { return null; }
            private function playerActionChange(evt:SceneCharacterEvent) : void { }
            public function setCenter(event:SceneCharacterEvent = null) : void { }
            protected function ajustScreen(churchPlayer:CollectionTaskPlayer) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}