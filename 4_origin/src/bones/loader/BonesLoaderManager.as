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
      
      public function BonesLoaderManager(param1:BonesLoaderMnagerEnforcer)
      {
         super();
         _loading = new DictionaryData();
         _boneList = [];
         _texture2BoneVoMap = new Dictionary();
      }
      
      public static function get instance() : BonesLoaderManager
      {
         if(_instance == null)
         {
            _instance = new BonesLoaderManager(new BonesLoaderMnagerEnforcer());
         }
         return _instance;
      }
      
      public function startLoader(param1:String, param2:int = 0, param3:String = "default") : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:BoneVo = BoneMovieFactory.instance.model.getBonesStyle(param1);
         if(_loc6_ == null)
         {
            _loc4_ = new Error("未找到\'" + param1 + "\'的配置，请检查!");
            throw _loc4_;
         }
         _loc6_.useType = param2;
         if(BoneMovieFactory.instance.hasBoneMovie(_loc6_.styleName))
         {
            dispatchEvent(new BonesLoaderEvent("complete",_loc6_));
         }
         else
         {
            _loc5_ = new BonesResourceLoader(_loc6_);
            _loc5_.module = param3;
            _loc5_.addEventListener("complete",__onLoadBoneComplete);
            _boneList.push(_loc5_);
            _loc5_.load();
         }
      }
      
      public function startLoaderByAtlas(param1:String, param2:String = "default") : void
      {
         var _loc3_:* = null;
         var _loc4_:BoneVo = BoneMovieFactory.instance.model.getBoneVoListByAtlasName(param1)[0];
         if(!BoneMovieFactory.instance.checkTextureAtlas(param1,_loc4_.useType))
         {
            _loc3_ = new BonesResourceLoader(_loc4_);
            _loc3_.module = param2;
            _loc3_.addEventListener("complete",__onLoadBoneComplete);
            _boneList.push(_loc3_);
            _loc3_.load();
         }
      }
      
      private function __onLoadBoneComplete(param1:Event) : void
      {
         var _loc2_:BonesResourceLoader = param1.currentTarget as BonesResourceLoader;
         if(BoneMovieFactory.instance.hasBoneMovie(_loc2_.vo.styleName))
         {
            dispatchEvent(new BonesLoaderEvent("complete",_loc2_.vo));
            _loc2_.removeEventListener("complete",__onLoadBoneComplete);
            _loc2_.dispose();
         }
         else
         {
            analysisLoader(_loc2_);
            checkBoneListComplete(_loc2_.vo);
         }
      }
      
      private function analysisLoader(param1:BonesResourceLoader) : void
      {
         loader = param1;
         if(loader.vo.useType == 0 || loader.vo.useType == 2)
         {
            var texture:Texture = Texture.fromBitmap(loader.image,false);
            _texture2BoneVoMap[texture] = loader.vo;
            texture.root.onRestore = function():void
            {
               onLoadBoneComplete = function(param1:Event):void
               {
                  restoreBonesResourceLoader.removeEventListener("complete",onLoadBoneComplete);
                  texture.root.uploadBitmap(restoreBonesResourceLoader.image);
                  restoreBonesResourceLoader.dispose();
               };
               var reStoreVo:BoneVo = _texture2BoneVoMap[texture];
               var restoreBonesResourceLoader:RestoreBonesResourceLoader = new RestoreBonesResourceLoader(reStoreVo);
               restoreBonesResourceLoader.addEventListener("complete",onLoadBoneComplete);
               restoreBonesResourceLoader.load();
            };
         }
         var i:int = 0;
         while(i < loader.skeletonList.length)
         {
            if(DDTAssetManager.instance.getSkeletonData(loader.skeletonList[i].name) == null)
            {
               DDTAssetManager.instance.addSkeletonData(DataParser.parseData(JSON.parse(loader.skeletonList[i].data)),loader.skeletonList[i].name);
            }
            i = Number(i) + 1;
         }
         if(loader.vo.useType == 0)
         {
            DDTAssetManager.instance.addTextureAtlas(loader.vo.atlasName,new StarlingTextureAtlas(texture,loader.atlas),loader.module);
         }
         else if(loader.vo.useType == 1)
         {
            DDTAssetManager.instance.addBitmapDataAtlas(loader.vo.atlasName,new NativeTextureAtlas(loader.image.bitmapData.clone(),loader.atlas),loader.module);
         }
         else
         {
            DDTAssetManager.instance.addBitmapDataAtlas(loader.vo.atlasName,new NativeTextureAtlas(loader.image.bitmapData.clone(),loader.atlas),loader.module);
            DDTAssetManager.instance.addTextureAtlas(loader.vo.atlasName,new StarlingTextureAtlas(texture,loader.atlas),loader.module);
         }
      }
      
      private function checkBoneListComplete(param1:BoneVo) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _boneList.length)
         {
            _loc3_ = _boneList[_loc6_] as BonesResourceLoader;
            if(param1.atlasName == _loc3_.vo.atlasName)
            {
               _loc4_.push(_loc3_);
               _loc3_.loaderComplete();
            }
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = _boneList.indexOf(_loc4_[_loc5_]);
            if(_loc2_ != -1)
            {
               _boneList.splice(_loc2_,1);
            }
            _loc5_++;
         }
         _loc4_.splice(0,_loc4_.length);
      }
      
      public function saveBoneLoaderData(param1:BoneVo) : void
      {
         _loading.add(param1.atlasName,true);
      }
      
      public function getBoneLoaderComplete(param1:BoneVo) : Boolean
      {
         return _loading.hasKey(param1.atlasName);
      }
      
      public function clearBoneLoaderAtlas(param1:String) : void
      {
         _loading.remove(param1);
      }
      
      public function loadBonesStyle(param1:String, param2:String) : void
      {
         var _loc3_:* = null;
         if(BoneMovieFactory.instance.model.hasLoadingBones(param1) == false)
         {
            _loc3_ = LoadResourceManager.Instance.createLoader(param2,2);
            _loc3_.addEventListener("complete",__onLoaderBonesComplete);
            LoadResourceManager.Instance.startLoad(_loc3_);
         }
      }
      
      private function __onLoaderBonesComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onLoaderBonesComplete);
         var _loc3_:XML = new XML(param1.loader.content);
         var _loc2_:String = _loc3_.@name;
         BoneMovieFactory.instance.model.parasBonesStyle(_loc3_..bone,_loc2_);
         dispatchEvent(new BonesLoaderEvent("bonesstylecompelete",_loc2_));
      }
      
      public function clear() : void
      {
         _loading.clear();
         _boneList.splice(0,_boneList.length);
         _boneList = [];
         _texture2BoneVoMap = new Dictionary();
      }
   }
}

class BonesLoaderMnagerEnforcer
{
    
   
   function BonesLoaderMnagerEnforcer()
   {
      super();
   }
}
