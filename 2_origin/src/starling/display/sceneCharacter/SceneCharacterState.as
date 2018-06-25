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
      
      public function SceneCharacterState(textureSet:SceneCharacterTextureSet, actionSet:SceneCharacterActionSet, actionPointSet:SceneCharacterActionPointSet, draw:SceneCharacterDrawBase = null)
      {
         super();
         _sceneCharacterSet = textureSet;
         _sceneCharacterActionSet = actionSet;
         _sceneCharacterActionPointSet = actionPointSet;
         _sceneCharacterDraw = draw || new SceneCharacterDrawBase();
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
      
      protected function sceneCharacterSynthesisCallBack(synthesis:SceneCharacterSynthesisBase) : void
      {
         _sceneCharacterDraw.setup(synthesis,_sceneCharacterActionSet,_sceneCharacterActionPointSet);
         setSceneCharacterActionState = defaultActionState;
      }
      
      public function updateTexture(textureItem:SceneCharacterTextureItem) : void
      {
         _sceneCharacterSet.replace(textureItem);
         _sceneCharacterSynthesis.addCharacterFrames(textureItem);
      }
      
      public function removeTexture(type:String) : void
      {
         _sceneCharacterSet.removeItem(type);
         _sceneCharacterSynthesis.removeCharacterFrames(type);
      }
      
      public function set setSceneCharacterActionState(state:String) : void
      {
         if(_currentType != state)
         {
            _currentType = state;
            _sceneCharacterDraw.state = state;
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
      
      public function set sceneCharacterDirection(value:SceneCharacterDirection) : void
      {
         if(_sceneCharacterDirection == value)
         {
            return;
         }
         _sceneCharacterDirection = value;
      }
      
      public function get sceneCharacterSet() : SceneCharacterTextureSet
      {
         return _sceneCharacterSet;
      }
      
      public function set sceneCharacterSet(value:SceneCharacterTextureSet) : void
      {
         _sceneCharacterSet = value;
         updateSynthesis();
      }
      
      public function set sceneCharacterBase(value:SceneCharacterDrawBase) : void
      {
         if(_sceneCharacterDraw)
         {
            _sceneCharacterDraw.dispose();
         }
         _sceneCharacterDraw = value;
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
