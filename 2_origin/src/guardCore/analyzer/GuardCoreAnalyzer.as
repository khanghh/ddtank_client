package guardCore.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<GuardCoreInfo>;
      
      public function GuardCoreAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:XML = new XML(param1);
         _list = new Vector.<GuardCoreInfo>();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new GuardCoreInfo();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               _list.push(_loc5_);
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
      
      public function get list() : Vector.<GuardCoreInfo>
      {
         return _list;
      }
   }
}
