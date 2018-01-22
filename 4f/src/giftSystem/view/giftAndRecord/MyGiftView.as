package giftSystem.view.giftAndRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import giftSystem.MyGiftCellInfo;
   import giftSystem.element.MyGiftItem;
   
   public class MyGiftView extends Sprite implements Disposeable
   {
       
      
      private var _myGiftItemContainerAll:VBox;
      
      private var _myGiftItemContainers:Vector.<HBox>;
      
      private var _panel:ScrollPanel;
      
      private var _count:int = 0;
      
      private var _line:int = 0;
      
      private var _itemArr:Vector.<MyGiftItem>;
      
      public function MyGiftView(){super();}
      
      private function initView() : void{}
      
      public function setList(param1:Vector.<MyGiftCellInfo>) : void{}
      
      public function addItem(param1:MyGiftCellInfo) : void{}
      
      public function upItem(param1:MyGiftCellInfo) : void{}
      
      private function clearList() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
