package consortion.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class ConsortiaTaskRankAnalyzer extends DataAnalyzer
   {
       
      
      private var _dataList:Array;
      
      public function ConsortiaTaskRankAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      public function get dataList() : Array
      {
         return _dataList;
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:XML = new XML(param1);
         _dataList = [];
         if(_loc2_.@value == "true")
         {
            _loc4_ = _loc2_.children();
            _loc3_ = _loc4_.length();
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc5_ = {};
               _loc5_.id = int(_loc4_[_loc6_].@ID);
               _loc5_.name = String(_loc4_[_loc6_].@NicName);
               _loc5_.rank = _loc6_ + 1;
               _loc5_.percent = Number(_loc4_[_loc6_].@Percentage);
               _loc5_.contribute = Number(_loc4_[_loc6_].@AwardRichesoffer);
               _dataList.push(_loc5_);
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc2_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
   }
}
