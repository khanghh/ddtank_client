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
      
      public function TryonCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true){super(null,null,null,null);}
      
      override protected function init() : void{}
      
      override protected function onMouseOut(param1:MouseEvent) : void{}
      
      override protected function onMouseOver(param1:MouseEvent) : void{}
      
      override protected function updateSize(param1:Sprite) : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
