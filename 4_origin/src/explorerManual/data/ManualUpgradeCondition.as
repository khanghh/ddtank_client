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
         var info:* = null;
         var i:int = 0;
         if(_conditions == null)
         {
            return null;
         }
         i = 0;
         while(i < _conditions.length)
         {
            if(_conditions[i].ConditionType == 1)
            {
               info = _conditions[i];
               break;
            }
            i++;
         }
         return info;
      }
      
      override public function get upgradeCondition() : ManualUpgradeInfo
      {
         var info:* = null;
         var i:int = 0;
         if(_conditions == null)
         {
            return null;
         }
         i = 0;
         while(i < _conditions.length)
         {
            if(_conditions[i].ConditionType != 1)
            {
               info = _conditions[i];
               break;
            }
            i++;
         }
         return info;
      }
      
      override public function get targetCount() : int
      {
         var target:int = 0;
         var info:ManualUpgradeInfo = upgradeCondition;
         if(info == null)
         {
            return 0;
         }
         switch(int(info.ConditionType) - 2)
         {
            case 0:
               target = info.Parameter1;
               break;
            case 1:
               target = info.Parameter2;
               break;
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
               target = 1;
         }
         return target;
      }
   }
}
