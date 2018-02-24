package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import email.MailManager;
   import flash.utils.describeType;
   import road7th.utils.DateUtils;
   
   public class AllEmailAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Array;
      
      public function AllEmailAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Array{return null;}
      
      private function getAnnexPos(param1:EmailInfo, param2:InventoryItemInfo) : int{return 0;}
   }
}
