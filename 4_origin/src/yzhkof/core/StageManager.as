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
      
      public static function init(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
      
      public static function addChildToStageUpperDisplayList(param1:DisplayObject) : void
      {
         stage.addChild(param1);
         weakMap.add(childCount++,param1);
         stage.addEventListener(Event.ADDED,__onStageAdd);
      }
      
      private static function __onStageAdd(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         for each(_loc2_ in weakMap.valueSet)
         {
            stage.setChildIndex(_loc2_,stage.numChildren - 1);
         }
      }
   }
}
