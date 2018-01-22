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
      
      public function VerticalMenu(param1:Number, param2:Number, param3:Number)
      {
         super();
         tabWidth = param1;
         l1Width = param2;
         l2Width = param3;
         rootMenu = [];
         subMenus = [];
      }
      
      public function addItemAt(param1:IMenuItem, param2:int = -1) : void
      {
         var _loc3_:* = 0;
         if(param2 == -1)
         {
            rootMenu.push(param1);
            param1.addEventListener("click",rootMenuClickHandler);
         }
         else
         {
            if(!subMenus[param2])
            {
               _loc3_ = uint(0);
               while(_loc3_ <= param2)
               {
                  if(!subMenus[_loc3_])
                  {
                     subMenus[_loc3_] = [];
                  }
                  _loc3_++;
               }
            }
            param1.x = tabWidth;
            param1.addEventListener("click",subMenuClickHandler);
            subMenus[param2].push(param1);
         }
         addChild(param1 as DisplayObject);
         closeAll();
      }
      
      public function closeAll() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc1_:* = 0;
         _loc3_ = uint(0);
         while(_loc3_ < rootMenu.length)
         {
            rootMenu[_loc3_].y = _loc3_ * l1Width;
            rootMenu[_loc3_].isOpen = false;
            rootMenu[_loc3_].enable = true;
            _loc3_++;
         }
         _loc2_ = uint(0);
         while(_loc2_ < subMenus.length)
         {
            _loc1_ = uint(0);
            while(_loc1_ < subMenus[_loc2_].length)
            {
               subMenus[_loc2_][_loc1_].visible = false;
               subMenus[_loc2_][_loc1_].y = 0;
               _loc1_++;
            }
            _loc2_++;
         }
         _height = rootMenu.length * l1Width;
      }
      
      public function get $height() : Number
      {
         return _height;
      }
      
      protected function rootMenuClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         SoundManager.instance.play("008");
         if(currentItem != null)
         {
            currentItem.enable = true;
         }
         currentItem = param1.currentTarget as IMenuItem;
         var _loc2_:int = rootMenu.indexOf(currentItem);
         if(currentItem.isOpen)
         {
            closeAll();
            currentItem.enable = true;
            _loc4_ = uint(0);
            while(_loc4_ < subMenus.length)
            {
               _loc3_ = uint(0);
               while(_loc3_ < subMenus[_loc4_].length)
               {
                  subMenus[_loc4_][_loc3_].enable = true;
                  _loc3_++;
               }
               _loc4_++;
            }
         }
         else
         {
            closeAll();
            openItemByIndex(_loc2_);
            isseach = false;
            currentItem.enable = false;
         }
         dispatchEvent(new Event("menuRefresh"));
      }
      
      private function closeItems() : void
      {
      }
      
      private function openItemByIndex(param1:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(!subMenus[param1])
         {
            return;
         }
         _loc4_ = uint(0);
         while(_loc4_ < rootMenu.length)
         {
            if(_loc4_ <= param1)
            {
               rootMenu[_loc4_].y = _loc4_ * l1Width;
            }
            else
            {
               rootMenu[_loc4_].y = _loc4_ * l1Width + subMenus[param1].length * l2Width;
            }
            _loc4_++;
         }
         _loc3_ = uint(0);
         while(_loc3_ < subMenus.length)
         {
            _loc2_ = uint(0);
            while(_loc2_ < subMenus[_loc3_].length)
            {
               if(_loc3_ == param1)
               {
                  subMenus[_loc3_][_loc2_].visible = true;
                  subMenus[_loc3_][_loc2_].enable = true;
                  subMenus[_loc3_][_loc2_].y = (param1 + 1) * l1Width + _loc2_ * l2Width;
               }
               else
               {
                  subMenus[_loc3_][_loc2_].visible = false;
               }
               _loc2_++;
            }
            _loc3_++;
         }
         _height = rootMenu.length * l1Width + subMenus[param1].length * l2Width;
         rootMenu[param1].isOpen = true;
      }
      
      public function dispose() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc1_:* = 0;
         if(rootMenu)
         {
            _loc3_ = uint(0);
            while(_loc3_ < rootMenu.length)
            {
               rootMenu[_loc3_].removeEventListener("click",rootMenuClickHandler);
               ObjectUtils.disposeObject(rootMenu[_loc3_]);
               rootMenu[_loc3_] = null;
               _loc3_++;
            }
         }
         rootMenu = null;
         if(subMenus)
         {
            _loc2_ = uint(0);
            while(_loc2_ < subMenus.length)
            {
               _loc1_ = uint(0);
               while(_loc1_ < subMenus[_loc2_].length)
               {
                  subMenus[_loc2_][_loc1_].removeEventListener("click",subMenuClickHandler);
                  ObjectUtils.disposeObject(subMenus[_loc2_][_loc1_]);
                  subMenus[_loc2_][_loc1_] = null;
                  _loc1_++;
               }
               _loc2_++;
            }
         }
         subMenus = null;
         currentItem = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      protected function subMenuClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         isseach = true;
         if(currentItem)
         {
            currentItem.enable = true;
         }
         currentItem = param1.currentTarget as IMenuItem;
         currentItem.enable = false;
         dispatchEvent(new Event("menuClicked"));
      }
   }
}
