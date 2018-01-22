package starling.display.sceneCharacter
{
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   
   public class SceneCharacterState
   {
       
      
      protected var _sceneCharacterSet:SceneCharacterTextureSet;
      
      protected var _sceneCharacterActionSet:SceneCharacterActionSet;
      
      protected var _sceneCharacterActionPointSet:SceneCharacterActionPointSet;
      
      protected var _sceneCharacterSynthesis:SceneCharacterSynthesisBase;
      
      protected var _sceneCharacterDraw:SceneCharacterDrawBase;
      
      protected var _sceneCharacterDirection:SceneCharacterDirection;
      
      protected var _currentType:String;
      
      public function SceneCharacterState(param1:SceneCharacterTextureSet, param2:SceneCharacterActionSet, param3:SceneCharacterActionPointSet, param4:SceneCharacterDrawBase = null)
      {
         super();
         _sceneCharacterSet = param1;
         _sceneCharacterActionSet = param2;
         _sceneCharacterActionPointSet = param3;
         _sceneCharacterDraw = param4 || new SceneCharacterDrawBase();
         updateSynthesis();
      }
      
      public function updateSynthesis() : void
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
         _sceneCharacterSynthesis = new SceneCharacterSynthesisBase(_sceneCharacterSet,sceneCharacterSynthesisCallBack);
      }
      
      protected function sceneCharacterSynthesisCallBack(param1:SceneCharacterSynthesisBase) : void
      {
         _sceneCharacterDraw.setup(param1,_sceneCharacterActionSet,_sceneCharacterActionPointSet);
         setSceneCharacterActionState = defaultActionState;
      }
      
      public function updateTexture(param1:SceneCharacterTextureItem) : void
      {
         _sceneCharacterSet.replace(param1);
         _sceneCharacterSynthesis.addCharacterFrames(param1);
      }
      
      public function removeTexture(param1:String) : void
      {
         _sceneCharacterSet.removeItem(param1);
         _sceneCharacterSynthesis.removeCharacterFrames(param1);
      }
      
      public function set setSceneCharacterActionState(param1:String) : void
      {
         if(_currentType != param1)
         {
            _currentType = param1;
            _sceneCharacterDraw.state = param1;
         }
      }
      
      public function resetSceneCharacterDraw() : void
      {
         _sceneCharacterDraw.reset();
      }
      
      public function get setSceneCharacterActionState() : String
      {
         return _currentType;
      }
      
      public function set sceneCharacterDirection(param1:SceneCharacterDirection) : void
      {
         if(_sceneCharacterDirection == param1)
         {
            return;
         }
         _sceneCharacterDirection = param1;
      }
      
      public function get sceneCharacterSet() : SceneCharacterTextureSet
      {
         return _sceneCharacterSet;
      }
      
      public function set sceneCharacterSet(param1:SceneCharacterTextureSet) : void
      {
         _sceneCharacterSet = param1;
         updateSynthesis();
      }
      
      public function set sceneCharacterBase(param1:SceneCharacterDrawBase) : void
      {
         if(_sceneCharacterDraw)
         {
            _sceneCharacterDraw.dispose();
         }
         _sceneCharacterDraw = param1;
      }
      
      public function get sceneCharacterBase() : SceneCharacterDrawBase
      {
         return _sceneCharacterDraw;
      }
      
      public function get defaultActionState() : String
      {
         return _sceneCharacterActionSet.dataSet[0].state;
      }
      
      public function get sceneCharacterActionPointSet() : SceneCharacterActionPointSet
      {
         return _sceneCharacterActionPointSet;
      }
      
      public function get sceneCharacterActionSet() : SceneCharacterActionSet
      {
         return _sceneCharacterActionSet;
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
         if(_sceneCharacterActionPointSet)
         {
            _sceneCharacterActionPointSet.dispose();
         }
         _sceneCharacterActionPointSet = null;
         if(_sceneCharacterDraw)
         {
            if(_sceneCharacterDraw.parent)
            {
               _sceneCharacterDraw.parent.removeChild(_sceneCharacterDraw,true);
            }
         }
         _sceneCharacterDraw = null;
         _sceneCharacterDirection = null;
      }
   }
}
