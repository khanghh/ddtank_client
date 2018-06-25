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
      
      protected function onClick(e:MouseEvent) : void
      {
         _clickedTimes = _clickedTimes + 1;
         if(_clickedTimes > 50)
         {
            this.parent && this.parent.removeChild(this);
         }
      }
      
      protected function onATS(e:Event) : void
      {
         _clickedTimes = 0;
         graphics.endFill();
         graphics.clear();
         graphics.beginFill(0);
         graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
      }
      
      protected function onRFS(e:Event) : void
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
      
      public function dig(guideCoverType:String, args:Array) : void
      {
         var _loc3_:* = guideCoverType;
         if("circle" !== _loc3_)
         {
            if("rect" !== _loc3_)
            {
               if("ellipse" === _loc3_)
               {
                  digEllipse(args[0],args[1],args[2],args[3]);
               }
            }
            else
            {
               digRect(args[0],args[1],args[2],args[3]);
            }
         }
         else
         {
            digCircle(args[0],args[1],args[2]);
         }
      }
      
      public function drawCover($color:uint, $alpha:Number) : void
      {
         graphics.endFill();
         graphics.clear();
         graphics.beginFill($color,$alpha);
         graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         graphics.endFill();
      }
      
      public function digCircle($x:Number, $y:Number, $radius:Number) : void
      {
         graphics.drawCircle($x,$y,$radius);
      }
      
      public function digRect($x:Number, $y:Number, $width:Number, $height:Number) : void
      {
         graphics.drawRect($x,$y,$width,$height);
      }
      
      public function digEllipse($x:Number, $y:Number, $width:Number, $height:Number) : void
      {
         graphics.drawEllipse($x,$y,$width,$height);
      }
   }
}
