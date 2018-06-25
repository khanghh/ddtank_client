package starling.events{   import flash.display.BitmapData;   import flash.display.Shape;   import flash.geom.Point;   import starling.core.Starling;   import starling.display.Image;   import starling.display.Sprite;   import starling.textures.Texture;      class TouchMarker extends Sprite   {                   private var mCenter:Point;            private var mTexture:Texture;            function TouchMarker() { super(); }
            override public function dispose() : void { }
            public function moveMarker(x:Number, y:Number, withCenter:Boolean = false) : void { }
            public function moveCenter(x:Number, y:Number) : void { }
            private function createTexture() : Texture { return null; }
            private function get realMarker() : Image { return null; }
            private function get mockMarker() : Image { return null; }
            public function get realX() : Number { return 0; }
            public function get realY() : Number { return 0; }
            public function get mockX() : Number { return 0; }
            public function get mockY() : Number { return 0; }
   }}