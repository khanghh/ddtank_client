package character{   import character.action.ActionSet;   import character.action.BaseAction;   import character.action.ComplexBitmapAction;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import mx.events.PropertyChangeEvent;      public class ComplexBitmapCharacter extends ComplexItem implements ICharacter   {                   protected var _assets:Dictionary;            protected var _actionSet:ActionSet;            protected var _currentAction:ComplexBitmapAction;            protected var _label:String = "";            protected var _autoStop:Boolean;            protected var _bitmapRendItems:Vector.<FrameByFrameItem>;            private var _registerPoint:Point;            private var _rect:Rectangle;            protected var _soundEnabled:Boolean = false;            public function ComplexBitmapCharacter(assets:Dictionary, $description:XML = null, label:String = "", $width:Number = 0, $height:Number = 0, $rendmode:String = "original", autoStop:Boolean = false) { super(null,null,null,null,null); }
            public function get soundEnabled() : Boolean { return false; }
            private function set _164832462soundEnabled(value:Boolean) : void { }
            public function set description(des:XML) : void { }
            public function getActionFrames(action:String) : int { return 0; }
            public function get label() : String { return null; }
            private function set _102727412label(value:String) : void { }
            public function hasAction(action:String) : Boolean { return false; }
            private function set _1408207997assets(value:Dictionary) : void { }
            public function get assets() : Dictionary { return null; }
            public function get actions() : Array { return null; }
            public function addAction(action:BaseAction) : void { }
            public function doAction(action:String) : void { }
            protected function set currentAction(action:ComplexBitmapAction) : void { }
            override protected function update() : void { }
            public function get registerPoint() : Point { return null; }
            public function get rect() : Rectangle { return null; }
            override public function toXml() : XML { return null; }
            public function removeAction(action:String) : void { }
            override public function dispose() : void { }
            [Bindable(event="propertyChange")]      public function set assets(param1:Dictionary) : void { }
            [Bindable(event="propertyChange")]      public function set soundEnabled(param1:Boolean) : void { }
            [Bindable(event="propertyChange")]      public function set label(param1:String) : void { }
   }}