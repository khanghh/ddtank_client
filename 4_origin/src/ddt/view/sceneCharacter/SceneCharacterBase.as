package ddt.view.sceneCharacter
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SceneCharacterBase extends Sprite
   {
       
      
      private var _frameBitmap:Vector.<Bitmap>;
      
      private var _sceneCharacterActionItem:SceneCharacterActionItem;
      
      private var _frameIndex:int;
      
      public function SceneCharacterBase(frameBitmap:Vector.<Bitmap>)
      {
         _frameIndex = Math.random() * 7;
         super();
         _frameBitmap = frameBitmap;
         initialize();
      }
      
      private function initialize() : void
      {
      }
      
      public function update() : void
      {
         if(_frameIndex < _sceneCharacterActionItem.frames.length)
         {
            _frameIndex = Number(_frameIndex) + 1;
            loadFrame(_sceneCharacterActionItem.frames[Number(_frameIndex)]);
         }
         else if(_sceneCharacterActionItem.repeat)
         {
            _frameIndex = 0;
         }
      }
      
      private function loadFrame(frameIndex:int) : void
      {
         if(frameIndex >= _frameBitmap.length)
         {
            frameIndex = _frameBitmap.length - 1;
         }
         if(_frameBitmap && _frameBitmap[frameIndex])
         {
            if(this.numChildren > 0 && this.getChildAt(0))
            {
               removeChildAt(0);
            }
            addChild(_frameBitmap[frameIndex]);
         }
      }
      
      public function set sceneCharacterActionItem(value:SceneCharacterActionItem) : void
      {
         _sceneCharacterActionItem = value;
         _frameIndex = 0;
      }
      
      public function get sceneCharacterActionItem() : SceneCharacterActionItem
      {
         return _sceneCharacterActionItem;
      }
      
      public function dispose() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         while(_frameBitmap && _frameBitmap.length > 0)
         {
            _frameBitmap[0].bitmapData.dispose();
            _frameBitmap[0].bitmapData = null;
            _frameBitmap.shift();
         }
         _frameBitmap = null;
         if(_sceneCharacterActionItem)
         {
            _sceneCharacterActionItem.dispose();
         }
         _sceneCharacterActionItem = null;
      }
   }
}
