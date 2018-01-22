package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class GoodsAdditionAnalyer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      private var _additionArr:Array;
      
      public function GoodsAdditionAnalyer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _additionArr = [];
         _xml = new XML(param1);
         var _loc3_:XMLList = _xml.Item;
         if(_xml.@value == "true")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc2_ = {};
               _loc2_.ItemCatalog = int(_loc3_[_loc4_].@ItemCatalog);
               _loc2_.SubCatalog = int(_loc3_[_loc4_].@SubCatalog);
               _loc2_.StrengthenLevel = int(_loc3_[_loc4_].@StrengthenLevel);
               _loc2_.FailtureTimes = int(_loc3_[_loc4_].@FailtureTimes);
               _loc2_.PropertyPlus = int(_loc3_[_loc4_].@PropertyPlus);
               _loc2_.SuccessRatePlus = int(_loc3_[_loc4_].@SuccessRatePlus);
               _additionArr.push(_loc2_);
               _loc4_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get additionArr() : Array
      {
         return _additionArr;
      }
   }
}
