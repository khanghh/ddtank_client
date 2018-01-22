package accumulativeLogin
{
   import accumulativeLogin.data.AccumulativeLoginRewardData;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   
   public class AccumulativeLoginAnalyer extends DataAnalyzer
   {
       
      
      private var _accumulativeloginDataDic:Dictionary;
      
      public function AccumulativeLoginAnalyer(param1:Function)
      {
         super(param1);
         _accumulativeloginDataDic = new Dictionary();
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc5_:XML = new XML(param1);
         if(_loc5_.@value == "true")
         {
            _loc6_ = _loc5_..Item;
            _loc2_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length())
            {
               _loc4_ = new AccumulativeLoginRewardData();
               ObjectUtils.copyPorpertiesByXML(_loc4_,_loc6_[_loc7_]);
               _loc2_.push(_loc4_);
               _loc7_++;
            }
            var _loc9_:int = 0;
            var _loc8_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               if(!_accumulativeloginDataDic[_loc3_.Count])
               {
                  _accumulativeloginDataDic[_loc3_.Count] = [];
               }
               _accumulativeloginDataDic[_loc3_.Count].push(_loc3_);
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
            onAnalyzeError();
         }
      }
      
      public function get accumulativeloginDataDic() : Dictionary
      {
         return _accumulativeloginDataDic;
      }
   }
}
