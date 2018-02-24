package starling.display.sceneCharacter
{
   import flash.geom.Rectangle;
   import road7th.DDTAssetManager;
   import road7th.data.DictionaryData;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class SceneCharacterSynthesisBase
   {
      
      public static const PARSE_TEXTURE:int = 0;
      
      public static const PARSE_TEXTUREATLAS:int = 1;
       
      
      private var _textureSet:SceneCharacterTextureSet;
      
      private var _actionSet:SceneCharacterActionSet;
      
      private var _actionPointSet:SceneCharacterActionPointSet;
      
      private var _callBack:Function;
      
      private var _characterFrames:DictionaryData;
      
      public function SceneCharacterSynthesisBase(param1:SceneCharacterTextureSet, param2:Function){super();}
      
      private function initialize() : void{}
      
      private function textureSynthesis() : void{}
      
      public function parseTexture(param1:SceneCharacterTextureItem) : Array{return null;}
      
      public function parseTextureAtlas(param1:SceneCharacterTextureItem) : Array{return null;}
      
      public function addCharacterFrames(param1:SceneCharacterTextureItem) : void{}
      
      public function removeCharacterFrames(param1:String) : void{}
      
      public function get textureSet() : SceneCharacterTextureSet{return null;}
      
      public function getFramesObject(param1:String) : Object{return null;}
      
      public function get characterFrames() : DictionaryData{return null;}
      
      public function dispose() : void{}
   }
}
