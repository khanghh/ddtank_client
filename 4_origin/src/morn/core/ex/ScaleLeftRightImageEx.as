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
      
      public function set skin(param1:String) : void
      {
         if(this._skin != param1)
         {
            this._skin = param1;
            if(Boolean(param1))
            {
               this.resetBitmaps();
               this.drawImage();
            }
         }
      }
      
      override protected function changeSize() : void
      {
         this.drawImage();
         super.changeSize();
      }
      
      private function resetBitmaps() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         this.clearImages();
         if(this._skin && this._skin != "")
         {
            this._bitmaps = new Vector.<Bitmap>();
            _loc1_ = this._skin.split(",");
            if(_loc1_.length != 1)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc1_.length)
               {
                  this._bitmaps.push(new Bitmap(App.asset.getBitmapData(_loc1_[_loc2_])));
                  _loc2_++;
               }
            }
            addChild(this._bitmaps[0]);
            addChild(this._bitmaps[2]);
         }
      }
      
      private function drawImage() : void
      {
         var _loc1_:Number = Number(_width) || 100;
         graphics.clear();
         graphics.beginBitmapFill(this._bitmaps[1].bitmapData);
         graphics.drawRect(this._bitmaps[0].width,0,_loc1_ - this._bitmaps[0].width - this._bitmaps[2].width,this._bitmaps[0].height);
         graphics.endFill();
         this._bitmaps[2].x = _loc1_ - this._bitmaps[2].width;
      }
      
      protected function clearImages() : void
      {
         if(this._bitmaps && this._bitmaps.length)
         {
            while(this._bitmaps.length)
            {
               ObjectUtils.disposeObject(this._bitmaps.pop());
            }
         }
         this._bitmaps = null;
      }
      
      override public function dispose() : void
      {
         graphics.clear();
         this.clearImages();
         super.dispose();
      }
   }
}
