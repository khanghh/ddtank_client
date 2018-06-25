package collectionTask.view{   import collectionTask.CollectionTaskManager;   import com.greensock.TweenLite;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class CollectionTaskExitMenuView extends Sprite implements Disposeable   {                   private var _menuIsOpen:Boolean = true;            private var _BG:Bitmap;            private var _moveOutBtn:SimpleBitmapButton;            private var _moveInBtn:SimpleBitmapButton;            private var _returnBtn:SimpleBitmapButton;            public function CollectionTaskExitMenuView() { super(); }
            private function initialize() : void { }
            private function setEvent() : void { }
            private function outHandler(event:MouseEvent) : void { }
            private function setInOutVisible(isOut:Boolean) : void { }
            private function inHandler(event:MouseEvent) : void { }
            private function exitHandler(event:MouseEvent) : void { }
            private function __frameResponse(e:FrameEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}