package trainer.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GuideCover extends Sprite implements Disposeable
   {
       
      
      private var _clickedTimes:int = 0;
      
      public function GuideCover(){super();}
      
      protected function onClick(param1:MouseEvent) : void{}
      
      protected function onATS(param1:Event) : void{}
      
      protected function onRFS(param1:Event) : void{}
      
      public function dispose() : void{}
      
      public function dig(param1:String, param2:Array) : void{}
      
      public function drawCover(param1:uint, param2:Number) : void{}
      
      public function digCircle(param1:Number, param2:Number, param3:Number) : void{}
      
      public function digRect(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
      
      public function digEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
   }
}
