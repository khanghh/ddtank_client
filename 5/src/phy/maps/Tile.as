package phy.maps
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class Tile extends Bitmap
    {


        private var _digable:Boolean;

        public function Tile(bitmapData:BitmapData, digable:Boolean) { super(null); }

        public function Dig(center:Point, surface:Bitmap, border:Bitmap = null) : void { }

        public function DigFillRect(rect:Rectangle) : void { }

        public function GetAlpha(x:int, y:int) : uint { return null; }

        public function dispose() : void { }

        public function get digable() : Boolean
        {
            return _digable;
        }
    }
}
