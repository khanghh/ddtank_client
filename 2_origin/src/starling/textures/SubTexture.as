package starling.textures
{
   import flash.display3D.textures.TextureBase;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.utils.MatrixUtil;
   import starling.utils.RectangleUtil;
   import starling.utils.VertexData;
   
   public class SubTexture extends Texture
   {
      
      private static var sTexCoords:Point = new Point();
      
      private static var sMatrix:Matrix = new Matrix();
       
      
      private var mParent:Texture;
      
      private var mOwnsParent:Boolean;
      
      private var mRegion:Rectangle;
      
      private var mFrame:Rectangle;
      
      private var mRotated:Boolean;
      
      private var mWidth:Number;
      
      private var mHeight:Number;
      
      private var mTransformationMatrix:Matrix;
      
      public function SubTexture(parent:Texture, region:Rectangle = null, ownsParent:Boolean = false, frame:Rectangle = null, rotated:Boolean = false)
      {
         super();
         mParent = parent;
         mRegion = !!region?region.clone():new Rectangle(0,0,parent.width,parent.height);
         mFrame = !!frame?frame.clone():null;
         mOwnsParent = ownsParent;
         mRotated = rotated;
         mWidth = !!rotated?mRegion.height:Number(mRegion.width);
         mHeight = !!rotated?mRegion.width:Number(mRegion.height);
         mTransformationMatrix = new Matrix();
         if(rotated)
         {
            mTransformationMatrix.translate(0,-1);
            mTransformationMatrix.rotate(3.14159265358979 / 2);
         }
         if(mFrame && (mFrame.x > 0 || mFrame.y > 0 || mFrame.right < mWidth || mFrame.bottom < mHeight))
         {
            trace("[Starling] Warning: frames inside the texture\'s region are unsupported.");
         }
         mTransformationMatrix.scale(mRegion.width / mParent.width,mRegion.height / mParent.height);
         mTransformationMatrix.translate(mRegion.x / mParent.width,mRegion.y / mParent.height);
      }
      
      override public function dispose() : void
      {
         if(mOwnsParent)
         {
            mParent.dispose();
         }
         super.dispose();
      }
      
      override public function adjustVertexData(vertexData:VertexData, vertexID:int, count:int) : void
      {
         var deltaRight:Number = NaN;
         var deltaBottom:Number = NaN;
         var startIndex:int = vertexID * 8 + 6;
         var stride:int = 6;
         adjustTexCoords(vertexData.rawData,startIndex,stride,count);
         if(mFrame)
         {
            if(count != 4)
            {
               throw new ArgumentError("Textures with a frame can only be used on quads");
            }
            deltaRight = mFrame.width + mFrame.x - mWidth;
            deltaBottom = mFrame.height + mFrame.y - mHeight;
            vertexData.translateVertex(vertexID,-mFrame.x,-mFrame.y);
            vertexData.translateVertex(vertexID + 1,-deltaRight,-mFrame.y);
            vertexData.translateVertex(vertexID + 2,-mFrame.x,-deltaBottom);
            vertexData.translateVertex(vertexID + 3,-deltaRight,-deltaBottom);
         }
      }
      
      override public function adjustTexCoords(texCoords:Vector.<Number>, startIndex:int = 0, stride:int = 0, count:int = -1) : void
      {
         var v:Number = NaN;
         var u:Number = NaN;
         var i:* = 0;
         if(count < 0)
         {
            count = (texCoords.length - startIndex - 2) / (stride + 2) + 1;
         }
         var endIndex:int = startIndex + count * (2 + stride);
         var texture:* = this;
         sMatrix.identity();
         while(texture)
         {
            sMatrix.concat(texture.mTransformationMatrix);
            texture = texture.parent as SubTexture;
         }
         for(i = startIndex; i < endIndex; )
         {
            u = texCoords[i];
            v = texCoords[int(i + 1)];
            MatrixUtil.transformCoords(sMatrix,u,v,sTexCoords);
            texCoords[i] = sTexCoords.x;
            texCoords[int(i + 1)] = sTexCoords.y;
            i = int(i + (2 + stride));
         }
      }
      
      public function get parent() : Texture
      {
         return mParent;
      }
      
      public function get ownsParent() : Boolean
      {
         return mOwnsParent;
      }
      
      public function get rotated() : Boolean
      {
         return mRotated;
      }
      
      public function get region() : Rectangle
      {
         return mRegion;
      }
      
      public function get clipping() : Rectangle
      {
         var topLeft:Point = new Point();
         var bottomRight:Point = new Point();
         MatrixUtil.transformCoords(mTransformationMatrix,0,0,topLeft);
         MatrixUtil.transformCoords(mTransformationMatrix,1,1,bottomRight);
         var clipping:Rectangle = new Rectangle(topLeft.x,topLeft.y,bottomRight.x - topLeft.x,bottomRight.y - topLeft.y);
         RectangleUtil.normalize(clipping);
         return clipping;
      }
      
      public function get transformationMatrix() : Matrix
      {
         return mTransformationMatrix;
      }
      
      override public function get base() : TextureBase
      {
         return mParent.base;
      }
      
      override public function get root() : ConcreteTexture
      {
         return mParent.root;
      }
      
      override public function get format() : String
      {
         return mParent.format;
      }
      
      override public function get width() : Number
      {
         return mWidth;
      }
      
      override public function get height() : Number
      {
         return mHeight;
      }
      
      override public function get nativeWidth() : Number
      {
         return mWidth * scale;
      }
      
      override public function get nativeHeight() : Number
      {
         return mHeight * scale;
      }
      
      override public function get mipMapping() : Boolean
      {
         return mParent.mipMapping;
      }
      
      override public function get premultipliedAlpha() : Boolean
      {
         return mParent.premultipliedAlpha;
      }
      
      override public function get scale() : Number
      {
         return mParent.scale;
      }
      
      override public function get repeat() : Boolean
      {
         return mParent.repeat;
      }
      
      override public function get frame() : Rectangle
      {
         return mFrame;
      }
   }
}
