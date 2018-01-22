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
      
      private function __clearClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         for each(_loc2_ in this.textField_arr)
         {
            this.tileContainer.removeItem(_loc2_);
         }
         this.watch_arr = [];
         this.textField_arr = [];
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:WatchData = null;
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         for(_loc2_ in this.watch_arr)
         {
            _loc3_ = WatchData(this.watch_arr[_loc2_]);
            _loc4_ = _loc3_.property.split(".");
            _loc5_ = _loc3_.object;
            for each(_loc7_ in _loc4_)
            {
               if(_loc5_ == null)
               {
                  _loc6_ = null;
                  break;
               }
               _loc6_ = !!_loc5_.hasOwnProperty(_loc7_)?_loc5_[_loc7_]:"在 " + name + " 上找不到属性 " + _loc7_;
               _loc5_ = _loc6_;
            }
            this.textField_arr[_loc2_].text = (_loc3_.name || getQualifiedClassName(_loc3_.object)) + ":" + _loc6_;
         }
         if(visible)
         {
            this.tileContainer.draw();
         }
      }
      
      private function __createComplete(param1:Event) : void
      {
         drawBackGround();
         removeEventListener(ComponentEvent.DRAW_COMPLETE,this.__createComplete);
      }
      
      public function addWatch(param1:Object, param2:String, param3:String = null) : void
      {
         var _loc4_:WatchData = new WatchData();
         _loc4_.object = param1;
         _loc4_.property = param2;
         _loc4_.name = param3 || param2;
         this.watch_arr.push(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         this.textField_arr.push(_loc5_);
         this.tileContainer.appendItem(_loc5_);
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
