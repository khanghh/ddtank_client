package im{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.PlayerManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.FocusEvent;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.text.TextField;   import flash.utils.setTimeout;      public class AutoReplyInput extends Sprite implements Disposeable   {                   private var WIDTH:int = 150;            private var _input:FilterFrameText;            private var _overBg:Bitmap;            public function AutoReplyInput() { super(); }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __onKeyDown(event:KeyboardEvent) : void { }
            private function __focusOut(event:FocusEvent) : void { }
            private function __onChange(event:PlayerPropertyEvent) : void { }
            private function __focusIn(event:FocusEvent) : void { }
            private function __outHandler(event:MouseEvent) : void { }
            private function getShortStr(str:String) : String { return null; }
            private function __overHandler(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}