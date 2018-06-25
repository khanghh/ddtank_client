package yzhkof.debug
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getQualifiedClassName;
   import yzhkof.ui.DragPanel;
   import yzhkof.ui.ScrollPanel;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.ui.event.ComponentEvent;
   
   public class DebugWatcherViewer extends DragPanel
   {
       
      
      private var watch_arr:Array;
      
      private var textField_arr:Array;
      
      private var scrollPanel:ScrollPanel;
      
      private var tileContainer:TileContainer;
      
      private var btn_Container:TileContainer;
      
      private var clear_btn:TextPanel;
      
      public function DebugWatcherViewer()
      {
         this.watch_arr = [];
         this.textField_arr = [];
         this.scrollPanel = new ScrollPanel();
         this.tileContainer = new TileContainer();
         this.btn_Container = new TileContainer();
         this.clear_btn = new TextPanel(16776960);
         super();
         this.initView();
         this.init();
         this.addEvent();
      }
      
      private function init() : void
      {
      }
      
      private function initView() : void
      {
         content.addChild(this.scrollPanel);
         this.scrollPanel.source = this.tileContainer;
         this.scrollPanel.y = 20;
         this.scrollPanel.width = 500;
         this.scrollPanel.height = 400;
         this.tileContainer.width = this.scrollPanel.width - 10;
         this.tileContainer.columnCount = 1;
         this.clear_btn.text = "清除";
         this.btn_Container.appendItem(this.clear_btn);
         content.addChild(this.btn_Container);
      }
      
      private function addEvent() : void
      {
         this.scrollPanel.addEventListener(ComponentEvent.DRAW_COMPLETE,this.__createComplete);
         addEventListener(Event.ENTER_FRAME,this.__enterFrame);
         this.clear_btn.addEventListener(MouseEvent.CLICK,this.__clearClick);
      }
      
      private function __clearClick(event:MouseEvent) : void
      {
         var element:DisplayObject = null;
         for each(element in this.textField_arr)
         {
            this.tileContainer.removeItem(element);
         }
         this.watch_arr = [];
         this.textField_arr = [];
      }
      
      private function __enterFrame(event:Event) : void
      {
         var i:* = null;
         var data:WatchData = null;
         var params:Array = null;
         var current_object:* = undefined;
         var current_value:* = undefined;
         var element:String = null;
         for(i in this.watch_arr)
         {
            data = WatchData(this.watch_arr[i]);
            params = data.property.split(".");
            current_object = data.object;
            for each(element in params)
            {
               if(current_object == null)
               {
                  current_value = null;
                  break;
               }
               current_value = !!current_object.hasOwnProperty(element)?current_object[element]:"在 " + name + " 上找不到属性 " + element;
               current_object = current_value;
            }
            this.textField_arr[i].text = (data.name || getQualifiedClassName(data.object)) + ":" + current_value;
         }
         if(visible)
         {
            this.tileContainer.draw();
         }
      }
      
      private function __createComplete(e:Event) : void
      {
         drawBackGround();
         removeEventListener(ComponentEvent.DRAW_COMPLETE,this.__createComplete);
      }
      
      public function addWatch(obj:Object, property:String, name:String = null) : void
      {
         var data:WatchData = new WatchData();
         data.object = obj;
         data.property = property;
         data.name = name || property;
         this.watch_arr.push(data);
         var text:TextField = new TextField();
         text.autoSize = TextFieldAutoSize.LEFT;
         this.textField_arr.push(text);
         this.tileContainer.appendItem(text);
      }
   }
}

class WatchData
{
    
   
   public var object:Object;
   
   public var property:String;
   
   public var name:String;
   
   function WatchData()
   {
      super();
   }
}
