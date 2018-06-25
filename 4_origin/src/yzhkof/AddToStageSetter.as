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
      
      public static function delayExcuteAfterAddToStage(obj:DisplayObject, add_to_stage_function:Function, remove_after_excute:Boolean = true) : void
      {
         var new_function:Function = null;
         if(obj.stage == null)
         {
            new_function = function(e:Event):void
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
      
      public static function setObjToMiddleOfStage(obj:DisplayObject, offset_x:Number = 0, offset_y:Number = 0) : void
      {
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
