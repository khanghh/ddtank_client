package morn.core.components
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import morn.core.handlers.Handler;
   import morn.core.utils.StringUtils;
   
   public class Dialog extends View
   {
      
      public static const CLOSE:String = "close";
      
      public static const CANCEL:String = "cancel";
      
      public static const SURE:String = "sure";
      
      public static const NO:String = "no";
      
      public static const OK:String = "ok";
      
      public static const YES:String = "yes";
       
      
      protected var _dragArea:Rectangle;
      
      protected var _popupCenter:Boolean = true;
      
      protected var _closeHandler:Handler;
      
      public function Dialog()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var dragTarget:DisplayObject = getChildByName("drag");
         if(dragTarget)
         {
            dragArea = dragTarget.x + "," + dragTarget.y + "," + dragTarget.width + "," + dragTarget.height;
            removeElement(dragTarget);
         }
         addEventListener("click",onClick);
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         var btn:Button = e.target as Button;
         if(btn)
         {
            var _loc3_:* = btn.name;
            if("close" !== _loc3_)
            {
               if("cancel" !== _loc3_)
               {
                  if("sure" !== _loc3_)
                  {
                     if("no" !== _loc3_)
                     {
                        if("ok" !== _loc3_)
                        {
                           if("yes" !== _loc3_)
                           {
                           }
                        }
                        addr25:
                        close(btn.name);
                     }
                     addr24:
                     §§goto(addr25);
                  }
                  addr23:
                  §§goto(addr24);
               }
               addr22:
               §§goto(addr23);
            }
            §§goto(addr22);
         }
      }
      
      public function show(closeOther:Boolean = false) : void
      {
         App.dialog.show(this,closeOther);
      }
      
      public function popup(closeOther:Boolean = false) : void
      {
         App.dialog.popup(this,closeOther);
      }
      
      public function close(type:String = null) : void
      {
         App.dialog.close(this);
         if(_closeHandler != null)
         {
            _closeHandler.executeWith([type]);
         }
      }
      
      public function get dragArea() : String
      {
         return StringUtils.rectToString(_dragArea);
      }
      
      public function set dragArea(value:String) : void
      {
         var a:* = null;
         if(value)
         {
            a = StringUtils.fillArray([0,0,0,0],value);
            _dragArea = new Rectangle(a[0],a[1],a[2],a[3]);
            addEventListener("mouseDown",onMouseDown);
         }
         else
         {
            _dragArea = null;
            removeEventListener("mouseDown",onMouseDown);
         }
      }
      
      private function onMouseDown(e:MouseEvent) : void
      {
         if(_dragArea.contains(mouseX,mouseY))
         {
            App.drag.doDrag(this);
         }
      }
      
      public function get isPopup() : Boolean
      {
         return parent != null;
      }
      
      public function get popupCenter() : Boolean
      {
         return _popupCenter;
      }
      
      public function set popupCenter(value:Boolean) : void
      {
         _popupCenter = value;
      }
      
      public function get closeHandler() : Handler
      {
         return _closeHandler;
      }
      
      public function set closeHandler(value:Handler) : void
      {
         _closeHandler = value;
      }
   }
}
