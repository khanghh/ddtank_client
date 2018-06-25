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
      
      public function BgLayer(viewRect:Rectangle, texture1:SubTexture, texture2:SubTexture = null)
      {
         super();
         _viewRect = viewRect;
         _texture1 = texture1;
         _texture2 = texture2;
         _frame1 = _texture1.region;
         _uvImage1 = new UVImage(_texture1);
         _uvImage1Rect = new Rectangle();
         if(_texture2)
         {
            _frame2 = _texture2.region;
            _uvImage2 = new UVImage(_texture2);
            _uvImage2Rect = new Rectangle();
         }
      }
      
      public function setCenter() : void
      {
         if(_frame1.width > _viewRect.x)
         {
            _uvImage1Rect.x = _viewRect.x;
            _uvImage1Rect.y = _viewRect.y;
            _uvImage1Rect.width = _frame1.width - _viewRect.x;
            _uvImage1Rect.height = _viewRect.height;
            _uvImage1.visible = true;
            _uvImage1.x = _uvImage1Rect.x;
            _uvImage1.y = _uvImage1Rect.y;
            _uvImage1.setVertexPosion(0,0,0);
            _uvImage1.setVertexPosion(1,_uvImage1Rect.width,0);
            _uvImage1.setVertexPosion(2,0,_uvImage1Rect.height);
            _uvImage1.setVertexPosion(3,_uvImage1Rect.width,_uvImage1Rect.height);
            _uvImage1.setTexCoordsTo(0,_uvImage1Rect.x / _frame1.width,_uvImage1Rect.y / _frame1.height);
            _uvImage1.setTexCoordsTo(1,_uvImage1Rect.right / _frame1.width,_uvImage1Rect.y / _frame1.height);
            _uvImage1.setTexCoordsTo(2,_uvImage1Rect.x / _frame1.width,_uvImage1Rect.bottom / _frame1.height);
            _uvImage1.setTexCoordsTo(3,_uvImage1Rect.right / _frame1.width,_uvImage1Rect.bottom / _frame1.height);
            if(!_uvImage1.parent)
            {
               addChild(_uvImage1);
            }
         }
         else
         {
            _uvImage1.removeFromParent(false);
         }
         if(_viewRect.right > _frame1.width && _uvImage2)
         {
            _uvImage2Rect.x = _frame1.width;
            _uvImage2Rect.y = _viewRect.y;
            _uvImage2Rect.width = _viewRect.right - _frame1.width;
            _uvImage2Rect.height = _viewRect.height;
            _uvImage2.visible = true;
            _uvImage2.x = _uvImage2Rect.x;
            _uvImage2.y = _uvImage2Rect.y;
            _uvImage2.setVertexPosion(0,0,0);
            _uvImage2.setVertexPosion(1,_uvImage2Rect.width,0);
            _uvImage2.setVertexPosion(2,0,_uvImage2Rect.height);
            _uvImage2.setVertexPosion(3,_uvImage2Rect.width,_uvImage2Rect.height);
            _uvImage2.setTexCoordsTo(0,0,_uvImage2Rect.y / _frame2.height);
            _uvImage2.setTexCoordsTo(1,_uvImage2Rect.width / _frame2.width,_uvImage2Rect.y / _frame2.height);
            _uvImage2.setTexCoordsTo(2,0,_uvImage2Rect.bottom / _frame2.height);
            _uvImage2.setTexCoordsTo(3,_uvImage2Rect.width / _frame2.width,_uvImage2Rect.bottom / _frame2.height);
            if(!_uvImage2.parent)
            {
               addChild(_uvImage2);
            }
         }
         else if(_uvImage2)
         {
            _uvImage2.removeFromParent(false);
         }
      }
      
      public function onStageResize() : void
      {
         setCenter();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _uvImage1 = null;
         _uvImage2 = null;
         _texture1 = null;
         _texture2 = null;
         _frame1 = null;
         _frame2 = null;
         _viewRect = null;
         _uvImage1Rect = null;
         _uvImage2Rect = null;
      }
   }
}
