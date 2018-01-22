package yzhkof.debug
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import yzhkof.ToolBitmapData;
   
   public class SnapshotDisplayViewer extends Sprite
   {
       
      
      private var bitmap:Bitmap;
      
      private var bitmapdata:BitmapData;
      
      private var source:DisplayObject;
      
      public function SnapshotDisplayViewer()
      {
         super();
         this.bitmap = new Bitmap();
         addChild(this.bitmap);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function clearView() : void
      {
         visible = false;
         this.source = null;
      }
      
      public function view(param1:DisplayObject) : void
      {
         this.source = param1;
         if(this.bitmapdata)
         {
            this.bitmapdata.dispose();
            this.bitmapdata = null;
         }
         this.bitmap.smoothing = true;
         this.onEnterFrame(null);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.source && visible)
         {
            if(this.bitmapdata != null)
            {
               this.bitmapdata.dispose();
            }
            this.bitmapdata = ToolBitmapData.getInstance().drawDisplayObject(this.source);
            if(this.bitmapdata != null)
            {
               this.bitmap.bitmapData = this.bitmapdata;
            }
         }
      }
   }
}
