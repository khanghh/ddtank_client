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
      
      public function BraveDoorDropList()
      {
         super();
         _cells = [];
         initView();
      }
      
      protected function initView() : void
      {
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("braveDoor.duplicateMapRoom.dropListPanel");
         _scrollPanel.vScrollProxy = 0;
         _scrollPanel.hScrollProxy = 2;
         addChild(_scrollPanel);
         _scrollPanel.visible = false;
         _scrollPanelRect = ComponentFactory.Instance.creatCustomObject("braveDoor.duplicateMapView.dropList.scrollPanelRect");
         _list = new SimpleTileList(_columnNum);
         _list.hSpace = _listHSpace;
         _list.vSpace = _listVSpace;
      }
      
      public function set info(value:Array) : void
      {
         var cell:* = null;
         var rect:* = null;
         var item:* = null;
         var cell1:* = null;
         while(_cells.length > 0)
         {
            cell = _cells.shift();
            cell.dispose();
         }
         if(value.length > 0)
         {
            if(!_scrollPanel.visible)
            {
               _scrollPanel.visible = true;
            }
            rect = ComponentFactory.Instance.creatCustomObject("braveDoor.duplicateMapView.dropList.scrollPanelRect");
            var _loc8_:int = 0;
            var _loc7_:* = value;
            for each(var id in value)
            {
               item = ItemManager.Instance.getTemplateById(id);
               cell1 = new BaseCell(ComponentFactory.Instance.creatBitmap("asset.braveDoor.dropCellBgAsset"),item);
               _list.addChild(cell1);
               _cells.push(cell1);
            }
            _scrollPanel.setView(_list);
            _scrollPanel.height = _scrollPanelRect.width;
            _scrollPanel.invalidateViewport();
         }
      }
      
      public function dispose() : void
      {
         var cell:* = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         _scrollPanelRect = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         while(_cells.length > 0)
         {
            cell = _cells.shift();
            ObjectUtils.disposeObject(cell);
         }
         _cells = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
