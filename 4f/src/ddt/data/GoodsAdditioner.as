package ddt.data
{
   import ddt.data.analyze.GoodsAdditionAnalyer;
   import flash.geom.Point;
   
   public class GoodsAdditioner
   {
      
      private static var _instance:GoodsAdditioner;
       
      
      private var _additionArr:Array;
      
      public function GoodsAdditioner(){super();}
      
      public static function get Instance() : GoodsAdditioner{return null;}
      
      public function addGoodsAddition(param1:GoodsAdditionAnalyer) : void{}
      
      public function getpropertySuccessRate(param1:int, param2:int, param3:int, param4:int) : Point{return null;}
   }
}
