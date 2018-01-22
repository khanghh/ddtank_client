package ddt.data
{
   import ddt.data.analyze.GoodsAdditionAnalyer;
   import flash.geom.Point;
   
   public class GoodsAdditioner
   {
      
      private static var _instance:GoodsAdditioner;
       
      
      private var _additionArr:Array;
      
      public function GoodsAdditioner()
      {
         super();
      }
      
      public static function get Instance() : GoodsAdditioner
      {
         if(_instance == null)
         {
            _instance = new GoodsAdditioner();
         }
         return _instance;
      }
      
      public function addGoodsAddition(param1:GoodsAdditionAnalyer) : void
      {
         _additionArr = param1.additionArr;
      }
      
      public function getpropertySuccessRate(param1:int, param2:int, param3:int, param4:int) : Point
      {
         var _loc8_:int = 0;
         if(param1 != 17)
         {
            param2 = 0;
         }
         param3 = param3 + 1;
         if(_additionArr == null)
         {
            return null;
         }
         var _loc6_:Point = new Point();
         var _loc5_:* = [];
         var _loc7_:Array = [];
         _loc5_ = _additionArr;
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            if(_loc5_[_loc8_].ItemCatalog == param1)
            {
               _loc7_.push(_loc5_[_loc8_]);
            }
            _loc8_++;
         }
         _loc5_ = _loc7_;
         _loc7_ = [];
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            if(_loc5_[_loc8_].SubCatalog == param2)
            {
               _loc7_.push(_loc5_[_loc8_]);
            }
            _loc8_++;
         }
         _loc5_ = _loc7_;
         _loc7_ = [];
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            if(_loc5_[_loc8_].StrengthenLevel == param3)
            {
               _loc7_.push(_loc5_[_loc8_]);
            }
            _loc8_++;
         }
         _loc5_ = _loc7_;
         _loc7_ = [];
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            if(_loc5_[_loc8_].FailtureTimes == param4)
            {
               _loc6_.x = _loc5_[_loc8_].PropertyPlus;
               _loc6_.y = _loc5_[_loc8_].SuccessRatePlus;
            }
            _loc8_++;
         }
         return _loc6_;
      }
   }
}
