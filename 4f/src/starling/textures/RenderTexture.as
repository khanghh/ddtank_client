package starling.textures
{
   import flash.display3D.Context3D;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.errors.MissingContextError;
   import starling.filters.FragmentFilter;
   import starling.utils.SystemUtil;
   import starling.utils.execute;
   import starling.utils.getNextPowerOfTwo;
   
   public class RenderTexture extends SubTexture
   {
      
      private static var sClipRect:Rectangle = new Rectangle();
      
      public static var optimizePersistentBuffers:Boolean = false;
       
      
      private const CONTEXT_POT_SUPPORT_KEY:String = "RenderTexture.supportsNonPotDimensions";
      
      private const PMA:Boolean = true;
      
      private var mActiveTexture:Texture;
      
      private var mBufferTexture:Texture;
      
      private var mHelperImage:Image;
      
      private var mDrawing:Boolean;
      
      private var mBufferReady:Boolean;
      
      private var mIsPersistent:Boolean;
      
      private var mSupport:RenderSupport;
      
      public function RenderTexture(param1:int, param2:int, param3:Boolean = true, param4:Number = -1, param5:String = "bgra", param6:Boolean = false){super(null,null,null,null,null);}
      
      override public function dispose() : void{}
      
      public function draw(param1:DisplayObject, param2:Matrix = null, param3:Number = 1.0, param4:int = 0) : void{}
      
      public function drawBundled(param1:Function, param2:int = 0) : void{}
      
      private function render(param1:DisplayObject, param2:Matrix = null, param3:Number = 1.0) : void{}
      
      private function renderBundled(param1:Function, param2:DisplayObject = null, param3:Matrix = null, param4:Number = 1.0, param5:int = 0) : void{}
      
      public function clear(param1:uint = 0, param2:Number = 0.0) : void{}
      
      private function get supportsNonPotDimensions() : Boolean{return false;}
      
      private function get isDoubleBuffered() : Boolean{return false;}
      
      public function get isPersistent() : Boolean{return false;}
      
      override public function get base() : TextureBase{return null;}
      
      override public function get root() : ConcreteTexture{return null;}
   }
}
