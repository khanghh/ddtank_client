package mark.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import mark.data.MarkSetTemplateData;
   
   public class MarkSetAnalyzer extends DataAnalyzer
   {
       
      
      public var sets:Dictionary = null;
      
      public function MarkSetAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         sets = new Dictionary();
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc5_ = _loc3_.Item.length();
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_ = new MarkSetTemplateData();
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc6_]);
               sets[_loc2_.SetId] = _loc2_;
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
