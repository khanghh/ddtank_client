package dragonBones.objects{   import flash.geom.ColorTransform;      public final class SlotFrame extends Frame   {                   public var tweenEasing:Number;            public var displayIndex:int;            public var visible:Boolean;            public var zOrder:Number;            public var color:ColorTransform;            public function SlotFrame() { super(); }
            override public function dispose() : void { }
            public function get colorChanged() : Boolean { return false; }
   }}