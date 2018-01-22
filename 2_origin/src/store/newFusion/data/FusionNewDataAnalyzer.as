package store.newFusion.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class FusionNewDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Object;
      
      public function FusionNewDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:XML = new XML(param1);
         _data = {};
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length())
            {
               _loc2_ = new FusionNewVo();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc7_]);
               _loc5_ = _loc4_[_loc7_].@FusionType;
               if(!_data[_loc5_])
               {
                  _data[_loc5_] = [];
               }
               _loc6_ = _data[_loc5_];
               _loc6_.push(_loc2_);
               _loc7_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
