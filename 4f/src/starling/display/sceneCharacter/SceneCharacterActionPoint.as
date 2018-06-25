package starling.display.sceneCharacter{   import flash.geom.Point;      public class SceneCharacterActionPoint   {                   public var point:Point;            public var frames:Array;            public function SceneCharacterActionPoint($point:Point, $frames:Array) { super(); }
            public function isFrame(index:int) : Boolean { return false; }
   }}