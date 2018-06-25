package littleGame.view{   import com.pickgliss.ui.core.Disposeable;   import ddt.ddt_internal;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;   import littleGame.LittleGameManager;      use namespace ddt_internal;      public class MarkShape extends Bitmap implements Disposeable   {                   public function MarkShape(time:int) { super(null,null,null); }
            public function setTime(time:int) : void { }
            public function dispose() : void { }
   }}