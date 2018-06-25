package starling.display.sceneCharacter
{
   import flash.geom.Point;
   
   public class SceneCharacterActionPointItem
   {
       
      
      public var state:String;
      
      public var type:String;
      
      public var points:Array;
      
      public var amount:int;
      
      public function SceneCharacterActionPointItem(type:String, amount:int, points:Array)
      {
         super();
         this.type = type;
         this.amount = amount;
         this.points = points;
      }
      
      public function getPoint(value:int) : Point
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < points.length; )
         {
            item = this.points[i] as SceneCharacterActionPoint;
            if(item.isFrame(value))
            {
               return item.point;
            }
            i++;
         }
         return null;
      }
      
      public function dispose() : void
      {
      }
   }
}
