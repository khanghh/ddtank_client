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
      
      public function RoomListTipPanel(param1:int, param2:int)
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
      
      public function addItem(param1:Bitmap, param2:int) : void
      {
         var _loc3_:TipItemView = new TipItemView(param1,param2,_cellWidth,_cellheight);
         _loc3_.addEventListener("click",__itemClick);
         _list.addChild(_loc3_);
         _itemArray.push(_loc3_);
         _bg.height = _bg.height + (_cellheight + 1);
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         _value = (param1.target as TipItemView).value;
         dispatchEvent(new Event("hardLvChange"));
         this.visible = false;
      }
      
      private function cleanItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemArray.length)
         {
            (_itemArray[_loc1_] as TipItemView).removeEventListener("click",__itemClick);
            (_itemArray[_loc1_] as TipItemView).dispose();
            _loc1_++;
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
