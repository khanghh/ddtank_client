package yzhkof.debug
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   import yzhkof.AddToStageSetter;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.util.WeakMap;
   
   public class DebugDisplayObjectDctionary extends TileContainer
   {
       
      
      var _dobj_map:WeakMap;
      
      private var viewer:DebugDisplayObjectViewer;
      
      public function DebugDisplayObjectDctionary()
      {
         super();
         AddToStageSetter.delayExcuteAfterAddToStage(this,function():void
         {
            width = stage.stageWidth;
            stage.addEventListener(Event.RESIZE,function(param1:Event):void
            {
               width = stage.stageWidth;
            });
         });
      }
      
      public function checkGC() : void
      {
         var _loc2_:TextPanel = null;
         var _loc1_:Array = this._dobj_map.keySet;
         for each(_loc2_ in _loc1_)
         {
            if(!this._dobj_map.getValue(_loc2_))
            {
               _loc2_.color = 65280;
            }
         }
      }
      
      public function setup(param1:DebugDisplayObjectViewer) : void
      {
         this.viewer = param1;
      }
      
      public function goto(param1:*) : void
      {
         var _loc3_:TextPanel = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:TextPanel = null;
         var _loc2_:Array = new Array();
         this.reset();
         if(param1 is DisplayObject)
         {
            do
            {
               _loc3_ = DebugSystem.getDebugTextButton(param1,(!!/instance/.test(param1.name)?getQualifiedClassName(param1):param1.name) || getQualifiedClassName(param1));
               _loc2_.push(_loc3_);
               _loc2_.push(this.arrow);
               this._dobj_map.add(_loc3_,param1);
            }
            while(param1 = param1.parent);
            
            _loc2_.pop();
            _loc4_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = TextPanel(_loc2_.pop());
               appendItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function select(param1:Array) : void
      {
         var _loc2_:TextPanel = null;
         var _loc3_:DisplayObject = null;
         this.reset();
         for each(_loc3_ in param1)
         {
            _loc2_ = DebugSystem.getDebugTextButton(_loc3_,(!!/instance/.test(_loc3_.name)?getQualifiedClassName(_loc3_):_loc3_.name) || getQualifiedClassName(_loc3_));
            this._dobj_map.add(_loc2_,_loc3_);
            appendItem(_loc2_);
         }
      }
      
      private function reset() : void
      {
         this._dobj_map = new WeakMap();
         removeAllChildren();
      }
      
      private function get arrow() : TextPanel
      {
         var _loc1_:TextPanel = new TextPanel();
         _loc1_.text = ">>";
         return _loc1_;
      }
      
      public function get dobj_map() : WeakMap
      {
         return this._dobj_map;
      }
   }
}
