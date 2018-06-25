package character{   import character.action.ActionSet;   import character.action.BaseAction;   import character.action.SimpleFrameAction;   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;   import mx.events.PropertyChangeEvent;      public class SimpleBitmapCharacter extends CrossFrameItem implements ICharacter   {                   private var _actionSet:ActionSet;            private var _currentAction:SimpleFrameAction;            private var _label:String = "";            private var _registerPoint:Point;            private var _rect:Rectangle;            protected var _soundEnabled:Boolean = false;            public function SimpleBitmapCharacter(source:BitmapData, $description:XML = null, label:String = "", $width:Number = 0, $height:Number = 0, $rendmode:String = "original", autoStop:Boolean = false) { super(null,null,null,null,null,null); }
            public function get soundEnabled() : Boolean { return false; }
            private function set _164832462soundEnabled(value:Boolean) : void { }
            public function getActionFrames(action:String) : int { return 0; }
            public function set description(des:XML) : void { }
            private function set _102727412label(value:String) : void { }
            public function get label() : String { return null; }
            public function hasAction(action:String) : Boolean { return false; }
            public function addAction(action:BaseAction) : void { }
            public function get actions() : Array { return null; }
            public function removeAction(action:String) : void { }
            public function doAction(action:String) : void { }
            override protected function update() : void { }
            public function get registerPoint() : Point { return null; }
            public function get rect() : Rectangle { return null; }
            override public function toXml() : XML { return null; }
            override public function dispose() : void { }
            [Bindable(event="propertyChange")]      public function set soundEnabled(param1:Boolean) : void { }
            [Bindable(event="propertyChange")]      public function set label(param1:String) : void { }
   }}