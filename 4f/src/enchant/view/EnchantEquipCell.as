package enchant.view
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class EnchantEquipCell extends EnchantCell
   {
       
      
      public function EnchantEquipCell(param1:int, param2:int, param3:ItemTemplateInfo = null, param4:Boolean = true, param5:DisplayObject = null, param6:Boolean = true){super(null,null,null,null,null,null);}
      
      override protected function addEnchantMc() : void{}
      
      override public function get tipStyle() : String{return null;}
   }
}
