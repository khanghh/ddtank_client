package hall.player
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   
   public class HallSceneCharacterLoaderLayer
   {
       
      
      private var _loaders:Vector.<HallSceneCharacterLayer>;
      
      private var _recordStyle:Array;
      
      private var _recordColor:Array;
      
      private var _content:BitmapData;
      
      private var _completeCount:int;
      
      private var _playerInfo:PlayerInfo;
      
      private var _sceneCharacterLoaderType:int;
      
      private var _isAllLoadSucceed:Boolean = true;
      
      private var _callBack:Function;
      
      public function HallSceneCharacterLoaderLayer(param1:PlayerInfo, param2:int = 0)
      {
         super();
         _playerInfo = param1;
         _sceneCharacterLoaderType = param2;
      }
      
      public function load(param1:Function = null) : void
      {
         var _loc3_:int = 0;
         _callBack = param1;
         if(_playerInfo == null || _playerInfo.Style == null)
         {
            return;
         }
         initLoaders();
         var _loc2_:int = _loaders.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loaders[_loc3_].load(layerComplete);
            _loc3_++;
         }
      }
      
      private function initLoaders() : void
      {
         _loaders = new Vector.<HallSceneCharacterLayer>();
         _recordStyle = _playerInfo.Style.split(",");
         _recordColor = _playerInfo.Colors.split(",");
         if(_playerInfo.MountsType > 0)
         {
            _loaders.push(new HallSceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],0,_playerInfo.Sex,_sceneCharacterLoaderType,_playerInfo.MountsType));
         }
         else
         {
            _loaders.push(new HallSceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],1,_playerInfo.Sex,_sceneCharacterLoaderType,_playerInfo.MountsType));
            _loaders.push(new HallSceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],2,_playerInfo.Sex,_sceneCharacterLoaderType,_playerInfo.MountsType));
         }
      }
      
      private function drawCharacter() : void
      {
         var _loc2_:* = 0;
         var _loc1_:Number = _loaders[0].width;
         var _loc3_:Number = _loaders[0].height;
         if(_loc1_ == 0 || _loc3_ == 0)
         {
            return;
         }
         _content = new BitmapData(_loc1_,_loc3_,true,0);
         _loc2_ = uint(0);
         while(_loc2_ < _loaders.length)
         {
            if(!_loaders[_loc2_].isAllLoadSucceed)
            {
               _isAllLoadSucceed = false;
            }
            _content.draw(_loaders[_loc2_].getContent(),null,null,"normal");
            _loc2_++;
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
      }
   }
}
