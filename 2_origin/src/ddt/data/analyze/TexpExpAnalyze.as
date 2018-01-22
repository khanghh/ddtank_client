package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import texpSystem.data.TexpExp;
   
   public class TexpExpAnalyze extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function TexpExpAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         list = new Dictionary();
         var _loc3_:XML = new XML(param1);
         message = _loc3_.@message;
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new TexpExp();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               _loc2_ = _loc4_[_loc6_].@Grage;
               list[_loc2_] = _loc5_;
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            onAnalyzeError();
         }
      }
   }
}
