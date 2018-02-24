package ddt.view.pageSelector
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PageSelector extends Sprite implements Disposeable
   {
       
      
      private var _itemList;
      
      private var _itemDataArr:Array;
      
      private var _curPage:Number = 1;
      
      protected var _rightBtn:BaseButton;
      
      protected var _leftBtn:BaseButton;
      
      protected var _numBG:Scale9CornerImage;
      
      protected var _pageNum:FilterFrameText;
      
      private var _totalPage:Number = 1;
      
      private var _itemLengthPerPage:Number = 0;
      
      public function PageSelector(){super();}
      
      public function set itemList(param1:*) : void{}
      
      public function set itemDataArr(param1:Array) : void{}
      
      public function set updateItemDataArr(param1:Array) : void{}
      
      public function get curPage() : Number{return 0;}
      
      public function setRightBtn(param1:String) : void{}
      
      public function setLeftBtn(param1:String) : void{}
      
      public function setNumBG(param1:String) : void{}
      
      public function setPageNumber(param1:String) : void{}
      
      public function updateByIndex(param1:int) : void{}
      
      private function mouseClickHander(param1:MouseEvent) : void{}
      
      public function setPageArr() : void{}
      
      private function clearAllItemData() : void{}
      
      public function dispose() : void{}
   }
}
