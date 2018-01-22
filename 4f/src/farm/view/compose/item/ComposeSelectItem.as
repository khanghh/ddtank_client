package farm.view.compose.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import farm.view.compose.event.SelectComposeItemEvent;
   import farm.view.compose.vo.FoodComposeListTemplateInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ComposeSelectItem extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _bgImg:Bitmap;
      
      private var _id:int;
      
      public function ComposeSelectItem(){super();}
      
      private function init() : void{}
      
      private function initEvents() : void{}
      
      private function __mouseOver(param1:MouseEvent) : void{}
      
      private function __mouseOut(param1:MouseEvent) : void{}
      
      private function __click(param1:MouseEvent) : void{}
      
      public function set info(param1:FoodComposeListTemplateInfo) : void{}
      
      public function dispose() : void{}
   }
}
