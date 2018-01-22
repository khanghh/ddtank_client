package yzhkof
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class AddToStageSetter
   {
       
      
      public function AddToStageSetter()
      {
         super();
         throw new Error("无法被实例化!");
      }
      
      public static function delayExcuteAfterAddToStage(param1:DisplayObject, param2:Function, param3:Boolean = true) : void
      {
         var new_function:Function = null;
         var obj:DisplayObject = param1;
         var add_to_stage_function:Function = param2;
         var remove_after_excute:Boolean = param3;
         if(obj.stage == null)
         {
            new_function = function(param1:Event):void
            {
               add_to_stage_function();
               obj.removeEventListener(Event.ADDED_TO_STAGE,new_function);
            };
            if(remove_after_excute)
            {
               obj.addEventListener(Event.ADDED_TO_STAGE,new_function);
            }
         }
         else
         {
            add_to_stage_function();
         }
      }
      
      public static function setObjToMiddleOfStage(param1:DisplayObject, param2:Number = 0, param3:Number = 0) : void
      {
         var obj:DisplayObject = param1;
         var offset_x:Number = param2;
         var offset_y:Number = param3;
         var fun:Function = function():void
         {
            obj.x = (obj.stage.stageWidth - obj.width) / 2 + offset_x;
            obj.y = (obj.stage.stageHeight - obj.height) / 2 + offset_y;
         };
         if(obj.stage != null)
         {
            fun();
         }
         else
         {
            delayExcuteAfterAddToStage(obj,fun);
         }
      }
   }
}
