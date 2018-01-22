package cardSystem.view.cardBag
{
   import cardSystem.data.CardInfo;
   import cardSystem.elements.CardBagCell;
   import cardSystem.elements.CardCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardBagListItem extends Sprite implements Disposeable, IListCell
   {
      
      public static const CELL_NUM:int = 4;
       
      
      private var _dataVec:Array;
      
      private var _cellVec:Vector.<CardCell>;
      
      private var _container:HBox;
      
      public function CardBagListItem(){super();}
      
      public function get cellVec() : Vector.<CardCell>{return null;}
      
      private function initEvent() : void{}
      
      private function initView() : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      override public function get height() : Number{return 0;}
      
      private function upView() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
