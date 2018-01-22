package starling.display.sceneCharacter
{
   import flash.geom.Point;
   
   public class SceneCharacterActionPoint
   {
       
      
      public var point:Point;
      
      public var frames:Array;
      
      public function SceneCharacterActionPoint(param1:Point, param2:Array)
      {
         super();
         point = param1;
         frames = param2;
      }
      
      public function isFrame(param1:int) : Boolean
      {
         return frames && frames.indexOf(param1) != -1;
      }
   }
}
