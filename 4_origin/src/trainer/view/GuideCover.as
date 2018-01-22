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
      
      public function GuideCover()
      {
         super();
         this.alpha = 0.4;
         this.addEventListener("addedToStage",onATS);
         this.addEventListener("removedFromStage",onRFS);
         this.addEventListener("click",onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         _clickedTimes = _clickedTimes + 1;
         if(_clickedTimes > 50)
         {
            this.parent && this.parent.removeChild(this);
         }
      }
      
      protected function onATS(param1:Event) : void
      {
         _clickedTimes = 0;
         graphics.endFill();
         graphics.clear();
         graphics.beginFill(0);
         graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
      }
      
      protected function onRFS(param1:Event) : void
      {
         _clickedTimes = 0;
         graphics.endFill();
         graphics.clear();
      }
      
      public function dispose() : void
      {
         _clickedTimes = 0;
         graphics.endFill();
         graphics.clear();
         this.removeEventListener("addedToStage",onATS);
         this.removeEventListener("removedFromStage",onRFS);
         this.removeEventListener("click",onClick);
      }
      
      public function dig(param1:String, param2:Array) : void
      {
         var _loc3_:* = param1;
         if("circle" !== _loc3_)
         {
            if("rect" !== _loc3_)
            {
               if("ellipse" === _loc3_)
               {
                  digEllipse(param2[0],param2[1],param2[2],param2[3]);
               }
            }
            else
            {
               digRect(param2[0],param2[1],param2[2],param2[3]);
            }
         }
         else
         {
            digCircle(param2[0],param2[1],param2[2]);
         }
      }
      
      public function drawCover(param1:uint, param2:Number) : void
      {
         graphics.endFill();
         graphics.clear();
         graphics.beginFill(param1,param2);
         graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         graphics.endFill();
      }
      
      public function digCircle(param1:Number, param2:Number, param3:Number) : void
      {
         graphics.drawCircle(param1,param2,param3);
      }
      
      public function digRect(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         graphics.drawRect(param1,param2,param3,param4);
      }
      
      public function digEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         graphics.drawEllipse(param1,param2,param3,param4);
      }
   }
}
