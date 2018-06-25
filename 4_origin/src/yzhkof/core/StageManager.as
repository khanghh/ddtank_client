package yzhkof.core
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import yzhkof.util.WeakMap;
   
   public class StageManager
   {
      
      private static var _stage:Stage;
      
      private static const weakMap:WeakMap = new WeakMap();
      
      private static var childCount:uint = 0;
       
      
      public function StageManager()
      {
         super();
      }
      
      public static function init(stage:Stage) : void
      {
         _stage = stage;
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
      
      public static function addChildToStageUpperDisplayList(child:DisplayObject) : void
      {
         stage.addChild(child);
         weakMap.add(childCount++,child);
         stage.addEventListener(Event.ADDED,__onStageAdd);
      }
      
      private static function __onStageAdd(e:Event) : void
      {
         var i:DisplayObject = null;
         for each(i in weakMap.valueSet)
         {
            stage.setChildIndex(i,stage.numChildren - 1);
         }
      }
   }
}
