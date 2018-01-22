package bagAndInfo.bag.ring.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   
   public class RingDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Dictionary;
      
      public function RingDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:XML = new XML(param1);
         _data = new Dictionary();
         if(_loc2_.@value == "true")
         {
            _loc3_ = _loc2_..Item;
            RingSystemData.TotalLevel = _loc3_.length();
            _loc5_ = 0;
            while(_loc5_ < RingSystemData.TotalLevel)
            {
               _loc4_ = new RingSystemData();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc3_[_loc5_]);
               _data[_loc4_.Level] = _loc4_;
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
      
      public function get data() : Dictionary
      {
         return _data;
      }
   }
}
