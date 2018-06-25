package roomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RoomListTipPanel extends Sprite implements Disposeable
   {
      
      public static const HARD_LV_CHANGE:String = "hardLvChange";
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _list:VBox;
      
      private var _itemArray:Array;
      
      private var _cellWidth:int;
      
      private var _cellheight:int;
      
      private var _value:int;
      
      public function RoomListTipPanel(cellWidth:int, cellheight:int)
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
         _value = 1013;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.ddtroomList.RoomList.tipItemBg");
         _bg.width = _cellWidth;
         _bg.height = 0;
         addChild(_bg);
         _list = new VBox();
         addChild(_list);
         _itemArray = [];
      }
      
      public function addItem(itemBg:Bitmap, value:int) : void
      {
         var item:TipItemView = new TipItemView(itemBg,value,_cellWidth,_cellheight);
         item.addEventListener("click",__itemClick);
         _list.addChild(item);
         _itemArray.push(item);
         _bg.height = _bg.height + (_cellheight + 1);
      }
      
      private function __itemClick(event:MouseEvent) : void
      {
         _value = (event.target as TipItemView).value;
         dispatchEvent(new Event("hardLvChange"));
         this.visible = false;
      }
      
      private function cleanItem() : void
      {
         var i:int = 0;
         for(i = 0; i < _itemArray.length; )
         {
            (_itemArray[i] as TipItemView).removeEventListener("click",__itemClick);
            (_itemArray[i] as TipItemView).dispose();
            i++;
         }
         _itemArray = [];
      }
      
      public function dispose() : void
      {
         cleanItem();
         if(_list && _list.parent)
         {
            _list.parent.removeChild(_list);
            _list.dispose();
            _list = null;
         }
         if(_bg && _bg.parent)
         {
            _bg.parent.removeChild(_bg);
            _bg.dispose();
            _bg = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
