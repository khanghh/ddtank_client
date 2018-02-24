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
      
      public function SceneCharacterState(param1:SceneCharacterTextureSet, param2:SceneCharacterActionSet, param3:SceneCharacterActionPointSet, param4:SceneCharacterDrawBase = null){super();}
      
      public function updateSynthesis() : void{}
      
      protected function sceneCharacterSynthesisCallBack(param1:SceneCharacterSynthesisBase) : void{}
      
      public function updateTexture(param1:SceneCharacterTextureItem) : void{}
      
      public function removeTexture(param1:String) : void{}
      
      public function set setSceneCharacterActionState(param1:String) : void{}
      
      public function resetSceneCharacterDraw() : void{}
      
      public function get setSceneCharacterActionState() : String{return null;}
      
      public function set sceneCharacterDirection(param1:SceneCharacterDirection) : void{}
      
      public function get sceneCharacterSet() : SceneCharacterTextureSet{return null;}
      
      public function set sceneCharacterSet(param1:SceneCharacterTextureSet) : void{}
      
      public function set sceneCharacterBase(param1:SceneCharacterDrawBase) : void{}
      
      public function get sceneCharacterBase() : SceneCharacterDrawBase{return null;}
      
      public function get defaultActionState() : String{return null;}
      
      public function get sceneCharacterActionPointSet() : SceneCharacterActionPointSet{return null;}
      
      public function get sceneCharacterActionSet() : SceneCharacterActionSet{return null;}
      
      public function dispose() : void{}
   }
}
