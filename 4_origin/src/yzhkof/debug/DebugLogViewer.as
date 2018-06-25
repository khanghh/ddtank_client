package yzhkof.debug
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import yzhkof.ui.DragPanel;
   import yzhkof.ui.ScrollPanel;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.ui.event.ComponentEvent;
   import yzhkof.util.WeakMap;
   
   public class DebugLogViewer extends DragPanel
   {
       
      
      private var _logArr:Array;
      
      private var _logMap:Dictionary;
      
      private var _logWeakMap:WeakMap;
      
      private var log_max_count:uint = 2000;
      
      private var scrollPanel:ScrollPanel;
      
      private var tileContainer:TileContainer;
      
      private var btn_Container:TileContainer;
      
      private var clean_btn:TextPanel;
      
      private var start_btn:TextPanel;
      
      private var stop_btn:TextPanel;
      
      private var start_stop_container:Sprite;
      
      private var isStart:Boolean = true;
      
      private var _weak:Boolean = false;
      
      public function DebugLogViewer(weak:Boolean = false)
      {
         this._logArr = [];
         this._logMap = new Dictionary();
         this._logWeakMap = new WeakMap();
         this.scrollPanel = new ScrollPanel();
         this.tileContainer = new TileContainer();
         this.btn_Container = new TileContainer();
         this.clean_btn = new TextPanel(16776960);
         this.start_btn = new TextPanel(16776960);
         this.stop_btn = new TextPanel(16776960);
         this.start_stop_container = new Sprite();
         super();
         this._weak = weak;
         this.init();
         this.initEvent();
      }
      
      private function init() : void
      {
         _content.addChild(this.scrollPanel);
         _content.addChild(this.btn_Container);
         this.clean_btn.text = "清除";
         this.start_btn.text = "开始";
         this.stop_btn.text = "停止";
         this.start_stop_container.addChild(this.start_btn);
         this.start_stop_container.addChild(this.stop_btn);
         this.start_btn.visible = false;
         this.btn_Container.appendItem(this.clean_btn);
         this.btn_Container.appendItem(this.start_stop_container);
         this.scrollPanel.source = this.tileContainer;
         this.scrollPanel.y = 20;
         this.scrollPanel.width = 500;
         this.scrollPanel.height = 400;
         this.tileContainer.width = this.scrollPanel.width - 10;
         this.scrollPanel.addEventListener(ComponentEvent.DRAW_COMPLETE,this.__createComplete);
      }
      
      private function initEvent() : void
      {
         this.clean_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            cleanLog();
         });
         this.start_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            isStart = true;
            start_btn.visible = !start_btn.visible;
            stop_btn.visible = !stop_btn.visible;
         });
         this.stop_btn.addEventListener(MouseEvent.CLICK,function(e:Event):void
         {
            isStart = false;
            start_btn.visible = !start_btn.visible;
            stop_btn.visible = !stop_btn.visible;
         });
      }
      
      private function __createComplete(e:Event) : void
      {
         drawBackGround();
         removeEventListener(ComponentEvent.DRAW_COMPLETE,this.__createComplete);
      }
      
      public function addLog(obj:*, tag:String = "") : void
      {
         if(!this.isStart)
         {
            return;
         }
         this.addLoged(obj,tag);
      }
      
      function addLogDirectly(obj:*, tag:String = "") : void
      {
         this.addLoged(obj,tag);
      }
      
      private function addLoged(obj:*, tag:String = "") : void
      {
         var shift_btn:TextPanel = null;
         var text_button:TextPanel = DebugSystem.getDebugTextButton(obj,(tag == ""?"":tag + " : ") + getQualifiedClassName(obj));
         this.addItem(text_button,obj);
         this._logArr.push(text_button);
         this.tileContainer.appendItem(text_button);
         if(this._logArr.length >= this.log_max_count)
         {
            shift_btn = this._logArr.shift();
            this.removeItem(shift_btn);
            this.tileContainer.removeItem(shift_btn);
         }
      }
      
      public function cleanLog() : void
      {
         this.tileContainer.removeAllChildren();
         this._logArr = [];
         this._logMap = new Dictionary();
         this._logWeakMap = new WeakMap();
      }
      
      private function addItem(key:Object, value:Object) : void
      {
         if(this._weak)
         {
            this._logWeakMap.add(key,value);
         }
         else
         {
            this._logMap[key] = value;
         }
      }
      
      private function getItem(key:*) : *
      {
         if(this._weak)
         {
            return this._logWeakMap.getValue(key);
         }
         this._logMap[key];
      }
      
      public function checkGC() : void
      {
         var i:TextPanel = null;
         if(this._weak == false)
         {
            return;
         }
         var text_arr:Array = this._logWeakMap.keySet;
         for each(i in text_arr)
         {
            if(!this._logWeakMap.getValue(i))
            {
               i.color = 65280;
            }
         }
      }
      
      private function removeItem(key:*) : void
      {
         if(this._weak)
         {
            this._logWeakMap.remove(key);
         }
         else
         {
            delete this._logMap[key];
         }
      }
      
      function get logMap() : Dictionary
      {
         return this._logMap;
      }
      
      function get weakMap() : WeakMap
      {
         return this._logWeakMap;
      }
   }
}
