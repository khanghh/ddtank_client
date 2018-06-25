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
      
      public function TimesThumbnailPointTip()
      {
         super();
         addEventListener("addedToStage",__configPos);
         addEventListener("removedFromStage",__removeBitmap);
         _offset = ComponentFactory.Instance.creatCustomObject("times.PagePointTipOffset");
         _bg = ComponentFactory.Instance.creatBitmap("asset.times.ThumbnailZoomBg");
      }
      
      public function get tipData() : Object
      {
         if(_bitmap)
         {
            return _bitmap.bitmapData;
         }
         return null;
      }
      
      public function set tipData(data:Object) : void
      {
         if(!data)
         {
            return;
         }
         _bitmapDatas = data.bitmapDatas;
         if(_bitmapDatas && _bitmapDatas[data.category] && _bitmapDatas[data.category][data.page])
         {
            this.visible = true;
            _bitmap = new Bitmap(_bitmapDatas[data.category][data.page].bitmapData);
            _isRevertTip = data.isRevertTip;
            _bitmap.x = 11;
            _bitmap.y = 8;
            if(_bg)
            {
               addChild(_bg);
            }
            return;
         }
         this.visible = false;
      }
      
      private function __configPos(event:Event = null) : void
      {
         _bg.x = 0;
         if(_isRevertTip)
         {
            _bg.scaleX = -1;
            _bg.x = _bg.x + (_bg.width - 3);
            x = x - (_offset.x - 2);
         }
         else
         {
            _bg.scaleX = 1;
            x = x + _offset.y;
         }
         if(_bitmap)
         {
            _bitmap.x = 8;
            _bitmap.y = 8;
         }
         if(_bitmap)
         {
            addChild(_bitmap);
         }
      }
      
      private function __removeBitmap(event:Event) : void
      {
         if(_bitmap && _bitmap.parent)
         {
            _bitmap.parent.removeChild(_bitmap);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
