package church.view.weddingRoom{   import church.ChurchControl;   import church.ChurchManager;   import church.controller.ChurchRoomController;   import church.model.ChurchRoomModel;   import church.view.churchScene.MoonSceneMap;   import church.view.churchScene.SceneMap;   import church.view.churchScene.WeddingLuxurySceneMap;   import church.view.churchScene.WeddingSceneMap;   import church.vo.SceneMapVO;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.view.scenePathSearcher.PathMapHitTester;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;      public class WeddingRoomView extends Sprite implements Disposeable   {            public static const MAP_SIZE:Array = [1208,835];            public static const MAP_SIZEII:Array = [2011,1361];                   private var _controller:ChurchRoomController;            private var _model:ChurchRoomModel;            private var _sceneScene:SceneScene;            private var _sceneMapVO:SceneMapVO;            private var _sceneMap:SceneMap;            private var _chatFrame:Sprite;            private var _weddingRoomMenuView:WeddingRoomMenuView;            private var _weddingRoomToolView:WeddingRoomToolView;            private var _weddingRoomMask:WeddingRoomMask;            public function WeddingRoomView(controller:ChurchRoomController, model:ChurchRoomModel) { super(); }
            protected function initialize() : void { }
            public function setMap(localPos:Point = null) : void { }
            public function movePlayer(id:int, p:Array) : void { }
            public function getSceneMapVO() : SceneMapVO { return null; }
            public function useFire(playerID:int, fireTemplateID:int) : void { }
            private function clearMap() : void { }
            public function getMapRes() : String { return null; }
            public function playerWeddingMovie() : void { }
            public function switchWeddingView() : void { }
            private function __stopWeddingMovie(event:Event) : void { }
            private function readyStartWedding() : void { }
            private function __playWeddingMovie(event:Event) : void { }
            public function setSaulte(id:int) : void { }
            public function show() : void { }
            public function dispose() : void { }
   }}