package auctionHouse.view{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;      public class VerticalMenu extends Sprite implements Disposeable   {            public static const MENU_CLICKED:String = "menuClicked";            public static const MENU_REFRESH:String = "menuRefresh";                   private var tabWidth:Number;            private var l1Width:Number;            private var l2Width:Number;            private var subMenus:Array;            private var rootMenu:Array;            public var currentItem:IMenuItem;            public var isseach:Boolean;            private var _height:int;            public function VerticalMenu($tabWidth:Number, $l1Width:Number, $l2Width:Number) { super(); }
            public function addItemAt($item:IMenuItem, parentIndex:int = -1) : void { }
            public function closeAll() : void { }
            public function get $height() : Number { return 0; }
            protected function rootMenuClickHandler(e:MouseEvent) : void { }
            private function closeItems() : void { }
            private function openItemByIndex(index:uint) : void { }
            public function dispose() : void { }
            protected function subMenuClickHandler(e:MouseEvent) : void { }
   }}