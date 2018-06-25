package littleGame.menu{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;   import littleGame.LittleGameManager;      public class LittleMenuBar extends Sprite implements Disposeable   {                   private var _back:DisplayObject;            private var _returnButton:BaseButton;            private var _switchButton:SwitchButton;            private var _mode:int = 1;            public function LittleMenuBar() { super(); }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function __return(event:MouseEvent) : void { }
            private function __switchMode(event:MouseEvent) : void { }
            private function hide() : void { }
            private function show() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}