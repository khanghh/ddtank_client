package bagAndInfo.energyData
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class EnergyDataAnalyzer extends DataAnalyzer
   {
       
      
      private var _data:Object;
      
      public function EnergyDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:XML = new XML(param1);
         _data = {};
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length())
            {
               _loc3_ = new EnergyData();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc5_[_loc6_]);
               _loc2_ = _loc5_[_loc6_].@Count;
               if(!_data[_loc2_])
               {
                  _data[_loc2_] = _loc3_;
               }
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc4_.@message;
            onAnalyzeError();
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}
