package bones.loader
{
   import bones.BoneMovieFactory;
   import bones.model.BoneVo;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import dragonBones.objects.DataParser;
   import dragonBones.textures.NativeTextureAtlas;
   import dragonBones.textures.StarlingTextureAtlas;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.DDTAssetManager;
   import road7th.data.DictionaryData;
   import starling.textures.Texture;
   
   public class BonesLoaderManager extends EventDispatcher
   {
      
      public static var FLASHSITE:String;
      
      public static var SITE_MAIN:String;
      
      private static var _instance:BonesLoaderManager;
       
      
      private var _boneList:Array;
      
      private var _loading:DictionaryData;
      
      private var _texture2BoneVoMap:Dictionary;
      
      public function BonesLoaderManager(param1:BonesLoaderMnagerEnforcer){super();}
      
      public static function get instance() : BonesLoaderManager{return null;}
      
      public function startLoader(param1:String, param2:int = 0, param3:String = "default") : void{}
      
      public function startLoaderByAtlas(param1:String, param2:String = "default") : void{}
      
      private function __onLoadBoneComplete(param1:Event) : void{}
      
      private function analysisLoader(param1:BonesResourceLoader) : void{}
      
      private function checkBoneListComplete(param1:BoneVo) : void{}
      
      public function saveBoneLoaderData(param1:BoneVo) : void{}
      
      public function getBoneLoaderComplete(param1:BoneVo) : Boolean{return false;}
      
      public function clearBoneLoaderAtlas(param1:String) : void{}
      
      public function loadBonesStyle(param1:String, param2:String) : void{}
      
      private function __onLoaderBonesComplete(param1:LoaderEvent) : void{}
      
      public function clear() : void{}
   }
}

class BonesLoaderMnagerEnforcer
{
    
   
   function BonesLoaderMnagerEnforcer(){super();}
}
