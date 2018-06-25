package room.view.bigMapInfoPanel
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DropList extends Sprite implements Disposeable
   {
      
      public static const LARGE:String = "large";
      
      public static const SMALL:String = "small";
       
      
      private var _bg:ScaleUpDownImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var _cells:Array;
      
      private var _scrollPanelRect:Rectangle;
      
      public function DropList()
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dropListBg");
         addChild(_bg);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("asset.ddtroom.dropListPanel");
         _scrollPanel.vScrollProxy = 0;
         _scrollPanel.hScrollProxy = 2;
         addChild(_scrollPanel);
         _scrollPanelRect = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dropList.scrollPanelRect");
         _list = new SimpleTileList(5);
         _list.hSpace = 4;
         _list.vSpace = 5;
         _cells = [];
         _scrollPanel.addEventListener("rollOver",__overHandler);
         _scrollPanel.addEventListener("rollOut",__outHandler);
      }
      
      public function set info(value:Array) : void
      {
         var cell:* = null;
         var item:* = null;
         var cell1:* = null;
         while(_cells.length > 0)
         {
            cell = _cells.shift();
            cell.dispose();
         }
         var rect:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dropList.cellRect");
         var _loc8_:int = 0;
         var _loc7_:* = value;
         for each(var id in value)
         {
            item = ItemManager.Instance.getTemplateById(id);
            cell1 = new BaseCell(ComponentFactory.Instance.creatBitmap("asset.ddtroom.dropCellBgAsset"),item);
            cell1.overBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.dropCellOverBgAsset");
            cell1.setContentSize(rect.width,rect.height);
            cell1.PicPos = new Point(rect.x,rect.y);
            _list.addChild(cell1);
            _cells.push(cell1);
         }
         _scrollPanel.setView(_list);
         _scrollPanel.height = _scrollPanelRect.width;
         _scrollPanel.invalidateViewport();
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         _bg.height = _scrollPanelRect.x;
         _scrollPanel.height = _scrollPanelRect.height;
         _scrollPanel.invalidateViewport();
         _scrollPanel.viewPort.viewPosition = new IntPoint(0,0);
         dispatchEvent(new Event("large"));
      }
      
      private function __outHandler(event:MouseEvent) : void
      {
         _bg.height = _scrollPanelRect.y;
         _scrollPanel.height = _scrollPanelRect.width;
         _scrollPanel.invalidateViewport();
         _scrollPanel.viewPort.viewPosition = new IntPoint(0,0);
         dispatchEvent(new Event("small"));
      }
      
      public function dispose() : void
      {
         _scrollPanel.removeEventListener("rollOver",__overHandler);
         _scrollPanel.removeEventListener("rollOut",__outHandler);
         _list.dispose();
         _list = null;
         _scrollPanel.dispose();
         _scrollPanel = null;
         _bg.dispose();
         _bg = null;
         _cells = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
