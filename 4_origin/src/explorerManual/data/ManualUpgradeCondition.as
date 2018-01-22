package explorerManual.data
{
   import explorerManual.data.model.ManualUpgradeInfo;
   
   public class ManualUpgradeCondition extends UpgradeConditonBase
   {
       
      
      public function ManualUpgradeCondition()
      {
         super();
      }
      
      override public function get materialCondition() : ManualUpgradeInfo
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(_conditions == null)
         {
            return null;
         }
         _loc1_ = 0;
         while(_loc1_ < _conditions.length)
         {
            if(_conditions[_loc1_].ConditionType == 1)
            {
               _loc2_ = _conditions[_loc1_];
               break;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      override public function get upgradeCondition() : ManualUpgradeInfo
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         if(_conditions == null)
         {
            return null;
         }
         _loc1_ = 0;
         while(_loc1_ < _conditions.length)
         {
            if(_conditions[_loc1_].ConditionType != 1)
            {
               _loc2_ = _conditions[_loc1_];
               break;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      override public function get targetCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ManualUpgradeInfo = upgradeCondition;
         if(_loc2_ == null)
         {
            return 0;
         }
         switch(int(_loc2_.ConditionType) - 2)
         {
            case 0:
               _loc1_ = _loc2_.Parameter1;
               break;
            case 1:
               _loc1_ = _loc2_.Parameter2;
               break;
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
               _loc1_ = 1;
         }
         return _loc1_;
      }
   }
}
