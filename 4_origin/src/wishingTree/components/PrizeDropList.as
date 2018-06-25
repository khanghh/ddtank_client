package wishingTree.components
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class PrizeDropList extends Sprite implements Disposeable
   {
      
      public static const LARGE:String = "large";
      
      public static const SMALL:String = "small";
       
      
      private var _bg:ScaleUpDownImage;
      
      private var _arrow:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _mask:Sprite;
      
      private var _list:SimpleTileList;
      
      private var _cells:Array;
      
      public function PrizeDropList()
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("wishingTree.prizeScaleBg");
         addChild(_bg);
         _arrow = ComponentFactory.Instance.creat("wishingTree.arrow");
         addChild(_arrow);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wishingTree.dropListPanel");
         _scrollPanel.vScrollProxy = 2;
         _scrollPanel.hScrollProxy = 2;
         addChild(_scrollPanel);
         _list = new SimpleTileList(4);
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
         var _loc7_:int = 0;
         var _loc6_:* = value;
         for each(var id in value)
         {
            item = ItemManager.Instance.getTemplateById(id);
            cell1 = new BaseCell(ComponentFactory.Instance.creatBitmap("wishingTree.itemBg"),item);
            cell1.overBg = ComponentFactory.Instance.creatBitmap("wishingTree.itemBgOver");
            cell1.setContentSize(43,43);
            cell1.PicPos = new Point(5,5);
            _list.addChild(cell1);
            _cells.push(cell1);
         }
         _scrollPanel.setView(_list);
         _scrollPanel.height = 58;
         _scrollPanel.invalidateViewport();
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         _bg.height = 156;
         _scrollPanel.height = 165;
         _scrollPanel.invalidateViewport();
         _scrollPanel.viewPort.viewPosition = new IntPoint(0,0);
         _arrow.visible = false;
         dispatchEvent(new Event("large"));
      }
      
      private function __outHandler(event:MouseEvent) : void
      {
         _bg.height = 97;
         _scrollPanel.height = 58;
         _scrollPanel.invalidateViewport();
         _scrollPanel.viewPort.viewPosition = new IntPoint(0,0);
         _arrow.visible = true;
         dispatchEvent(new Event("small"));
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         _scrollPanel.removeEventListener("rollOver",__overHandler);
         _scrollPanel.removeEventListener("rollOut",__outHandler);
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         for(i = 0; i <= _cells.length - 1; )
         {
            ObjectUtils.disposeObject(_cells[i]);
            _cells[i] = null;
            i++;
         }
         _cells = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
