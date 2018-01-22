package superWinner.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import superWinner.data.SuperWinnerAwardsMode;
   
   public class SuperWinnerAnalyze extends DataAnalyzer
   {
       
      
      private var _awardsArr:Vector.<Object>;
      
      public function SuperWinnerAnalyze(param1:Function)
      {
         _awardsArr = new Vector.<Object>();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc9_:* = undefined;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = 0;
         var _loc7_:* = null;
         var _loc4_:XML = new XML(param1);
         var _loc5_:XMLList = _loc4_..Item;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc9_ = new Vector.<SuperWinnerAwardsMode>();
            _awardsArr.push(_loc9_);
            _loc3_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length())
         {
            _loc6_ = _loc5_[_loc8_];
            _loc2_ = uint(_loc6_.@rank - 1);
            _loc7_ = new SuperWinnerAwardsMode();
            _loc7_.type = _loc6_.@rank;
            _loc7_.goodId = _loc6_.@template;
            _loc7_.count = _loc6_.@count;
            (_awardsArr[5 - _loc2_] as Vector.<SuperWinnerAwardsMode>).push(_loc7_);
            _loc8_++;
         }
         onAnalyzeComplete();
      }
      
      public function get awards() : Vector.<Object>
      {
         return _awardsArr;
      }
   }
}
