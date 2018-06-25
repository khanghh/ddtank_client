package store.data
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import flash.utils.getTimer;
   
   public class PreviewInfoII
   {
       
      
      private var _info:InventoryItemInfo;
      
      private var _rate:int;
      
      public function PreviewInfoII()
      {
         super();
         _info = new InventoryItemInfo();
      }
      
      public function data(id:int, beginDate:Number = 7) : void
      {
         _info.TemplateID = id;
         ItemManager.fill(_info);
         _info.BeginDate = String(getTimer());
         _info.ValidDate = beginDate;
         _info.IsJudge = true;
      }
      
      public function setComposeProperty(agilityCompose:int, attackCompose:int, defendCompose:int, luckCompose:int) : void
      {
         _info.AgilityCompose = agilityCompose;
         _info.AttackCompose = attackCompose;
         _info.DefendCompose = defendCompose;
         _info.LuckCompose = luckCompose;
      }
      
      public function get info() : InventoryItemInfo
      {
         return this._info;
      }
      
      public function set rate($rate:int) : void
      {
         this._rate = $rate;
      }
      
      public function get rate() : int
      {
         return this._rate;
      }
   }
}
