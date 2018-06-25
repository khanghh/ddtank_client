package starling.scene.hall.player
{
   import ddt.data.player.PlayerInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import road7th.DDTAssetManager;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class HallPlayerAsset extends EventDispatcher
   {
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _asset:DDTAssetManager;
      
      private var _cellBack:Function;
      
      private var _loadCount:int;
      
      private var _isResetLoad:String;
      
      private var _playerInfoStyle:Array;
      
      private var _playerInfoColor:Array;
      
      private var _playerInfoSex:Boolean;
      
      private var _playerInfoMountsType:int;
      
      private var _headLoader:HallPlayerBaseLoader;
      
      private var _bodyLoader:HallPlayerBaseLoader;
      
      private var _mountLoader:HallPlayerBaseLoader;
      
      public function HallPlayerAsset(playerInfo:PlayerInfo)
      {
         super();
         _playerInfo = playerInfo;
         _asset = DDTAssetManager.instance;
      }
      
      public function load() : void
      {
         resetLoader();
         loadHead();
         loadBody();
         loadMount();
      }
      
      public function resetLoader() : void
      {
         _isResetLoad = "";
         updateLoadData();
      }
      
      public function loadHead() : void
      {
         _isResetLoad = _isResetLoad + headAssetName;
         if(_asset.getTexture(headAssetName))
         {
            _asset.removeTexture(headAssetName);
         }
         if(_headLoader)
         {
            _headLoader.dispose();
         }
         _headLoader = new HallPlayerHeadLoader(_playerInfoStyle,_playerInfoColor);
         _headLoader.load(loaderComplete);
      }
      
      public function loadBody() : void
      {
         _isResetLoad = _isResetLoad + bodyAssetName;
         if(_asset.getTexture(bodyAssetName) == null)
         {
            if(_bodyLoader)
            {
               _bodyLoader.dispose();
            }
            _bodyLoader = new HallPlayerBodyLoader(_playerInfoStyle,_playerInfoColor,_playerInfoSex,_playerInfoMountsType);
            _bodyLoader.load(loaderComplete);
         }
      }
      
      public function loadMount() : void
      {
         if(_playerInfo.IsMounts)
         {
            _isResetLoad = _isResetLoad + mountsAssetName;
            if(_asset.getTextureAtlas(mountsAssetName) == null)
            {
               if(_mountLoader)
               {
                  _mountLoader.dispose();
               }
               _mountLoader = new HallPlayerMountsLoader(_playerInfoMountsType);
               _mountLoader.load(loaderComplete);
            }
            else if(checkLoadAllComplete() && _playerInfo != null)
            {
               _loadCount = Number(_loadCount) + 1;
               dispatchEvent(new Event("complete"));
            }
         }
      }
      
      private function loaderComplete(loader:HallPlayerBaseLoader) : void
      {
         loader = loader;
         if(_playerInfo == null)
         {
            loader.dispose();
            return;
         }
         if(loader.isAllLoadSucceed)
         {
            if(loader is HallPlayerHeadLoader)
            {
               var texture:Texture = _asset.getTexture(headAssetName);
               if(texture)
               {
                  texture.root.uploadBitmapData(loader.content as BitmapData);
               }
               else
               {
                  texture = Texture.fromBitmapData(loader.content as BitmapData,false);
                  var headStyle:Array = _playerInfoStyle;
                  var headColor:Array = _playerInfoColor;
                  texture.root.onRestore = function():void
                  {
                     var loader:HallPlayerHeadLoader = new HallPlayerHeadLoader(headStyle,headColor);
                     loader.load(loaderComplete);
                  };
                  _asset.addTexture(headAssetName,texture,"main");
               }
            }
            else if(loader is HallPlayerBodyLoader)
            {
               texture = _asset.getTexture(bodyAssetName);
               if(texture)
               {
                  texture.root.uploadBitmapData(loader.content as BitmapData);
               }
               else
               {
                  texture = Texture.fromBitmapData(loader.content as BitmapData,false);
                  var bodyStyle:Array = _playerInfoStyle;
                  var bodyColor:Array = _playerInfoColor;
                  var sex:Boolean = _playerInfoSex;
                  texture.root.onRestore = function():void
                  {
                     var loader:HallPlayerBodyLoader = new HallPlayerBodyLoader(bodyStyle,bodyColor,sex,_playerInfoMountsType);
                     loader.load(loaderComplete);
                  };
                  _asset.addTexture(bodyAssetName,texture,"main");
               }
            }
            else if(loader is HallPlayerMountsLoader)
            {
               var textureAtlas:TextureAtlas = _asset.getTextureAtlas(mountsAssetName);
               if(textureAtlas)
               {
                  textureAtlas.texture.root.uploadBitmap(loader.content.image as Bitmap);
               }
               else
               {
                  texture = Texture.fromBitmap(loader.content.image as Bitmap,false);
                  texture.root.onRestore = function():void
                  {
                     var loader:HallPlayerMountsLoader = new HallPlayerMountsLoader(_playerInfoMountsType);
                     loader.load(loaderComplete);
                  };
                  var atlas:TextureAtlas = new TextureAtlas(texture,XML(loader.content.xml));
                  _asset.addTextureAtlas(mountsAssetName,atlas,"main");
               }
            }
         }
         else
         {
            trace("HallPlayerAsset 加载异常!!!!!!!!!!!");
         }
         loader.dispose();
         if(checkLoadAllComplete() && _playerInfo != null)
         {
            _loadCount = Number(_loadCount) + 1;
            dispatchEvent(new Event("complete"));
         }
      }
      
      private function checkLoadAllComplete() : Boolean
      {
         if(_asset.getTexture(headAssetName) == null)
         {
            return false;
         }
         if(_asset.getTexture(bodyAssetName) == null)
         {
            return false;
         }
         if(_playerInfo.IsMounts && _asset.getTextureAtlas(mountsAssetName) == null)
         {
            return false;
         }
         return true;
      }
      
      public function isResetByAssetName(value:String) : Boolean
      {
         return _isResetLoad.indexOf(value) != -1;
      }
      
      public function isFirstLoad() : Boolean
      {
         return _loadCount == 1;
      }
      
      private function updateLoadData() : void
      {
         _playerInfoStyle = _playerInfo.Style.split(",");
         _playerInfoColor = _playerInfo.Colors.split(",");
         _playerInfoMountsType = _playerInfo.MountsType;
         _playerInfoSex = _playerInfo.Sex;
      }
      
      public function get headAssetName() : String
      {
         return "scene_head_" + _playerInfo.ID;
      }
      
      public function get bodyAssetName() : String
      {
         var bs:String = _playerInfoMountsType == 140?"n":!!_playerInfo.Sex?"m":"f";
         return "scene_cloth_" + bs + "_" + "1";
      }
      
      public function get mountsAssetName() : String
      {
         return "image_mounts_horse_" + _playerInfo.MountsType;
      }
      
      public function dispose() : void
      {
         if(_headLoader)
         {
            _headLoader.dispose();
         }
         _headLoader = null;
         if(_bodyLoader)
         {
            _bodyLoader.dispose();
         }
         _bodyLoader = null;
         if(_mountLoader)
         {
            _mountLoader.dispose();
         }
         _mountLoader = null;
         _cellBack = null;
         _playerInfo = null;
         _asset = null;
         _isResetLoad = null;
         _playerInfoStyle = null;
         _playerInfoColor = null;
      }
   }
}
