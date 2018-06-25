package catchInsect.view{   import baglocked.BaglockedManager;   import catchInsect.CatchInsectControl;   import catchInsect.CatchInsectManager;   import catchInsect.CatchInsectRoomModel;   import catchInsect.componets.RoomMenuView;   import catchInsect.event.CatchInsectRoomEvent;   import catchInsect.loader.LoaderCatchInsectUIModule;   import church.vo.SceneMapVO;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import ddt.view.chat.ChatView;   import ddt.view.scenePathSearcher.PathMapHitTester;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Timer;      public class CatchInsectRoomView extends Sprite implements Disposeable   {            public static const MAP_SIZEII:Array = [1738,1300];                   private var _contoller:CatchInsectRoomController;            private var _model:CatchInsectRoomModel;            private var _sceneScene:SceneScene;            private var _sceneMap:CatchInsectScneneMap;            private var _chatFrame:ChatView;            private var _roomMenuView:RoomMenuView;            private var _sceneInfoViewBg:Bitmap;            private var _scoreTxt:FilterFrameText;            private var _ballCountTxt:FilterFrameText;            private var _netCountTxt:FilterFrameText;            private var _buyBallBtn:SimpleBitmapButton;            private var _buyNetBtn:SimpleBitmapButton;            private var _useCakeBtn:SimpleBitmapButton;            private var _useWhistleBtn:SimpleBitmapButton;            private var _useCakeTxt:FilterFrameText;            private var _useWhistleTxt:FilterFrameText;            private var _helpBtn:SimpleBitmapButton;            private var _timer:Timer;            public function CatchInsectRoomView(controller:CatchInsectRoomController, model:CatchInsectRoomModel) { super(); }
            public function show() : void { }
            private function initialize() : void { }
            private function addEvent() : void { }
            private function updateBtnTxt() : void { }
            private function __updateFightMonster(event:CatchInsectRoomEvent) : void { }
            protected function __useCakeBtnClick(event:MouseEvent) : void { }
            protected function __useWhistleBtnClick(event:MouseEvent) : void { }
            protected function __updateScore(event:Event) : void { }
            private function removeEvent() : void { }
            protected function __updateGoods(evt:BagEvent) : void { }
            protected function __buyNetBtnClick(event:MouseEvent) : void { }
            protected function __buyBallBtnClick(event:MouseEvent) : void { }
            public function setViewAgain() : void { }
            public function setMap(localPos:Point = null) : void { }
            public function getSceneMapVO() : SceneMapVO { return null; }
            public function movePlayer(id:int, p:Array) : void { }
            public function updatePlayerStauts(id:int, status:int, point:Point = null) : void { }
            public function updateSelfStatus(value:int) : void { }
            private function _leaveRoom(e:Event) : void { }
            private function clearMap() : void { }
            public function dispose() : void { }
   }}