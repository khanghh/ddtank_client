package ddt.view.sceneCharacter
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SceneCharacterBase extends Sprite
   {
       
      
      private var _frameBitmap:Vector.<Bitmap>;
      
      private var _sceneCharacterActionItem:SceneCharacterActionItem;
      
      private var _frameIndex:int;
      
      public function SceneCharacterBase(param1:Vector.<Bitmap>){super();}
      
      private function initialize() : void{}
      
      public function update() : void{}
      
      private function loadFrame(param1:int) : void{}
      
      public function set sceneCharacterActionItem(param1:SceneCharacterActionItem) : void{}
      
      public function get sceneCharacterActionItem() : SceneCharacterActionItem{return null;}
      
      public function dispose() : void{}
   }
}
