package sevenDayTarget.dataAnalyzer
{
   import com.pickgliss.loader.DataAnalyzer;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   
   public class SevenDayTargetDataAnalyzer extends DataAnalyzer
   {
       
      
      public var dataList:Array;
      
      public function SevenDayTargetDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc4_:XML = new XML(param1);
         dataList = [];
         if(_loc4_.@value == "true")
         {
            _loc5_ = _loc4_..Item;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length())
            {
               _loc2_ = new NewTargetQuestionInfo();
               _loc2_.questId = _loc5_[_loc7_].@ID;
               _loc2_.Period = _loc5_[_loc7_].@Period;
               _loc3_ = _loc5_[_loc7_]..Item_Condiction;
               _loc6_ = 0;
               while(_loc6_ < _loc3_.length())
               {
                  _loc2_.linkId = _loc3_[_loc6_].@IndexType;
                  if(_loc3_[_loc6_].@CondictionID == "1")
                  {
                     _loc2_.condition1Title = _loc3_[_loc6_].@CondictionTitle;
                     _loc2_.condition1Para = _loc3_[_loc6_].@Para2;
                  }
                  else if(_loc3_[_loc6_].@CondictionID == "2")
                  {
                     _loc2_.condition2Title = _loc3_[_loc6_].@CondictionTitle;
                     _loc2_.condition2Para = _loc3_[_loc6_].@Para2;
                  }
                  else if(_loc3_[_loc6_].@CondictionID == "3")
                  {
                     _loc2_.condition3Title = _loc3_[_loc6_].@CondictionTitle;
                     _loc2_.condition3Para = _loc3_[_loc6_].@Para2;
                  }
                  _loc6_++;
               }
               dataList.push(_loc2_);
               _loc7_++;
            }
            onAnalyzeComplete();
         }
      }
   }
}
