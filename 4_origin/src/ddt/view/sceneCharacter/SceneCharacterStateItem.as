package ddt.view.sceneCharacter
{
   import flash.display.Bitmap;
   
   public class SceneCharacterStateItem
   {
       
      
      private var _type:String;
      
      private var _sceneCharacterSet:SceneCharacterSet;
      
      private var _sceneCharacterActionSet:SceneCharacterActionSet;
      
      private var _sceneCharacterSynthesis:SceneCharacterSynthesis;
      
      private var _sceneCharacterBase:SceneCharacterBase;
      
      private var _frameBitmap:Vector.<Bitmap>;
      
      private var _sceneCharacterActionItem:SceneCharacterActionItem;
      
      private var _sceneCharacterDirection:SceneCharacterDirection;
      
      public function SceneCharacterStateItem(type:String, sceneCharacterSet:SceneCharacterSet, sceneCharacterActionSet:SceneCharacterActionSet)
      {
         super();
         _type = type;
         _sceneCharacterSet = sceneCharacterSet;
         _sceneCharacterActionSet = sceneCharacterActionSet;
      }
      
      public function update() : void
      {
         if(!_sceneCharacterSet || !_sceneCharacterActionSet)
         {
            return;
         }
         if(_sceneCharacterSynthesis)
         {
            _sceneCharacterSynthesis.dispose();
         }
         _sceneCharacterSynthesis = null;
         _sceneCharacterSynthesis = new SceneCharacterSynthesis(_sceneCharacterSet,sceneCharacterSynthesisCallBack);
      }
      
      private function sceneCharacterSynthesisCallBack(frameBitmap:Vector.<Bitmap>) : void
      {
         _frameBitmap = frameBitmap;
         if(_sceneCharacterBase)
         {
            _sceneCharacterBase.dispose();
         }
         _sceneCharacterBase = null;
         _sceneCharacterBase = new SceneCharacterBase(_frameBitmap);
         _sceneCharacterActionItem = _sceneCharacterActionSet.dataSet[0];
         _sceneCharacterBase.sceneCharacterActionItem = _sceneCharacterActionSet.dataSet[0];
      }
      
      public function set setSceneCharacterActionType(type:String) : void
      {
         var item:SceneCharacterActionItem = _sceneCharacterActionSet.getItem(type);
         if(item)
         {
            _sceneCharacterActionItem = item;
         }
         _sceneCharacterBase.sceneCharacterActionItem = _sceneCharacterActionItem;
      }
      
      public function get setSceneCharacterActionType() : String
      {
         return _sceneCharacterActionItem.type;
      }
      
      public function set sceneCharacterDirection(value:SceneCharacterDirection) : void
      {
         if(_sceneCharacterDirection == value)
         {
            return;
         }
         _sceneCharacterDirection = value;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(value:String) : void
      {
         _type = value;
      }
      
      public function get sceneCharacterSet() : SceneCharacterSet
      {
         return _sceneCharacterSet;
      }
      
      public function set sceneCharacterSet(value:SceneCharacterSet) : void
      {
         _sceneCharacterSet = value;
      }
      
      public function get sceneCharacterBase() : SceneCharacterBase
      {
         return _sceneCharacterBase;
      }
      
      public function dispose() : void
      {
         if(_sceneCharacterSet)
         {
            _sceneCharacterSet.dispose();
         }
         _sceneCharacterSet = null;
         if(_sceneCharacterActionSet)
         {
            _sceneCharacterActionSet.dispose();
         }
         _sceneCharacterActionSet = null;
         if(_sceneCharacterSynthesis)
         {
            _sceneCharacterSynthesis.dispose();
         }
         _sceneCharacterSynthesis = null;
         if(_sceneCharacterBase)
         {
            _sceneCharacterBase.dispose();
         }
         _sceneCharacterBase = null;
         if(_sceneCharacterActionItem)
         {
            _sceneCharacterActionItem.dispose();
         }
         _sceneCharacterActionItem = null;
         _sceneCharacterDirection = null;
         while(_frameBitmap && _frameBitmap.length > 0)
         {
            _frameBitmap[0].bitmapData.dispose();
            _frameBitmap[0].bitmapData = null;
            _frameBitmap.shift();
         }
         _frameBitmap = null;
      }
      
      public function get frameBitmap() : Vector.<Bitmap>
      {
         return _frameBitmap;
      }
   }
}
