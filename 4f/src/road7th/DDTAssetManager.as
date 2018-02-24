package road7th
{
   import bones.loader.BonesLoaderManager;
   import dragonBones.objects.DragonBonesData;
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import flash.utils.NativeTextureAssetManager;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   import starling.utils.AssetManager;
   
   public class DDTAssetManager
   {
      
      private static var _instance:DDTAssetManager;
       
      
      private var _btmd:Dictionary;
      
      private var _btmdAtlas:Dictionary;
      
      private var _texture:Dictionary;
      
      private var _textureAtlas:Dictionary;
      
      private var _skeletonData:Dictionary;
      
      private var _starlingAsset:AssetManager;
      
      private var _nativeAsset:NativeTextureAssetManager;
      
      private var _dragonBonesDataDic:Dictionary;
      
      public function DDTAssetManager(){super();}
      
      public static function get instance() : DDTAssetManager{return null;}
      
      public function addSkeletonData(param1:DragonBonesData, param2:String = null, param3:String = "") : void{}
      
      public function addBitmapData(param1:String, param2:BitmapData, param3:String = "none") : void{}
      
      public function addBitmapDataAtlas(param1:String, param2:NativeTextureAtlas, param3:String = "none") : void{}
      
      public function addTexture(param1:String, param2:Texture, param3:String = "none") : void{}
      
      public function addTextureAtlas(param1:String, param2:TextureAtlas, param3:String = "none") : void{}
      
      public function removeSkeletonData(param1:String) : void{}
      
      public function removeBitmapData(param1:String, param2:Boolean = true) : void{}
      
      public function removeBitmapDataAtlas(param1:String, param2:Boolean = true) : void{}
      
      public function removeTexture(param1:String, param2:Boolean = true) : void{}
      
      public function removeTextureAtlas(param1:String, param2:Boolean = true) : void{}
      
      public function removeSkeletonDataByMoule(param1:String) : void{}
      
      public function removeBitmapDataByMoule(param1:String) : void{}
      
      public function removeBitmapDataAtlasByMoule(param1:String) : void{}
      
      public function removeTextureByMoule(param1:String) : void{}
      
      public function removeTextureAtlasByMoule(param1:String) : void{}
      
      private function getModuleByName(param1:String, param2:Dictionary) : String{return null;}
      
      public function getSkeletonData(param1:String) : DragonBonesData{return null;}
      
      public function getBitmapData(param1:String) : BitmapData{return null;}
      
      public function getBitmapDataAtlas(param1:String) : NativeTextureAtlas{return null;}
      
      public function getTexture(param1:String) : Texture{return null;}
      
      public function getTextureAtlas(param1:String) : TextureAtlas{return null;}
      
      public function get nativeAsset() : NativeTextureAssetManager{return null;}
      
      public function get starlingAsset() : AssetManager{return null;}
      
      public function get dragonBonesDataDic() : Dictionary{return null;}
      
      public function removeAllResByModule(param1:String = "default") : void{}
      
      public function changeModule(param1:String, param2:String, param3:int) : Boolean{return false;}
      
      private function checkModule(param1:String) : Boolean{return false;}
      
      public function purge() : void{}
      
      public function dispose() : void{}
   }
}
