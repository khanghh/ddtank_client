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
      
      public function SceneCharacterStateItem(param1:String, param2:SceneCharacterSet, param3:SceneCharacterActionSet)
      {
         super();
         _type = param1;
         _sceneCharacterSet = param2;
         _sceneCharacterActionSet = param3;
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
      
      private function sceneCharacterSynthesisCallBack(param1:Vector.<Bitmap>) : void
      {
         _frameBitmap = param1;
         if(_sceneCharacterBase)
         {
            _sceneCharacterBase.dispose();
         }
         _sceneCharacterBase = null;
         _sceneCharacterBase = new SceneCharacterBase(_frameBitmap);
         _sceneCharacterActionItem = _sceneCharacterActionSet.dataSet[0];
         _sceneCharacterBase.sceneCharacterActionItem = _sceneCharacterActionSet.dataSet[0];
      }
      
      public function set setSceneCharacterActionType(param1:String) : void
      {
         var _loc2_:SceneCharacterActionItem = _sceneCharacterActionSet.getItem(param1);
         if(_loc2_)
         {
            _sceneCharacterActionItem = _loc2_;
         }
         _sceneCharacterBase.sceneCharacterActionItem = _sceneCharacterActionItem;
      }
      
      public function get setSceneCharacterActionType() : String
      {
         return _sceneCharacterActionItem.type;
      }
      
      public function set sceneCharacterDirection(param1:SceneCharacterDirection) : void
      {
         if(_sceneCharacterDirection == param1)
         {
            return;
         }
         _sceneCharacterDirection = param1;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function get sceneCharacterSet() : SceneCharacterSet
      {
         return _sceneCharacterSet;
      }
      
      public function set sceneCharacterSet(param1:SceneCharacterSet) : void
      {
         _sceneCharacterSet = param1;
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
