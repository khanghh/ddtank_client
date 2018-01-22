package tryonSystem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import quest.TaskManager;
   import shop.view.ShopItemCell;
   
   public class TryonCell extends ShopItemCell
   {
       
      
      private var _background:ScaleBitmapImage;
      
      public function TryonCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function init() : void
      {
         super.init();
         _background = ComponentFactory.Instance.creatComponentByStylename("asset.core.tryon.cellBG");
         addChildAt(_background,0);
         overBg = ComponentFactory.Instance.creatComponentByStylename("asset.core.tryon.cellLight");
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         super.updateSize(param1);
         PositionUtils.setPos(param1,"ddt.tryoncell.pos");
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(!overBg.visible && param1)
         {
            SoundManager.instance.play("008");
         }
         overBg.visible = param1;
         TaskManager.itemAwardSelected = this.info.TemplateID;
      }
      
      public function get selected() : Boolean
      {
         return overBg.visible;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_background);
         _background = null;
         super.dispose();
      }
   }
}
