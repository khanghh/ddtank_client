package ddt.command{   import com.pickgliss.ui.core.TransformableComponent;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Shape;      public class StripTip extends TransformableComponent   {                   private var _view:DisplayObject;            private var _mouseActiveObjectShape:Shape;            public function StripTip() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            public function setView(view:DisplayObject) : void { }
            override protected function onProppertiesUpdate() : void { }
            override public function dispose() : void { }
   }}