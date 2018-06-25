package starling.events
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Point;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   class TouchMarker extends Sprite
   {
       
      
      private var mCenter:Point;
      
      private var mTexture:Texture;
      
      function TouchMarker()
      {
         var i:int = 0;
         var marker:* = null;
         super();
         mCenter = new Point();
         mTexture = createTexture();
         for(i = 0; i < 2; )
         {
            marker = new Image(mTexture);
            marker.pivotX = mTexture.width / 2;
            marker.pivotY = mTexture.height / 2;
            marker.touchable = false;
            addChild(marker);
            i++;
         }
      }
      
      override public function dispose() : void
      {
         mTexture.dispose();
         super.dispose();
      }
      
      public function moveMarker(x:Number, y:Number, withCenter:Boolean = false) : void
      {
         if(withCenter)
         {
            mCenter.x = mCenter.x + (x - realMarker.x);
            mCenter.y = mCenter.y + (y - realMarker.y);
         }
         realMarker.x = x;
         realMarker.y = y;
         mockMarker.x = 2 * mCenter.x - x;
         mockMarker.y = 2 * mCenter.y - y;
      }
      
      public function moveCenter(x:Number, y:Number) : void
      {
         mCenter.x = x;
         mCenter.y = y;
         moveMarker(realX,realY);
      }
      
      private function createTexture() : Texture
      {
         var scale:Number = Starling.contentScaleFactor;
         var radius:Number = 12 * scale;
         var width:int = 32 * scale;
         var height:int = 32 * scale;
         var thickness:Number = 1.5 * scale;
         var shape:Shape = new Shape();
         shape.graphics.lineStyle(thickness,0,0.3);
         shape.graphics.drawCircle(width / 2,height / 2,radius + thickness);
         shape.graphics.beginFill(16777215,0.4);
         shape.graphics.lineStyle(thickness,16777215);
         shape.graphics.drawCircle(width / 2,height / 2,radius);
         shape.graphics.endFill();
         var bmpData:BitmapData = new BitmapData(width,height,true,0);
         bmpData.draw(shape);
         return Texture.fromBitmapData(bmpData,false,false,scale);
      }
      
      private function get realMarker() : Image
      {
         return getChildAt(0) as Image;
      }
      
      private function get mockMarker() : Image
      {
         return getChildAt(1) as Image;
      }
      
      public function get realX() : Number
      {
         return realMarker.x;
      }
      
      public function get realY() : Number
      {
         return realMarker.y;
      }
      
      public function get mockX() : Number
      {
         return mockMarker.x;
      }
      
      public function get mockY() : Number
      {
         return mockMarker.y;
      }
   }
}
