package enchant.view
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class EnchantEquipCell extends EnchantCell
   {
       
      
      public function EnchantEquipCell(param1:int, param2:int, param3:ItemTemplateInfo = null, param4:Boolean = true, param5:DisplayObject = null, param6:Boolean = true)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      override protected function addEnchantMc() : void
      {
         _enchantMcName = "asset.enchant.equip.level";
         _enchantMcPosStr = "enchant.equip.levelMcPos";
         super.addEnchantMc();
      }
      
      override public function get tipStyle() : String
      {
         return "enchant.enchantTips";
      }
   }
}
