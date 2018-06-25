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
      
      public function BonesLoaderManager(enforcer:BonesLoaderMnagerEnforcer)
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
      
      public function startLoader(styleName:String, useType:int = 0, module:String = "default") : void
      {
         var error:* = null;
         var loader:* = null;
         var vo:BoneVo = BoneMovieFactory.instance.model.getBonesStyle(styleName);
         if(vo == null)
         {
            error = new Error("未找到\'" + styleName + "\'的配置，请检查!");
            throw error;
         }
         vo.useType = useType;
         if(BoneMovieFactory.instance.hasBoneMovie(vo.styleName))
         {
            dispatchEvent(new BonesLoaderEvent("complete",vo));
         }
         else
         {
            loader = new BonesResourceLoader(vo);
            loader.module = module;
            loader.addEventListener("complete",__onLoadBoneComplete);
            _boneList.push(loader);
            loader.load();
         }
      }
      
      public function startLoaderByAtlas(atlasName:String, module:String = "default") : void
      {
         var loader:* = null;
         var vo:BoneVo = BoneMovieFactory.instance.model.getBoneVoListByAtlasName(atlasName)[0];
         if(!BoneMovieFactory.instance.checkTextureAtlas(atlasName,vo.useType))
         {
            loader = new BonesResourceLoader(vo);
            loader.module = module;
            loader.addEventListener("complete",__onLoadBoneComplete);
            _boneList.push(loader);
            loader.load();
         }
      }
      
      private function __onLoadBoneComplete(e:Event) : void
      {
         var loader:BonesResourceLoader = e.currentTarget as BonesResourceLoader;
         if(BoneMovieFactory.instance.hasBoneMovie(loader.vo.styleName))
         {
            dispatchEvent(new BonesLoaderEvent("complete",loader.vo));
            loader.removeEventListener("complete",__onLoadBoneComplete);
            loader.dispose();
         }
         else
         {
            analysisLoader(loader);
            checkBoneListComplete(loader.vo);
         }
      }
      
      private function analysisLoader(loader:BonesResourceLoader) : void
      {
         loader = loader;
         if(loader.vo.useType == 0 || loader.vo.useType == 2)
         {
            var texture:Texture = Texture.fromBitmap(loader.image,false);
            _texture2BoneVoMap[texture] = loader.vo;
            texture.root.onRestore = function():void
            {
               onLoadBoneComplete = function(e:Event):void
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
      
      private function checkBoneListComplete(vo:BoneVo) : void
      {
         var i:int = 0;
         var loader:* = null;
         var j:int = 0;
         var index:int = 0;
         var list:Array = [];
         for(i = 0; i < _boneList.length; )
         {
            loader = _boneList[i] as BonesResourceLoader;
            if(vo.atlasName == loader.vo.atlasName)
            {
               list.push(loader);
               loader.loaderComplete();
            }
            i++;
         }
         for(j = 0; j < list.length; )
         {
            index = _boneList.indexOf(list[j]);
            if(index != -1)
            {
               _boneList.splice(index,1);
            }
            j++;
         }
         list.splice(0,list.length);
      }
      
      public function saveBoneLoaderData(vo:BoneVo) : void
      {
         _loading.add(vo.atlasName,true);
      }
      
      public function getBoneLoaderComplete(vo:BoneVo) : Boolean
      {
         return _loading.hasKey(vo.atlasName);
      }
      
      public function clearBoneLoaderAtlas(atlasName:String) : void
      {
         _loading.remove(atlasName);
      }
      
      public function loadBonesStyle(value:String, path:String) : void
      {
         var loader:* = null;
         if(BoneMovieFactory.instance.model.hasLoadingBones(value) == false)
         {
            loader = LoadResourceManager.Instance.createLoader(path,2);
            loader.addEventListener("complete",__onLoaderBonesComplete);
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      private function __onLoaderBonesComplete(e:LoaderEvent) : void
      {
         e.loader.removeEventListener("complete",__onLoaderBonesComplete);
         var xml:XML = new XML(e.loader.content);
         var name:String = xml.@name;
         BoneMovieFactory.instance.model.parasBonesStyle(xml..bone,name);
         dispatchEvent(new BonesLoaderEvent("bonesstylecompelete",name));
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
