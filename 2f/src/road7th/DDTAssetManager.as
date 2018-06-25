package road7th{   import bones.loader.BonesLoaderManager;   import dragonBones.objects.DragonBonesData;   import dragonBones.textures.NativeTextureAtlas;   import flash.display.BitmapData;   import flash.utils.Dictionary;   import flash.utils.NativeTextureAssetManager;   import starling.textures.Texture;   import starling.textures.TextureAtlas;   import starling.utils.AssetManager;      public class DDTAssetManager   {            private static var _instance:DDTAssetManager;                   private var _btmd:Dictionary;            private var _btmdAtlas:Dictionary;            private var _texture:Dictionary;            private var _textureAtlas:Dictionary;            private var _skeletonData:Dictionary;            private var _starlingAsset:AssetManager;            private var _nativeAsset:NativeTextureAssetManager;            private var _dragonBonesDataDic:Dictionary;            public function DDTAssetManager() { super(); }
            public static function get instance() : DDTAssetManager { return null; }
            public function addSkeletonData(data:DragonBonesData, name:String = null, module:String = "") : void { }
            public function addBitmapData(name:String, btmd:BitmapData, module:String = "none") : void { }
            public function addBitmapDataAtlas(name:String, atlas:NativeTextureAtlas, module:String = "none") : void { }
            public function addTexture(name:String, texture:Texture, module:String = "none") : void { }
            public function addTextureAtlas(name:String, atlas:TextureAtlas, module:String = "none") : void { }
            public function removeSkeletonData(name:String) : void { }
            public function removeBitmapData(name:String, dispose:Boolean = true) : void { }
            public function removeBitmapDataAtlas(name:String, dispose:Boolean = true) : void { }
            public function removeTexture(name:String, dispose:Boolean = true) : void { }
            public function removeTextureAtlas(name:String, dispose:Boolean = true) : void { }
            public function removeSkeletonDataByMoule(module:String) : void { }
            public function removeBitmapDataByMoule(module:String) : void { }
            public function removeBitmapDataAtlasByMoule(module:String) : void { }
            public function removeTextureByMoule(module:String) : void { }
            public function removeTextureAtlasByMoule(module:String) : void { }
            private function getModuleByName(name:String, data:Dictionary) : String { return null; }
            public function getSkeletonData(name:String) : DragonBonesData { return null; }
            public function getBitmapData(name:String) : BitmapData { return null; }
            public function getBitmapDataAtlas(name:String) : NativeTextureAtlas { return null; }
            public function getTexture(name:String) : Texture { return null; }
            public function getTextureAtlas(name:String) : TextureAtlas { return null; }
            public function get nativeAsset() : NativeTextureAssetManager { return null; }
            public function get starlingAsset() : AssetManager { return null; }
            public function get dragonBonesDataDic() : Dictionary { return null; }
            public function removeAllResByModule(module:String = "default") : void { }
            public function changeModule(name:String, module:String, useType:int) : Boolean { return false; }
            private function checkModule(module:String) : Boolean { return false; }
            public function purge() : void { }
            public function dispose() : void { }
   }}