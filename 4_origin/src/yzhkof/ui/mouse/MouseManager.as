package yzhkof.ui.mouse
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import yzhkof.core.StageManager;
   
   public class MouseManager
   {
      
      private static var instance:MouseManager;
      
      public static const STAGE_UP_EVENT:String = "STAGE_UP_EVENT";
      
      public static const MOUSE_DOWN_AND_DRAGING_EVENT:String = "MOUSE_DOWN_AND_DRAGING_EVENT";
       
      
      private var cursorContainer:Sprite;
      
      private var _cursor:DisplayObject;
      
      public function MouseManager()
      {
         this.cursorContainer = new Sprite();
         super();
         if(instance)
         {
            throw new Error("error");
         }
         instance = this;
         this.init();
      }
      
      public static function getInstance() : MouseManager
      {
         return instance || new MouseManager();
      }
      
      public static function set cursor(param1:DisplayObject) : void
      {
         MouseManager.getInstance().cursor = param1;
      }
      
      public static function get cursor() : DisplayObject
      {
         return MouseManager.getInstance().cursor;
      }
      
      public static function registExtendMouseEvent(param1:InteractiveObject) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_DOWN,__dobjDown);
      }
      
      private static function __dobjDown(param1:MouseEvent) : void
      {
         var dobj:InteractiveObject = null;
         var fun_up:Function = null;
         var fun_move:Function = null;
         var e:MouseEvent = param1;
         dobj = e.currentTarget as InteractiveObject;
         fun_up = function(param1:MouseEvent):void
         {
            dobj.dispatchEvent(new Event(STAGE_UP_EVENT));
            dobj.stage.removeEventListener(MouseEvent.MOUSE_UP,fun_up);
            dobj.stage.removeEventListener(MouseEvent.MOUSE_MOVE,fun_move);
         };
         fun_move = function(param1:MouseEvent):void
         {
            dobj.dispatchEvent(new Event(MOUSE_DOWN_AND_DRAGING_EVENT));
         };
         dobj.stage.addEventListener(MouseEvent.MOUSE_UP,fun_up);
         dobj.stage.addEventListener(MouseEvent.MOUSE_MOVE,fun_move);
      }
      
      private function init() : void
      {
         StageManager.addChildToStageUpperDisplayList(this.cursorContainer);
         this.cursorContainer.mouseChildren = false;
         this.cursorContainer.mouseEnabled = false;
      }
      
      public function get cursor() : DisplayObject
      {
         return this._cursor;
      }
      
      private function setCursor() : void
      {
         this.cursorContainer.addChild(this.cursor);
         StageManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.__mouseMove);
         this.cursor.x = StageManager.stage.mouseX;
         this.cursor.y = StageManager.stage.mouseY;
      }
      
      private function unSetCursor() : void
      {
         if(this.cursor && this.cursor.parent)
         {
            this.cursorContainer.removeChild(this.cursor);
         }
         Mouse.show();
         StageManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.__mouseMove);
      }
      
      private function __mouseMove(param1:MouseEvent) : void
      {
         this.cursor.x = param1.stageX;
         this.cursor.y = param1.stageY;
         param1.updateAfterEvent();
      }
      
      public function set cursor(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            this.unSetCursor();
         }
         this._cursor = param1;
         if(this._cursor)
         {
            Mouse.hide();
            if(this._cursor is InteractiveObject)
            {
               InteractiveObject(this._cursor).mouseEnabled = false;
            }
            if(this._cursor is DisplayObjectContainer)
            {
               DisplayObjectContainer(this._cursor).mouseChildren = false;
            }
            this.setCursor();
         }
         else
         {
            Mouse.show();
         }
      }
   }
}
