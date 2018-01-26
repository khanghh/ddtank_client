package mark.event
{
   import flash.events.Event;
   
   public class MarkEvent extends Event
   {
      
      public static const REMOE_VIEW:String = "remove_view";
      
      public static const CHOOSE_EQUIP:String = "choose_equip";
      
      public static const PUT_ON_CHIP:String = "putOnChip";
      
      public static const PUT_OFF_CHIP:String = "putOffChip";
      
      public static const UPDATE_CHIPS:String = "updateChips";
      
      public static const HAMMER_RESULT:String = "hammerResult";
      
      public static const MARK_MONEY:String = "markMoney";
      
      public static const UPDATE_CRYSTAL:String = "updateCrystal";
      
      public static const FORCE_RESULT:String = "forceResult";
      
      public static const TRANSFER_RESULT:String = "transferResult";
      
      public static const SUBMIT_RESULT:String = "submitResult";
      
      public static const UPDATE_CATALOG:String = "updateCatalog";
      
      public static const VAULTS_DATA:String = "vaultsData";
      
      public static const VAULTS_REWARD:String = "vaultsReward";
      
      public static const SELL_STATUS:String = "sellStatus";
      
      public static const CANCEL_SELL:String = "cancelSell";
      
      public static const CRYSTAL_SELECT:String = "crystalSelect";
      
      public static const UPDATE_FORCE:String = "updateForce";
      
      public static const UPDATE_OPERATION:String = "updateOperation";
      
      public static const UPDATA_MARKBAG:String = "updata_markbag";
      
      public static const SHOW_MARKTIP:String = "show_marktip";
       
      
      private var _data = null;
      
      public function MarkEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get data() : *{return null;}
   }
}
