package morn.core.ex
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import morn.core.components.Component;
   
   public class ScaleLeftRightImageEx extends Component
   {
       
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _cutRect:String = "1,100";
      
      private var _skin:String;
      
      public function ScaleLeftRightImageEx()
      {
         super();
      }
      
      public function set skin(value:String) : void
      {
         if(_skin != value)
         {
            _skin = value;
            if(value)
            {
               resetBitmaps();
               drawImage();
            }
         }
      }
      
      override protected function changeSize() : void
      {
         drawImage();
         super.changeSize();
      }
      
      private function resetBitmaps() : void
      {
         var links:* = null;
         var i:int = 0;
         clearImages();
         if(_skin && _skin != "")
         {
            _bitmaps = new Vector.<Bitmap>();
            links = _skin.split(",");
            if(links.length != 1)
            {
               i = 0;
               while(i < links.length)
               {
                  _bitmaps.push(new Bitmap(App.asset.getBitmapData(links[i])));
                  i++;
               }
            }
            addChild(_bitmaps[0]);
            addChild(_bitmaps[2]);
         }
      }
      
      private function drawImage() : void
      {
         var w:Number = _width || 100;
         graphics.clear();
         graphics.beginBitmapFill(_bitmaps[1].bitmapData);
         graphics.drawRect(_bitmaps[0].width,0,w - _bitmaps[0].width - _bitmaps[2].width,_bitmaps[0].height);
         graphics.endFill();
         _bitmaps[2].x = w - _bitmaps[2].width;
      }
      
      protected function clearImages() : void
      {
         if(_bitmaps && _bitmaps.length)
         {
            while(_bitmaps.length)
            {
               ObjectUtils.disposeObject(_bitmaps.pop());
            }
         }
         _bitmaps = null;
      }
      
      override public function dispose() : void
      {
         graphics.clear();
         clearImages();
         super.dispose();
      }
   }
}
