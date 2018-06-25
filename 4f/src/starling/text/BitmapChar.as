package starling.text{   import flash.utils.Dictionary;   import starling.display.Image;   import starling.textures.Texture;      public class BitmapChar   {                   private var mTexture:Texture;            private var mCharID:int;            private var mXOffset:Number;            private var mYOffset:Number;            private var mXAdvance:Number;            private var mKernings:Dictionary;            public function BitmapChar(id:int, texture:Texture, xOffset:Number, yOffset:Number, xAdvance:Number) { super(); }
            public function addKerning(charID:int, amount:Number) : void { }
            public function getKerning(charID:int) : Number { return 0; }
            public function createImage() : Image { return null; }
            public function get charID() : int { return 0; }
            public function get xOffset() : Number { return 0; }
            public function get yOffset() : Number { return 0; }
            public function get xAdvance() : Number { return 0; }
            public function get texture() : Texture { return null; }
            public function get width() : Number { return 0; }
            public function get height() : Number { return 0; }
   }}