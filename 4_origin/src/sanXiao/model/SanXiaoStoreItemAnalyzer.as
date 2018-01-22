package sanXiao.model
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class SanXiaoStoreItemAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function SanXiaoStoreItemAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         list = [];
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length())
            {
               _loc4_ = new SXStoreItemData();
               _loc4_.count = int(_loc3_[_loc5_].@Count);
               _loc4_.id = int(_loc3_[_loc5_].@ID);
               _loc4_.TempleteID = int(_loc3_[_loc5_].@ItemID);
               _loc4_.price = int(_loc3_[_loc5_].@Price);
               _loc4_.total = int(_loc3_[_loc5_].@LimitCount);
               _loc4_.remain = _loc4_.total;
               _loc4_.isBind = _loc3_[_loc5_].@IsBind == "true"?true:false;
               _loc4_.Valid = int(_loc3_[_loc5_].@Valid);
               list.push(_loc4_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
