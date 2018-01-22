package petsBag.petsAdvanced
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class PetsCellUnlocakPriceAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<int>;
      
      public function PetsCellUnlocakPriceAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc2_:XML = new XML(param1);
         var _loc3_:int = _loc2_.children().length();
         _list = new Vector.<int>();
         if(_loc2_.@value == "true")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               var _loc5_:* = _loc2_.item;
               var _loc6_:int = 0;
               var _loc8_:* = new XMLList("");
               _list[_loc4_] = _loc2_.item.(@ID == _loc4_ + 1).@money;
               _loc4_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            onAnalyzeError();
         }
      }
      
      public function getPrice() : Vector.<int>
      {
         return _list;
      }
   }
}
