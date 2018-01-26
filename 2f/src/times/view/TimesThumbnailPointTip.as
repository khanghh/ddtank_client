package times.view
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class TimesThumbnailPointTip extends Sprite implements ITip
   {
       
      
      private var _bg:Bitmap;
      
      private var _bitmap:Bitmap;
      
      private var _text:FilterFrameText;
      
      private var _isRevertTip:Boolean;
      
      private var _offset:Point;
      
      private var _bitmapLoader:BitmapLoader;
      
      private var _bitmapDatas:Array;
      
      public function TimesThumbnailPointTip(){super();}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      private function __configPos(param1:Event = null) : void{}
      
      private function __removeBitmap(param1:Event) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
