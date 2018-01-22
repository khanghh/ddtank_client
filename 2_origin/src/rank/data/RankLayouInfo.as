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
      
      public function set infoTextWidth(param1:String) : void
      {
         InfoTextWidth = param1.split("|");
      }
      
      public function set titleHLinePt(param1:String) : void
      {
         TitleHLinePoint = parseValue(param1);
      }
      
      public function set titleTextPt(param1:String) : void
      {
         TitleTextPoint = parseValue(param1);
      }
      
      private function parseValue(param1:String) : Vector.<Point>
      {
         var _loc4_:* = null;
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         var _loc5_:Array = param1.split("|");
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_;
         for each(var _loc3_ in _loc5_)
         {
            _loc4_ = new Point(_loc3_.split(",")[0],_loc3_.split(",")[1]);
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
   }
}
