package starling.display.sceneCharacter
{
   import flash.geom.Point;
   
   public class SceneCharacterActionPoint
   {
       
      
      public var point:Point;
      
      public var frames:Array;
      
      public function SceneCharacterActionPoint($point:Point, $frames:Array)
      {
         super();
         point = $point;
         frames = $frames;
      }
      
      public function isFrame(index:int) : Boolean
      {
         return frames && frames.indexOf(index) != -1;
      }
   }
}
