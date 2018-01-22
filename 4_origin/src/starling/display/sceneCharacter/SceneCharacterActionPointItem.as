package starling.display.sceneCharacter
{
   import flash.geom.Point;
   
   public class SceneCharacterActionPointItem
   {
       
      
      public var state:String;
      
      public var type:String;
      
      public var points:Array;
      
      public var amount:int;
      
      public function SceneCharacterActionPointItem(param1:String, param2:int, param3:Array)
      {
         super();
         this.type = param1;
         this.amount = param2;
         this.points = param3;
      }
      
      public function getPoint(param1:int) : Point
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < points.length)
         {
            _loc2_ = this.points[_loc3_] as SceneCharacterActionPoint;
            if(_loc2_.isFrame(param1))
            {
               return _loc2_.point;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function dispose() : void
      {
      }
   }
}
