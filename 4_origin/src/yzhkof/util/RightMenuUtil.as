package yzhkof.util
{
   import flash.display.InteractiveObject;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   public class RightMenuUtil
   {
       
      
      public function RightMenuUtil()
      {
         super();
      }
      
      public static function addRightMenu(dobj:InteractiveObject, name:String) : ContextMenuItem
      {
         var item:ContextMenuItem = new ContextMenuItem(name);
         if(dobj.contextMenu == null)
         {
            dobj.contextMenu = new ContextMenu();
         }
         ContextMenu(dobj.contextMenu).customItems.push(item);
         return item;
      }
      
      public static function hideDefaultMenus(dobj:InteractiveObject) : void
      {
         if(dobj.contextMenu == null)
         {
            dobj.contextMenu = new ContextMenu();
         }
         ContextMenu(dobj.contextMenu).hideBuiltInItems();
      }
   }
}
