package roomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class RoomListMapTipPanel extends Sprite implements Disposeable
   {
      
      public static const FB_CHANGE:String = "fbChange";
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _listContent:VBox;
      
      private var _itemArray:Array;
      
      private var _cellWidth:int;
      
      private var _cellheight:int;
      
      private var _list:ScrollPanel;
      
      private var _value:int;
      
      public function RoomListMapTipPanel(cellWidth:int, cellheight:int)
      {
         _cellWidth = cellWidth;
         _cellheight = cellheight;
         super();
         init();
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function resetValue() : void
      {
         _value = 10000;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.ddtroomList.RoomList.tipItemBg");
         _bg.width = _cellWidth;
         _bg.height = 0;
         addChild(_bg);
         _listContent = new VBox();
         _itemArray = [];
         _list = UICreatShortcut.creatAndAdd("asset.ddtroomList.RoomListMapTipPanel.SrollPanel",this);
         _list.setView(_listContent);
      }
      
      public function addItem(id:int) : void
      {
         var item:MapItemView = new MapItemView(id,_cellWidth,_cellheight);
         item.addEventListener("click",__itemClick);
         _listContent.addChild(item);
         _itemArray.push(item);
         var size:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.RoomListMapTipPanel.BGSize");
         _bg.width = size.x;
         _bg.height = size.y;
         _list.invalidateViewport();
      }
      
      private function __itemClick(event:MouseEvent) : void
      {
         _value = (event.target as MapItemView).id;
         dispatchEvent(new Event("fbChange"));
         this.visible = false;
      }
      
      private function cleanItem() : void
      {
         var i:int = 0;
         for(i = 0; i < _itemArray.length; )
         {
            (_itemArray[i] as MapItemView).removeEventListener("click",__itemClick);
            (_itemArray[i] as MapItemView).dispose();
            i++;
         }
         _itemArray = [];
      }
      
      public function dispose() : void
      {
         cleanItem();
         ObjectUtils.disposeObject(_listContent);
         _listContent = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
      }
   }
}
