package im{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.list.IDropListTarget;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import ddt.data.player.PlayerState;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class StateIconButton extends Sprite implements IDropListTarget, Disposeable   {                   private var _btn:BaseButton;            private var _stateIcon:ScaleFrameImage;            public function StateIconButton() { super(); }
            public function setCursor(index:int) : void { }
            public function setFrame(index:int) : void { }
            public function get caretIndex() : int { return 0; }
            public function setValue(value:*) : void { }
            public function getValueLength() : int { return 0; }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}