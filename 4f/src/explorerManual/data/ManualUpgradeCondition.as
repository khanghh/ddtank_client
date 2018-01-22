package explorerManual.data
{
   import explorerManual.data.model.ManualUpgradeInfo;
   
   public class ManualUpgradeCondition extends UpgradeConditonBase
   {
       
      
      public function ManualUpgradeCondition(){super();}
      
      override public function get materialCondition() : ManualUpgradeInfo{return null;}
      
      override public function get upgradeCondition() : ManualUpgradeInfo{return null;}
      
      override public function get targetCount() : int{return 0;}
   }
}
