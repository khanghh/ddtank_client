package enchant.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class EnchantItemCell extends EnchantCell
   {
       
      
      public function EnchantItemCell(param1:int, param2:int, param3:ItemTemplateInfo = null, param4:Boolean = true, param5:DisplayObject = null, param6:Boolean = true)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("ddtstore.StoneCountText");
         _tbxCount.mouseEnabled = false;
         _tbxCount.x = 5;
         _tbxCount.y = 36;
         addChild(_tbxCount);
      }
   }
}
