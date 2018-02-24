package auctionHouse.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class VerticalMenu extends Sprite implements Disposeable
   {
      
      public static const MENU_CLICKED:String = "menuClicked";
      
      public static const MENU_REFRESH:String = "menuRefresh";
       
      
      private var tabWidth:Number;
      
      private var l1Width:Number;
      
      private var l2Width:Number;
      
      private var subMenus:Array;
      
      private var rootMenu:Array;
      
      public var currentItem:IMenuItem;
      
      public var isseach:Boolean;
      
      private var _height:int;
      
      public function VerticalMenu(param1:Number, param2:Number, param3:Number){super();}
      
      public function addItemAt(param1:IMenuItem, param2:int = -1) : void{}
      
      public function closeAll() : void{}
      
      public function get $height() : Number{return 0;}
      
      protected function rootMenuClickHandler(param1:MouseEvent) : void{}
      
      private function closeItems() : void{}
      
      private function openItemByIndex(param1:uint) : void{}
      
      public function dispose() : void{}
      
      protected function subMenuClickHandler(param1:MouseEvent) : void{}
   }
}
