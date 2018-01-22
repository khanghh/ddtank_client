package ddt.data.analyze
{
   import cardSystem.data.CardGrooveInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   public class CardGrooveEventAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Dictionary;
      
      public function CardGrooveEventAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         _list = new Dictionary();
         var _loc2_:XML = new XML(param1);
         if(_loc2_.@value == "true")
         {
            _loc4_ = _loc2_..Item;
            _loc3_ = describeType(new CardGrooveInfo());
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc5_ = new CardGrooveInfo();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc4_[_loc6_]);
               _list[_loc5_.Level + "," + _loc5_.Type] = _loc5_;
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
      
      public function get list() : Dictionary
      {
         return _list;
      }
   }
}
