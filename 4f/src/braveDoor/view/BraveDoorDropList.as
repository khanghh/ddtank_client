package braveDoor.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class BraveDoorDropList extends Sprite implements Disposeable
   {
       
      
      protected var _scrollPanel:ScrollPanel;
      
      protected var _list:SimpleTileList;
      
      protected var _cells:Array;
      
      protected var _scrollPanelRect:Rectangle;
      
      protected var _columnNum:int = 5;
      
      protected var _listHSpace:int = 4;
      
      protected var _listVSpace:int = 5;
      
      public function BraveDoorDropList(){super();}
      
      protected function initView() : void{}
      
      public function set info(param1:Array) : void{}
      
      public function dispose() : void{}
   }
}
