package ddt.view.sceneCharacter
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SceneCharacterBase extends Sprite
   {
       
      
      private var _frameBitmap:Vector.<Bitmap>;
      
      private var _sceneCharacterActionItem:SceneCharacterActionItem;
      
      private var _frameIndex:int;
      
      public function SceneCharacterBase(param1:Vector.<Bitmap>)
      {
         _frameIndex = Math.random() * 7;
         super();
         _frameBitmap = param1;
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
      
      private function loadFrame(param1:int) : void
      {
         if(param1 >= _frameBitmap.length)
         {
            param1 = _frameBitmap.length - 1;
         }
         if(_frameBitmap && _frameBitmap[param1])
         {
            if(this.numChildren > 0 && this.getChildAt(0))
            {
               removeChildAt(0);
            }
            addChild(_frameBitmap[param1]);
         }
      }
      
      public function set sceneCharacterActionItem(param1:SceneCharacterActionItem) : void
      {
         _sceneCharacterActionItem = param1;
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
