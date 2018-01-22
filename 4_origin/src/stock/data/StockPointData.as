package stock.data
{
   import flash.geom.Point;
   
   public final class StockPointData
   {
       
      
      public var time:Number;
      
      public var dealPrice:int = 0;
      
      public var hourPoint:Point = null;
      
      public var dayPoint:Point = null;
      
      public var timeIndex:int;
      
      public function StockPointData()
      {
         super();
      }
   }
}
