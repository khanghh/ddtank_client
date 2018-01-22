package cloudBuyLottery.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CloudBuyAnalyzer extends DataAnalyzer
   {
       
      
      public var dataArr:Array;
      
      public function CloudBuyAnalyzer(param1:Function)
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
            _loc4_ = _loc3_..ItemLog;
            dataArr = [];
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc2_ = new CloudBuyLogInfo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc5_]);
               dataArr.push(_loc2_);
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
   }
}
