package starlingPhy.maps
{
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.RenderTexture;
   import starling.textures.Texture;
   
   public class Tile3D extends Sprite
   {
       
      
      private const BLOCK_WIDTH:int = 1024;
      
      private const BLOCK_HEIGHT:int = 1024;
      
      private var _digable:Boolean;
      
      private var _canvasList:Vector.<RenderTexture>;
      
      private var _blockList:Vector.<Image>;
      
      private var _thisBm:BitmapData;
      
      public function Tile3D(param1:BitmapData, param2:Boolean)
      {
         super();
         createCanvas(param1);
         _thisBm = param1;
         _digable = param2;
      }
      
      private function createCanvas(param1:BitmapData) : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = param1.width / 1024 + 1;
         var _loc5_:int = param1.height / 1024 + 1;
         _blockList = new Vector.<Image>();
         _canvasList = new Vector.<RenderTexture>();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc4_ = getBitmapDataBlock(_loc6_,_loc7_,_loc8_,_loc5_,param1);
               _loc3_ = new RenderTexture(_loc4_.width,_loc4_.height);
               _loc3_.draw(_loc4_);
               _canvasList.push(_loc3_);
               _loc2_ = new Image(_loc3_);
               _loc2_.x = _loc6_ * 1024;
               _loc2_.y = _loc8_ * 1024;
               addChild(_loc2_);
               _blockList.push(_loc2_);
               _loc4_.texture.dispose();
               _loc4_.dispose();
               _loc6_++;
            }
            _loc8_++;
         }
      }
      
      private function getBlockWidth(param1:int, param2:int, param3:int) : int
      {
         if(param1 < param2 - 1)
         {
            return 1024;
         }
         return param3 % 1024;
      }
      
      private function getBlockHeight(param1:int, param2:int, param3:int) : int
      {
         if(param1 < param2 - 1)
         {
            return 1024;
         }
         return param3 % 1024;
      }
      
      private function getBitmapDataBlock(param1:int, param2:int, param3:int, param4:int, param5:BitmapData) : Image
      {
         var _loc7_:BitmapData = new BitmapData(getBlockWidth(param1,param2,param5.width),getBlockHeight(param3,param4,param5.height));
         _loc7_.copyPixels(param5,new Rectangle(param1 * 1024,param3 * 1024,_loc7_.width,_loc7_.height),new Point());
         var _loc6_:Image = new Image(Texture.fromBitmapData(_loc7_,false));
         _loc7_.dispose();
         return _loc6_;
      }
      
      public function Dig(param1:Point, param2:Bitmap, param3:Bitmap = null) : void
      {
         var _loc4_:Matrix = new Matrix(1,0,0,1,param1.x,param1.y);
         if(param2 && _digable)
         {
            digImage(param1,param2,"erase");
            _loc4_.tx = _loc4_.tx - param2.width / 2;
            _loc4_.ty = _loc4_.ty - param2.height / 2;
            bitmapData.draw(param2,_loc4_,null,"erase");
         }
         if(param3 && _digable)
         {
            digImage(param1,param3,"alpha");
         }
      }
      
      private function digImage(param1:Point, param2:Bitmap, param3:String) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Image = Image.fromBitmap(param2,false);
         _loc4_.blendMode = param3;
         _loc6_ = 0;
         while(_loc6_ < _canvasList.length)
         {
            _loc5_ = new Matrix(1,0,0,1,param1.x - param2.width / 2 - _blockList[_loc6_].x,param1.y - param2.height / 2 - _blockList[_loc6_].y);
            _canvasList[_loc6_].draw(_loc4_,_loc5_);
            _loc6_++;
         }
         _loc4_.texture.dispose();
         _loc4_.dispose();
      }
      
      public function get bitmapData() : BitmapData
      {
         return _thisBm;
      }
      
      public function DigFillRect(param1:Rectangle) : void
      {
      }
      
      public function GetAlpha(param1:int, param2:int) : uint
      {
         return _thisBm.getPixel32(param1,param2) >> 24 & 255;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         while(_canvasList.length)
         {
            _loc1_ = _canvasList.pop();
            _loc1_.dispose();
         }
         _canvasList = null;
         while(_blockList.length)
         {
            _loc2_ = _blockList.pop();
            StarlingObjectUtils.disposeObject(_loc2_,true);
         }
         _blockList = null;
         ObjectUtils.disposeObject(_thisBm);
         _thisBm = null;
         super.dispose();
      }
   }
}
