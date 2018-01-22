package ddt.view.sceneCharacter
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   
   public class SceneCharacterLoaderHead
   {
       
      
      private var _loaders:Vector.<SceneCharacterLayer>;
      
      private var _recordStyle:Array;
      
      private var _recordColor:Array;
      
      private var _content:BitmapData;
      
      private var _completeCount:int;
      
      private var _playerInfo:PlayerInfo;
      
      private var _isAllLoadSucceed:Boolean = true;
      
      private var _callBack:Function;
      
      private var _needLoadGirlHead:Boolean;
      
      private var _girlHeadPicLoader:GirlHeadPicLoader;
      
      public function SceneCharacterLoaderHead(param1:PlayerInfo, param2:Boolean = false)
      {
         super();
         _playerInfo = param1;
         _needLoadGirlHead = param2;
      }
      
      public function load(param1:Function = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _callBack = param1;
         if(_playerInfo == null || _playerInfo.Style == null)
         {
            return;
         }
         if(_needLoadGirlHead && _playerInfo.ImagePath != "")
         {
            _girlHeadPicLoader = new GirlHeadPicLoader();
            _girlHeadPicLoader.load("http://ddthead.7road.com" + _playerInfo.ImagePath,girlHeadPicLoaded);
         }
         else
         {
            initLoaders();
            _loc2_ = _loaders.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loaders[_loc3_].load(layerComplete);
               _loc3_++;
            }
         }
      }
      
      private function girlHeadPicLoaded(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            _callBack(this,false);
         }
         else
         {
            _content = new BitmapData(param1.width,param1.height,true,0);
            _content.draw(param1,null,null,"normal");
            _callBack(this,true);
         }
      }
      
      private function initLoaders() : void
      {
         _loaders = new Vector.<SceneCharacterLayer>();
         _recordStyle = _playerInfo.Style.split(",");
         _recordColor = _playerInfo.Colors.split(",");
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5]));
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[2].split("|")[0])),_recordColor[2]));
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[3].split("|")[0])),_recordColor[3]));
      }
      
      private function drawCharacter() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         var _loc1_:Number = _loaders[0].width;
         var _loc4_:Number = _loaders[0].height;
         if(_loc1_ == 0 || _loc4_ == 0)
         {
            return;
         }
         _content = new BitmapData(_loc1_,_loc4_,true,0);
         _loc3_ = uint(0);
         while(_loc3_ < _loaders.length)
         {
            _loc2_ = _loaders[_loc3_];
            if(!_loc2_.isAllLoadSucceed)
            {
               _isAllLoadSucceed = false;
            }
            _content.draw(_loc2_.getContent(),null,null,"normal");
            _loc3_++;
         }
      }
      
      private function layerComplete(param1:ILayer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _loaders.length)
         {
            if(!_loaders[_loc3_].isComplete)
            {
               _loc2_ = false;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            drawCharacter();
            loadComplete();
         }
      }
      
      private function loadComplete() : void
      {
         if(_callBack != null)
         {
            _callBack(this,_isAllLoadSucceed);
         }
      }
      
      public function getContent() : Array
      {
         return [_content];
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_loaders == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _loaders.length)
         {
            _loaders[_loc1_].dispose();
            _loc1_++;
         }
         _loaders = null;
         _recordStyle = null;
         _recordColor = null;
         _playerInfo = null;
         _callBack = null;
         return;
         §§push(_girlHeadPicLoader && null);
      }
   }
}
