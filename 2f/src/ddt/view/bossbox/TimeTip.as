package ddt.view.bossbox{   import com.pickgliss.ui.core.TransformableComponent;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;      public class TimeTip extends TransformableComponent   {                   private var _closeBox:Sprite;            private var _delayText:Sprite;            public function TimeTip() { super(); }
            public function setView(close:Sprite, text:Sprite) : void { }
            public function get closeBox() : Sprite { return null; }
            public function get delayText() : Sprite { return null; }
            override public function dispose() : void { }
   }}