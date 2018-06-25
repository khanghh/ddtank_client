package gameCommon.view.playerThumbnail
{
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ThumbnailTip extends Sprite
   {
       
      
      public function ThumbnailTip()
      {
         super();
      }
      
      public function show() : void
      {
         var pos:* = null;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         if(stage && parent)
         {
            pos = parent.globalToLocal(new Point(stage.mouseX,stage.mouseY));
            this.x = pos.x + 15;
            this.y = pos.y + 15;
            if(x + 182 > 1000)
            {
               this.x = x - 182;
            }
            if(y + 234 > 600)
            {
               y = 366;
            }
         }
      }
   }
}
