package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import road7th.data.DictionaryData;
   
   public class ConsortiaWeekRewardAnalyze extends DataAnalyzer
   {
       
      
      private var _dataList:DictionaryData;
      
      public function ConsortiaWeekRewardAnalyze(param1:Function)
      {
         super(param1);
      }
      
      public function get dataList() : DictionaryData
      {
         return _dataList;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         _dataList = new DictionaryData();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_.Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc2_ = _loc4_[_loc6_].@Rank;
               _loc5_ = new InventoryItemInfo();
               _loc5_.TemplateID = int(_loc4_[_loc6_].@TemplateID);
               ItemManager.fill(_loc5_);
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               _loc5_.IsBinds = _loc4_[_loc6_].@IsBind == "true";
               _dataList[_loc2_] = _loc5_;
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
      }
   }
}
