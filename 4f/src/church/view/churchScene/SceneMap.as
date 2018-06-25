package church.view.churchScene{   import church.events.WeddingRoomEvent;   import church.model.ChurchRoomModel;   import church.player.ChurchPlayer;   import church.view.churchFire.ChurchFireEffectPlayer;   import church.vo.PlayerVO;   import church.vo.SceneMapVO;   import com.pickgliss.utils.ClassUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.getTimer;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;      public class SceneMap extends Sprite   {            public static const SCENE_ALLOW_FIRES:int = 6;                   private const CLICK_INTERVAL:Number = 200;            protected var articleLayer:Sprite;            protected var meshLayer:Sprite;            protected var bgLayer:Sprite;            protected var skyLayer:Sprite;            public var sceneScene:SceneScene;            protected var _data:DictionaryData;            protected var _characters:DictionaryData;            protected var _selfPlayer:ChurchPlayer;            private var last_click:Number;            private var current_display_fire:int = 0;            private var _mouseMovie:MovieClip;            private var _currentLoadingPlayer:ChurchPlayer;            private var _isShowName:Boolean = true;            private var _isChatBall:Boolean = true;            private var _clickInterval:Number = 200;            private var _lastClick:Number = 0;            private var _sceneMapVO:SceneMapVO;            private var _model:ChurchRoomModel;            protected var reference:ChurchPlayer;            public function SceneMap(model:ChurchRoomModel, sceneScene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null) { super(); }
            public function get sceneMapVO() : SceneMapVO { return null; }
            public function set sceneMapVO(value:SceneMapVO) : void { }
            protected function init() : void { }
            protected function addEvent() : void { }
            private function menuChange(evt:WeddingRoomEvent) : void { }
            public function nameVisible() : void { }
            public function chatBallVisible() : void { }
            public function fireVisible() : void { }
            protected function updateMap(event:Event) : void { }
            protected function __click(event:MouseEvent) : void { }
            public function sendMyPosition(p:Array) : void { }
            public function useFire(playerID:int, fireTemplateID:int) : void { }
            protected function fireCompleteHandler(e:Event) : void { }
            public function movePlayer(id:int, p:Array) : void { }
            public function setCenter(event:SceneCharacterEvent = null) : void { }
            public function addSelfPlayer() : void { }
            protected function ajustScreen(churchPlayer:ChurchPlayer) : void { }
            protected function __addPlayer(event:DictionaryEvent) : void { }
            private function addPlayerCallBack(churchPlayer:ChurchPlayer, isLoadSucceed:Boolean, vFlag:int) : void { }
            private function playerActionChange(evt:SceneCharacterEvent) : void { }
            protected function __removePlayer(event:DictionaryEvent) : void { }
            protected function BuildEntityDepth() : void { }
            protected function getPointDepth(x:Number, y:Number) : Number { return 0; }
            public function setSalute(id:int) : void { }
            protected function removeEvent() : void { }
            public function dispose() : void { }
   }}