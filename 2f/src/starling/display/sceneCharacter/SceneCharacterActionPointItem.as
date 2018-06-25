package starling.display.sceneCharacter{   import flash.geom.Point;      public class SceneCharacterActionPointItem   {                   public var state:String;            public var type:String;            public var points:Array;            public var amount:int;            public function SceneCharacterActionPointItem(type:String, amount:int, points:Array) { super(); }
            public function getPoint(value:int) : Point { return null; }
            public function dispose() : void { }
   }}