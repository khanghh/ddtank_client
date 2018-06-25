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
            stage.addEventListener(Event.RESIZE,function(e:Event):void
            {
               width = stage.stageWidth;
            });
         });
      }
      
      public function checkGC() : void
      {
         var i:TextPanel = null;
         var text_arr:Array = this._dobj_map.keySet;
         for each(i in text_arr)
         {
            if(!this._dobj_map.getValue(i))
            {
               i.color = 65280;
            }
         }
      }
      
      public function setup(viewer:DebugDisplayObjectViewer) : void
      {
         this.viewer = viewer;
      }
      
      public function goto(dobj:*) : void
      {
         var t:TextPanel = null;
         var length:uint = 0;
         var i:int = 0;
         var tdobj:TextPanel = null;
         var text_arr:Array = new Array();
         this.reset();
         if(dobj is DisplayObject)
         {
            do
            {
               t = DebugSystem.getDebugTextButton(dobj,(!!/instance/.test(dobj.name)?getQualifiedClassName(dobj):dobj.name) || getQualifiedClassName(dobj));
               text_arr.push(t);
               text_arr.push(this.arrow);
               this._dobj_map.add(t,dobj);
            }
            while(dobj = dobj.parent);
            
            text_arr.pop();
            length = text_arr.length;
            for(i = 0; i < length; i++)
            {
               tdobj = TextPanel(text_arr.pop());
               appendItem(tdobj);
            }
         }
      }
      
      public function select(arr:Array) : void
      {
         var t:TextPanel = null;
         var j:DisplayObject = null;
         this.reset();
         for each(j in arr)
         {
            t = DebugSystem.getDebugTextButton(j,(!!/instance/.test(j.name)?getQualifiedClassName(j):j.name) || getQualifiedClassName(j));
            this._dobj_map.add(t,j);
            appendItem(t);
         }
      }
      
      private function reset() : void
      {
         this._dobj_map = new WeakMap();
         removeAllChildren();
      }
      
      private function get arrow() : TextPanel
      {
         var re_t:TextPanel = new TextPanel();
         re_t.text = ">>";
         return re_t;
      }
      
      public function get dobj_map() : WeakMap
      {
         return this._dobj_map;
      }
   }
}
