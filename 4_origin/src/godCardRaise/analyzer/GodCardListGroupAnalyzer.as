package godCardRaise.analyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardListGroupAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function GodCardListGroupAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc11_:int = 0;
         var _loc10_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:XML = new XML(param1);
         _list = [];
         if(_loc5_.@value == "true")
         {
            _loc6_ = _loc5_..Item;
            _loc11_ = 0;
            while(_loc11_ < _loc6_.length())
            {
               _loc10_ = new GodCardListGroupInfo();
               _loc9_ = [];
               _loc8_ = _loc6_[_loc11_]..ItemDetail;
               _loc7_ = 0;
               while(_loc7_ < _loc8_.length())
               {
                  _loc2_ = _loc8_[_loc7_].@CardID;
                  _loc3_ = _loc8_[_loc7_].@Number;
                  _loc9_.push({
                     "cardId":_loc2_,
                     "cardCount":_loc3_
                  });
                  _loc7_++;
               }
               ObjectUtils.copyPorpertiesByXML(_loc10_,_loc6_[_loc11_]);
               _loc10_.Cards = _loc9_;
               _list.push(_loc10_);
               _loc11_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
         }
      }
      
      public function get list() : Array
      {
         return _list;
      }
   }
}
