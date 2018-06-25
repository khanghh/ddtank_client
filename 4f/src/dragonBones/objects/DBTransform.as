package dragonBones.objects{   import dragonBones.utils.TransformUtil;   import flash.geom.Matrix;      public class DBTransform   {                   public var x:Number;            public var y:Number;            public var skewX:Number;            public var skewY:Number;            public var scaleX:Number;            public var scaleY:Number;            public function DBTransform() { super(); }
            public function get rotation() : Number { return 0; }
            public function set rotation(value:Number) : void { }
            public function copy(transform:DBTransform) : void { }
            public function add(transform:DBTransform) : void { }
            public function minus(transform:DBTransform) : void { }
            public function divParent(transform:DBTransform, createNew:Boolean = false) : DBTransform { return null; }
            public function normalizeRotation() : void { }
            public function toString() : String { return null; }
   }}