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
      
      public function TryonCell(bg:DisplayObject, $info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true)
      {
         super(bg,$info,showLoading,showTip);
      }
      
      override protected function init() : void
      {
         super.init();
         _background = ComponentFactory.Instance.creatComponentByStylename("asset.core.tryon.cellBG");
         addChildAt(_background,0);
         overBg = ComponentFactory.Instance.creatComponentByStylename("asset.core.tryon.cellLight");
      }
      
      override protected function onMouseOut(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function updateSize(sp:Sprite) : void
      {
         super.updateSize(sp);
         PositionUtils.setPos(sp,"ddt.tryoncell.pos");
      }
      
      public function set selected(value:Boolean) : void
      {
         if(!overBg.visible && value)
         {
            SoundManager.instance.play("008");
         }
         overBg.visible = value;
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
