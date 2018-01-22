package labyrinth.data
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class RankingAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public function RankingAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         list = [];
         var _loc3_:XML = new XML(param1);
         var _loc2_:XMLList = _loc3_..Item;
         if(_loc3_.@value == "true")
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length())
            {
               _loc5_ = new RankingInfo();
               ObjectUtils.copyPorpertiesByXML(_loc5_,_loc2_[_loc4_]);
               list.push(_loc5_);
               _loc4_++;
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
