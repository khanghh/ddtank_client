package starling.scene.common
{
   import flash.geom.Rectangle;
   import starling.display.Sprite;
   import starling.textures.SubTexture;
   import starlingui.core.components.UVImage;
   
   public class BgLayer extends Sprite
   {
       
      
      private var _uvImage1:UVImage;
      
      private var _uvImage2:UVImage;
      
      private var _texture1:SubTexture;
      
      private var _texture2:SubTexture;
      
      private var _frame1:Rectangle;
      
      private var _frame2:Rectangle;
      
      private var _viewRect:Rectangle;
      
      private var _uvImage1Rect:Rectangle;
      
      private var _uvImage2Rect:Rectangle;
      
      public function BgLayer(param1:Rectangle, param2:SubTexture, param3:SubTexture = null){super();}
      
      public function setCenter() : void{}
      
      public function onStageResize() : void{}
      
      override public function dispose() : void{}
   }
}
