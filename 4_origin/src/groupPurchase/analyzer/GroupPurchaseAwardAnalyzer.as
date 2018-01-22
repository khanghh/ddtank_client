package groupPurchase.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import groupPurchase.data.GroupPurchaseAwardInfo;
   
   public class GroupPurchaseAwardAnalyzer extends DataAnalyzer
   {
       
      
      private var _awardList:Object;
      
      public function GroupPurchaseAwardAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         _awardList = {};
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new GroupPurchaseAwardInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               _awardList[_loc2_.SortID] = _loc2_;
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get awardList() : Object
      {
         return _awardList;
      }
   }
}
