package mark.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import mark.data.MarkHammerTemplateData;
   
   public class MarkHammerAnalyzer extends DataAnalyzer
   {
       
      
      public var hammers:Array = null;
      
      public function MarkHammerAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         hammers = [];
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc5_ = _loc3_.Item.length();
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_ = new MarkHammerTemplateData();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc6_]);
               hammers.push(_loc2_);
               _loc6_++;
            }
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
         onAnalyzeComplete();
      }
   }
}
