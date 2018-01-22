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
      
      public function set info(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         while(_cells.length > 0)
         {
            _loc4_ = _cells.shift();
            _loc4_.dispose();
         }
         var _loc6_:Rectangle = ComponentFactory.Instance.creatCustomObject("asset.ddtroom.dropList.cellRect");
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(_loc2_);
            _loc5_ = new BaseCell(ComponentFactory.Instance.creatBitmap("asset.ddtroom.dropCellBgAsset"),_loc3_);
            _loc5_.overBg = ComponentFactory.Instance.creatBitmap("asset.ddtroom.dropCellOverBgAsset");
            _loc5_.setContentSize(_loc6_.width,_loc6_.height);
            _loc5_.PicPos = new Point(_loc6_.x,_loc6_.y);
            _list.addChild(_loc5_);
            _cells.push(_loc5_);
         }
         _scrollPanel.setView(_list);
         _scrollPanel.height = _scrollPanelRect.width;
         _scrollPanel.invalidateViewport();
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _bg.height = _scrollPanelRect.x;
         _scrollPanel.height = _scrollPanelRect.height;
         _scrollPanel.invalidateViewport();
         _scrollPanel.viewPort.viewPosition = new IntPoint(0,0);
         dispatchEvent(new Event("large"));
      }
      
      private function __outHandler(param1:MouseEvent) : void
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
