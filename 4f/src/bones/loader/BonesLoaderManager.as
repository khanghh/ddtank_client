package bones.loader{   import bones.BoneMovieFactory;   import bones.model.BoneVo;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import dragonBones.objects.DataParser;   import dragonBones.textures.NativeTextureAtlas;   import dragonBones.textures.StarlingTextureAtlas;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.DDTAssetManager;   import road7th.data.DictionaryData;   import starling.textures.Texture;      public class BonesLoaderManager extends EventDispatcher   {            public static var FLASHSITE:String;            public static var SITE_MAIN:String;            private static var _instance:BonesLoaderManager;                   private var _boneList:Array;            private var _loading:DictionaryData;            private var _texture2BoneVoMap:Dictionary;            public function BonesLoaderManager(enforcer:BonesLoaderMnagerEnforcer) { super(); }
            public static function get instance() : BonesLoaderManager { return null; }
            public function startLoader(styleName:String, useType:int = 0, module:String = "default") : void { }
            public function startLoaderByAtlas(atlasName:String, module:String = "default") : void { }
            private function __onLoadBoneComplete(e:Event) : void { }
            private function analysisLoader(loader:BonesResourceLoader) : void { }
            private function checkBoneListComplete(vo:BoneVo) : void { }
            public function saveBoneLoaderData(vo:BoneVo) : void { }
            public function getBoneLoaderComplete(vo:BoneVo) : Boolean { return false; }
            public function clearBoneLoaderAtlas(atlasName:String) : void { }
            public function loadBonesStyle(value:String, path:String) : void { }
            private function __onLoaderBonesComplete(e:LoaderEvent) : void { }
            public function clear() : void { }
   }}class BonesLoaderMnagerEnforcer{          function BonesLoaderMnagerEnforcer() { super(); }
}