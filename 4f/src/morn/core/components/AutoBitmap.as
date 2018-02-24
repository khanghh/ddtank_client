package morn.core.components
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import morn.core.utils.BitmapUtils;
   
   public final class AutoBitmap extends Bitmap
   {
       
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _sizeGrid:Array;
      
      private var _source:Vector.<BitmapData>;
      
      private var _clips:Vector.<BitmapData>;
      
      private var _index:int;
      
      private var _smoothing:Boolean;
      
      private var _anchorX:Number;
      
      private var _anchorY:Number;
      
      public function AutoBitmap(){super();}
      
      override public function get width() : Number{return 0;}
      
      override public function set width(param1:Number) : void{}
      
      override public function get height() : Number{return 0;}
      
      override public function set height(param1:Number) : void{}
      
      public function get sizeGrid() : Array{return null;}
      
      public function set sizeGrid(param1:Array) : void{}
      
      override public function set bitmapData(param1:BitmapData) : void{}
      
      public function get clips() : Vector.<BitmapData>{return null;}
      
      public function set clips(param1:Vector.<BitmapData>) : void{}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      private function changeSize() : void{}
      
      private function disposeTempBitmapdata() : void{}
      
      override public function get smoothing() : Boolean{return false;}
      
      override public function set smoothing(param1:Boolean) : void{}
      
      public function get anchorX() : Number{return 0;}
      
      public function set anchorX(param1:Number) : void{}
      
      public function get anchorY() : Number{return 0;}
      
      public function set anchorY(param1:Number) : void{}
      
      public function callLater(param1:Function, param2:Array = null) : void{}
      
      public function dispose() : void{}
   }
}
