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
      
      public function SceneCharacterStateItem(param1:String, param2:SceneCharacterSet, param3:SceneCharacterActionSet){super();}
      
      public function update() : void{}
      
      private function sceneCharacterSynthesisCallBack(param1:Vector.<Bitmap>) : void{}
      
      public function set setSceneCharacterActionType(param1:String) : void{}
      
      public function get setSceneCharacterActionType() : String{return null;}
      
      public function set sceneCharacterDirection(param1:SceneCharacterDirection) : void{}
      
      public function get type() : String{return null;}
      
      public function set type(param1:String) : void{}
      
      public function get sceneCharacterSet() : SceneCharacterSet{return null;}
      
      public function set sceneCharacterSet(param1:SceneCharacterSet) : void{}
      
      public function get sceneCharacterBase() : SceneCharacterBase{return null;}
      
      public function dispose() : void{}
      
      public function get frameBitmap() : Vector.<Bitmap>{return null;}
   }
}
