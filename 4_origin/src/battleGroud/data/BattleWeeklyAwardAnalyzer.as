package battleGroud.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   
   public class BattleWeeklyAwardAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function BattleWeeklyAwardAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _dataList = [];
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_.item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new InventoryItemInfo();
               _loc4_.TemplateID = int(_loc3_[_loc5_].@TemplateID);
               ItemManager.fill(_loc4_);
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _dataList.push(_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
         }
      }
   }
}
