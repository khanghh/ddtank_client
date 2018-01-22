package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfoOfSended;
   import flash.utils.describeType;
   
   public class SendedEmailAnalyze extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function SendedEmailAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         _list = [];
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc4_ = _loc2_.Item;
            _loc3_ = describeType(new EmailInfoOfSended());
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new EmailInfoOfSended();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               list.push(_loc5_);
               _loc6_++;
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
      
      public function get list() : Array
      {
         return _list;
      }
   }
}
