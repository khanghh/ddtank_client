package gradeBuy.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.TimeManager;
   import ddt.utils.Helpers;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gradeBuy.GradeBuyController;
   import gradeBuy.GradeBuyManager;
   import gradeBuy.ICountDown;
   import shop.view.ShopItemCell;
   
   public class GradeBuyTypeItem extends Sprite implements Disposeable, ICountDown
   {
       
      
      public var data:Object;
      
      private var _itemCell:ShopItemCell;
      
      private var _dateRemainTxt:FilterFrameText;
      
      private var _itemInfo:ItemTemplateInfo;
      
      public function GradeBuyTypeItem(param1:Object){super();}
      
      protected function onClick(param1:MouseEvent) : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
