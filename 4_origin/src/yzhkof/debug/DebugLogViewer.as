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
      
      public function DebugLogViewer(param1:Boolean = false)
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
         this._weak = param1;
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
         this.clean_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            cleanLog();
         });
         this.start_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            isStart = true;
            start_btn.visible = !start_btn.visible;
            stop_btn.visible = !stop_btn.visible;
         });
         this.stop_btn.addEventListener(MouseEvent.CLICK,function(param1:Event):void
         {
            isStart = false;
            start_btn.visible = !start_btn.visible;
            stop_btn.visible = !stop_btn.visible;
         });
      }
      
      private function __createComplete(param1:Event) : void
      {
         drawBackGround();
         removeEventListener(ComponentEvent.DRAW_COMPLETE,this.__createComplete);
      }
      
      public function addLog(param1:*, param2:String = "") : void
      {
         if(!this.isStart)
         {
            return;
         }
         this.addLoged(param1,param2);
      }
      
      function addLogDirectly(param1:*, param2:String = "") : void
      {
         this.addLoged(param1,param2);
      }
      
      private function addLoged(param1:*, param2:String = "") : void
      {
         var _loc4_:TextPanel = null;
         var _loc3_:TextPanel = DebugSystem.getDebugTextButton(param1,(param2 == ""?"":param2 + " : ") + getQualifiedClassName(param1));
         this.addItem(_loc3_,param1);
         this._logArr.push(_loc3_);
         this.tileContainer.appendItem(_loc3_);
         if(this._logArr.length >= this.log_max_count)
         {
            _loc4_ = this._logArr.shift();
            this.removeItem(_loc4_);
            this.tileContainer.removeItem(_loc4_);
         }
      }
      
      public function cleanLog() : void
      {
         this.tileContainer.removeAllChildren();
         this._logArr = [];
         this._logMap = new Dictionary();
         this._logWeakMap = new WeakMap();
      }
      
      private function addItem(param1:Object, param2:Object) : void
      {
         if(this._weak)
         {
            this._logWeakMap.add(param1,param2);
         }
         else
         {
            this._logMap[param1] = param2;
         }
      }
      
      private function getItem(param1:*) : *
      {
         if(this._weak)
         {
            return this._logWeakMap.getValue(param1);
         }
         return;
         §§push(this._logMap[param1]);
      }
      
      public function checkGC() : void
      {
         var _loc2_:TextPanel = null;
         if(this._weak == false)
         {
            return;
         }
         var _loc1_:Array = this._logWeakMap.keySet;
         for each(_loc2_ in _loc1_)
         {
            if(!this._logWeakMap.getValue(_loc2_))
            {
               _loc2_.color = 65280;
            }
         }
      }
      
      private function removeItem(param1:*) : void
      {
         if(this._weak)
         {
            this._logWeakMap.remove(param1);
         }
         else
         {
            delete this._logMap[param1];
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
