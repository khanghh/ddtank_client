package enchant.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.events.Event;      public class EnchantCell extends BagCell   {                   private var _type:int;            private var _itemBagType:int;            public function EnchantCell(type:int, index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true) { super(null,null,null,null,null); }
            override protected function initEvent() : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            protected function __clickHandler(event:Event) : void { }
            override protected function removeEvent() : void { }
   }}