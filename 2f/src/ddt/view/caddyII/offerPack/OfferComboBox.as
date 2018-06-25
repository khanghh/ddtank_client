package ddt.view.caddyII.offerPack{   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.events.ListItemEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ComboBox;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.events.MouseEvent;      public class OfferComboBox extends ComboBox   {            public static const P_LISTITEM:String = "listItem";                   protected var _offerItemStyle:String;            protected var _offerItem:OfferItem;            public function OfferComboBox() { super(); }
            public function set offerItemStyle(value:String) : void { }
            public function set offerItem(value:OfferItem) : void { }
            public function get offerItem() : OfferItem { return null; }
            override protected function __onItemChanged(event:ListItemEvent) : void { }
            override protected function addChildren() : void { }
            override public function dispose() : void { }
            override protected function __onStageClick(event:MouseEvent) : void { }
   }}