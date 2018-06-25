package enchant.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class EnchantItemCell extends EnchantCell
   {
       
      
      public function EnchantItemCell(type:int, index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(type,index,info,showLoading,bg,mouseOverEffBoolean);
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
