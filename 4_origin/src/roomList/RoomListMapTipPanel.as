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
      
      public function RoomListMapTipPanel(param1:int, param2:int)
      {
         _cellWidth = param1;
         _cellheight = param2;
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
      
      public function addItem(param1:int) : void
      {
         var _loc2_:MapItemView = new MapItemView(param1,_cellWidth,_cellheight);
         _loc2_.addEventListener("click",__itemClick);
         _listContent.addChild(_loc2_);
         _itemArray.push(_loc2_);
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("asset.ddtroomList.RoomListMapTipPanel.BGSize");
         _bg.width = _loc3_.x;
         _bg.height = _loc3_.y;
         _list.invalidateViewport();
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         _value = (param1.target as MapItemView).id;
         dispatchEvent(new Event("fbChange"));
         this.visible = false;
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemArray.length)
         {
            (_itemArray[_loc1_] as MapItemView).removeEventListener("click",__itemClick);
            (_itemArray[_loc1_] as MapItemView).dispose();
            _loc1_++;
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
