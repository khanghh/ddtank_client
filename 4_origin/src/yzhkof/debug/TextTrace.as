package yzhkof.debug
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import yzhkof.MyGraphy;
   import yzhkof.ui.TextPanel;
   
   public class TextTrace extends Sprite
   {
      
      private static const text_info:TextField = new TextField();
      
      private static const container:Sprite = new Sprite();
      
      private static const drag_btn:Sprite = MyGraphy.drawRectangle(20,20);
      
      private static const clean_btn:TextPanel = new TextPanel(16776960);
      
      private static const scaleX_btn:Sprite = MyGraphy.drawRectangle(20,20);
      
      private static const text_width:Number = 500;
      
      private static const text_height:Number = 300;
      
      private static const back:Sprite = MyGraphy.drawRectangle(text_width + 21,text_height + 21,true,16777215);
       
      
      public function TextTrace()
      {
         super();
      }
      
      public static function get view() : Sprite
      {
         return container;
      }
      
      public static function init(dobj:DisplayObjectContainer) : DisplayObjectContainer
      {
         back.filters = [new DropShadowFilter(0,0,0)];
         drag_btn.buttonMode = true;
         scaleX_btn.buttonMode = true;
         clean_btn.text = "清除";
         clean_btn.x = 30;
         scaleX_btn.x = text_width;
         scaleX_btn.y = text_height;
         text_info.width = text_width;
         text_info.height = text_height;
         text_info.x = 21;
         text_info.y = 21;
         container.addChild(back);
         container.addChild(text_info);
         container.addChild(scaleX_btn);
         container.addChild(drag_btn);
         container.addChild(clean_btn);
         dobj.addChild(container);
         drag_btn.addEventListener(MouseEvent.MOUSE_DOWN,containerMouseDownHandler);
         drag_btn.addEventListener(MouseEvent.MOUSE_UP,containerMouseUpHandler);
         scaleX_btn.addEventListener(MouseEvent.MOUSE_DOWN,scaleXMouseDownHandler);
         scaleX_btn.addEventListener(MouseEvent.MOUSE_UP,scaleXMouseUpHandler);
         clean_btn.addEventListener(MouseEvent.CLICK,__onCleanClick);
         scaleXonEnterFrame(null);
         return dobj;
      }
      
      public static function get visible() : Boolean
      {
         return container.visible;
      }
      
      public static function set visible(value:Boolean) : void
      {
         container.visible = value;
      }
      
      public static function textPlus(str:String) : void
      {
         text_info.appendText(str);
         text_info.scrollV = text_info.maxScrollV;
      }
      
      public static function textClean() : void
      {
         text_info.text = "";
      }
      
      private static function __onCleanClick(e:Event) : void
      {
         textClean();
      }
      
      private static function scaleXMouseDownHandler(e:Event) : void
      {
         scaleX_btn.startDrag();
         scaleXonEnterFrame(null);
         scaleX_btn.addEventListener(Event.ENTER_FRAME,scaleXonEnterFrame);
      }
      
      private static function scaleXMouseUpHandler(e:Event) : void
      {
         scaleX_btn.removeEventListener(Event.ENTER_FRAME,scaleXonEnterFrame);
         scaleXonEnterFrame(null);
         scaleX_btn.stopDrag();
      }
      
      private static function scaleXonEnterFrame(e:Event) : void
      {
         text_info.width = scaleX_btn.x;
         back.width = scaleX_btn.x + 20;
         text_info.height = scaleX_btn.y;
         back.height = scaleX_btn.y + 20;
      }
      
      private static function containerMouseDownHandler(e:Event) : void
      {
         container.startDrag();
      }
      
      private static function containerMouseUpHandler(e:Event) : void
      {
         container.stopDrag();
      }
   }
}
