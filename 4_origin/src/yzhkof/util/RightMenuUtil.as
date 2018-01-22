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
      
      public static function addRightMenu(param1:InteractiveObject, param2:String) : ContextMenuItem
      {
         var _loc3_:ContextMenuItem = new ContextMenuItem(param2);
         if(param1.contextMenu == null)
         {
            param1.contextMenu = new ContextMenu();
         }
         ContextMenu(param1.contextMenu).customItems.push(_loc3_);
         return _loc3_;
      }
      
      public static function hideDefaultMenus(param1:InteractiveObject) : void
      {
         if(param1.contextMenu == null)
         {
            param1.contextMenu = new ContextMenu();
         }
         ContextMenu(param1.contextMenu).hideBuiltInItems();
      }
   }
}
