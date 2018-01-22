package store.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import road7th.data.DictionaryData;
   
   public class StoreEquipExpericenceAnalyze extends DataAnalyzer
   {
       
      
      public var expericence:Array;
      
      public var necklaceStrengthExpList:DictionaryData;
      
      public var necklaceStrengthPlusList:DictionaryData;
      
      public function StoreEquipExpericenceAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:XML = new XML(param1);
         expericence = [];
         necklaceStrengthExpList = new DictionaryData();
         necklaceStrengthPlusList = new DictionaryData();
         if(_loc3_.@value == "true")
         {
            _loc4_ = _loc3_..item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               expericence[_loc6_] = int(_loc4_[_loc6_].@Exp);
               _loc2_ = _loc4_[_loc6_].@NecklaceStrengthExp;
               _loc5_ = _loc4_[_loc6_].@NecklaceStrengthPlus;
               necklaceStrengthExpList.add(_loc6_,_loc2_);
               necklaceStrengthPlusList.add(_loc6_,_loc5_);
               _loc6_++;
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
