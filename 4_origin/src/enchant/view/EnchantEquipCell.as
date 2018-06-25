package enchant.view
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class EnchantEquipCell extends EnchantCell
   {
       
      
      public function EnchantEquipCell(type:int, index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(type,index,info,showLoading,bg,mouseOverEffBoolean);
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
