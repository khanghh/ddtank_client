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
      
      public function set info(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         while(_cells.length > 0)
         {
            _loc4_ = _cells.shift();
            _loc4_.dispose();
         }
         if(param1.length > 0)
         {
            if(!_scrollPanel.visible)
            {
               _scrollPanel.visible = true;
            }
            _loc6_ = ComponentFactory.Instance.creatCustomObject("braveDoor.duplicateMapView.dropList.scrollPanelRect");
            var _loc8_:int = 0;
            var _loc7_:* = param1;
            for each(var _loc2_ in param1)
            {
               _loc3_ = ItemManager.Instance.getTemplateById(_loc2_);
               _loc5_ = new BaseCell(ComponentFactory.Instance.creatBitmap("asset.braveDoor.dropCellBgAsset"),_loc3_);
               _list.addChild(_loc5_);
               _cells.push(_loc5_);
            }
            _scrollPanel.setView(_list);
            _scrollPanel.height = _scrollPanelRect.width;
            _scrollPanel.invalidateViewport();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
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
            _loc1_ = _cells.shift();
            ObjectUtils.disposeObject(_loc1_);
         }
         _cells = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
