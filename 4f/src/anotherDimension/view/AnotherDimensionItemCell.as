package anotherDimension.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import shop.manager.ShopBuyManager;
   
   public class AnotherDimensionItemCell extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:BagCell;
      
      private var _buyImage:Bitmap;
      
      private var _itemId:int = 10620;
      
      private var _countVisible:Boolean = true;
      
      public function AnotherDimensionItemCell(){super();}
      
      private function initView() : void{}
      
      private function updateItemCellCount() : void{}
      
      private function initEvent() : void{}
      
      private function itemUpdateHandler(param1:BagEvent) : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function get itemCell() : BagCell{return null;}
   }
}
