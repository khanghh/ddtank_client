package enchant.view{   import ddt.data.goods.ItemTemplateInfo;   import flash.display.DisplayObject;      public class EnchantEquipCell extends EnchantCell   {                   public function EnchantEquipCell(type:int, index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null,null); }
            override protected function addEnchantMc() : void { }
            override public function get tipStyle() : String { return null; }
   }}