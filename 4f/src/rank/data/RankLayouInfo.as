package rank.data
{
   import flash.geom.Point;
   
   public class RankLayouInfo
   {
       
      
      public var TitleHLinePoint:Vector.<Point>;
      
      public var InfoTextWidth:Array;
      
      public var TitleTextPoint:Vector.<Point>;
      
      public var TitleTextString:Array;
      
      public function RankLayouInfo(){super();}
      
      public function set infoTextWidth(param1:String) : void{}
      
      public function set titleHLinePt(param1:String) : void{}
      
      public function set titleTextPt(param1:String) : void{}
      
      private function parseValue(param1:String) : Vector.<Point>{return null;}
   }
}
