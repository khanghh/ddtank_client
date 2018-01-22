package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.RecordInfo;
   import ddt.data.RecordItemInfo;
   
   public class RecordAnalyzer extends DataAnalyzer
   {
       
      
      private var _info:RecordInfo;
      
      public function RecordAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _info = new RecordInfo();
            _loc4_ = _loc3_..Item;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new RecordItemInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               _info.recordList.push(_loc2_);
               _loc5_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
      
      public function get info() : RecordInfo
      {
         return _info;
      }
   }
}
