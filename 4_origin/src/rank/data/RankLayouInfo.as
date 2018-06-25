package rank.data
{
   import flash.geom.Point;
   
   public class RankLayouInfo
   {
       
      
      public var TitleHLinePoint:Vector.<Point>;
      
      public var InfoTextWidth:Array;
      
      public var TitleTextPoint:Vector.<Point>;
      
      public var TitleTextString:Array;
      
      public function RankLayouInfo()
      {
         super();
         TitleHLinePoint = new Vector.<Point>();
         TitleTextPoint = new Vector.<Point>();
      }
      
      public function set infoTextWidth(value:String) : void
      {
         InfoTextWidth = value.split("|");
      }
      
      public function set titleHLinePt(value:String) : void
      {
         TitleHLinePoint = parseValue(value);
      }
      
      public function set titleTextPt(value:String) : void
      {
         TitleTextPoint = parseValue(value);
      }
      
      private function parseValue(value:String) : Vector.<Point>
      {
         var pt:* = null;
         var result:Vector.<Point> = new Vector.<Point>();
         var pts:Array = value.split("|");
         var _loc7_:int = 0;
         var _loc6_:* = pts;
         for each(var p in pts)
         {
            pt = new Point(p.split(",")[0],p.split(",")[1]);
            result.push(pt);
         }
         return result;
      }
   }
}
