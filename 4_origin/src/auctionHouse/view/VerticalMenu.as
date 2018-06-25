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
      
      public function VerticalMenu($tabWidth:Number, $l1Width:Number, $l2Width:Number)
      {
         super();
         tabWidth = $tabWidth;
         l1Width = $l1Width;
         l2Width = $l2Width;
         rootMenu = [];
         subMenus = [];
      }
      
      public function addItemAt($item:IMenuItem, parentIndex:int = -1) : void
      {
         var i:* = 0;
         if(parentIndex == -1)
         {
            rootMenu.push($item);
            $item.addEventListener("click",rootMenuClickHandler);
         }
         else
         {
            if(!subMenus[parentIndex])
            {
               for(i = uint(0); i <= parentIndex; )
               {
                  if(!subMenus[i])
                  {
                     subMenus[i] = [];
                  }
                  i++;
               }
            }
            $item.x = tabWidth;
            $item.addEventListener("click",subMenuClickHandler);
            subMenus[parentIndex].push($item);
         }
         addChild($item as DisplayObject);
         closeAll();
      }
      
      public function closeAll() : void
      {
         var i:* = 0;
         var i1:* = 0;
         var i2:* = 0;
         for(i = uint(0); i < rootMenu.length; )
         {
            rootMenu[i].y = i * l1Width;
            rootMenu[i].isOpen = false;
            rootMenu[i].enable = true;
            i++;
         }
         for(i1 = uint(0); i1 < subMenus.length; )
         {
            for(i2 = uint(0); i2 < subMenus[i1].length; )
            {
               subMenus[i1][i2].visible = false;
               subMenus[i1][i2].y = 0;
               i2++;
            }
            i1++;
         }
         _height = rootMenu.length * l1Width;
      }
      
      public function get $height() : Number
      {
         return _height;
      }
      
      protected function rootMenuClickHandler(e:MouseEvent) : void
      {
         var i:* = 0;
         var j:* = 0;
         SoundManager.instance.play("008");
         if(currentItem != null)
         {
            currentItem.enable = true;
         }
         currentItem = e.currentTarget as IMenuItem;
         var _index:int = rootMenu.indexOf(currentItem);
         if(currentItem.isOpen)
         {
            closeAll();
            currentItem.enable = true;
            for(i = uint(0); i < subMenus.length; )
            {
               for(j = uint(0); j < subMenus[i].length; )
               {
                  subMenus[i][j].enable = true;
                  j++;
               }
               i++;
            }
         }
         else
         {
            closeAll();
            openItemByIndex(_index);
            isseach = false;
            currentItem.enable = false;
         }
         dispatchEvent(new Event("menuRefresh"));
      }
      
      private function closeItems() : void
      {
      }
      
      private function openItemByIndex(index:uint) : void
      {
         var i:* = 0;
         var i1:* = 0;
         var i2:* = 0;
         if(!subMenus[index])
         {
            return;
         }
         i = uint(0);
         while(i < rootMenu.length)
         {
            if(i <= index)
            {
               rootMenu[i].y = i * l1Width;
            }
            else
            {
               rootMenu[i].y = i * l1Width + subMenus[index].length * l2Width;
            }
            i++;
         }
         for(i1 = uint(0); i1 < subMenus.length; )
         {
            for(i2 = uint(0); i2 < subMenus[i1].length; )
            {
               if(i1 == index)
               {
                  subMenus[i1][i2].visible = true;
                  subMenus[i1][i2].enable = true;
                  subMenus[i1][i2].y = (index + 1) * l1Width + i2 * l2Width;
               }
               else
               {
                  subMenus[i1][i2].visible = false;
               }
               i2++;
            }
            i1++;
         }
         _height = rootMenu.length * l1Width + subMenus[index].length * l2Width;
         rootMenu[index].isOpen = true;
      }
      
      public function dispose() : void
      {
         var i:* = 0;
         var i1:* = 0;
         var i2:* = 0;
         if(rootMenu)
         {
            for(i = uint(0); i < rootMenu.length; )
            {
               rootMenu[i].removeEventListener("click",rootMenuClickHandler);
               ObjectUtils.disposeObject(rootMenu[i]);
               rootMenu[i] = null;
               i++;
            }
         }
         rootMenu = null;
         if(subMenus)
         {
            for(i1 = uint(0); i1 < subMenus.length; )
            {
               for(i2 = uint(0); i2 < subMenus[i1].length; )
               {
                  subMenus[i1][i2].removeEventListener("click",subMenuClickHandler);
                  ObjectUtils.disposeObject(subMenus[i1][i2]);
                  subMenus[i1][i2] = null;
                  i2++;
               }
               i1++;
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
      
      protected function subMenuClickHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         isseach = true;
         if(currentItem)
         {
            currentItem.enable = true;
         }
         currentItem = e.currentTarget as IMenuItem;
         currentItem.enable = false;
         dispatchEvent(new Event("menuClicked"));
      }
   }
}
