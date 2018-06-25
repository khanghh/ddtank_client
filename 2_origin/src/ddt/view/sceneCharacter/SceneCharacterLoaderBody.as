package ddt.view.sceneCharacter
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   
   public class SceneCharacterLoaderBody
   {
       
      
      private var _loaders:Vector.<SceneCharacterLayer>;
      
      private var _recordStyle:Array;
      
      private var _recordColor:Array;
      
      private var _content:BitmapData;
      
      private var _completeCount:int;
      
      private var _playerInfo:PlayerInfo;
      
      private var _sceneCharacterLoaderPath:String;
      
      private var _isAllLoadSucceed:Boolean = true;
      
      private var _callBack:Function;
      
      public function SceneCharacterLoaderBody(playerInfo:PlayerInfo, sceneCharacterLoaderPath:String = null)
      {
         super();
         _playerInfo = playerInfo;
         _sceneCharacterLoaderPath = sceneCharacterLoaderPath;
      }
      
      public function load(callBack:Function = null) : void
      {
         var i:int = 0;
         _callBack = callBack;
         if(_playerInfo == null || _playerInfo.Style == null)
         {
            return;
         }
         initLoaders();
         var loaderCount:int = _loaders.length;
         for(i = 0; i < loaderCount; )
         {
            _loaders[i].load(layerComplete);
            i++;
         }
      }
      
      private function initLoaders() : void
      {
         _loaders = new Vector.<SceneCharacterLayer>();
         _recordStyle = _playerInfo.Style.split(",");
         _recordColor = _playerInfo.Colors.split(",");
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],1,_playerInfo.Sex,_sceneCharacterLoaderPath));
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],2,_playerInfo.Sex,_sceneCharacterLoaderPath));
      }
      
      private function drawCharacter() : void
      {
         var i:* = 0;
         var picWidth:Number = _loaders[0].width;
         var picHeight:Number = _loaders[0].height;
         if(picWidth == 0 || picHeight == 0)
         {
            return;
         }
         _content = new BitmapData(picWidth,picHeight,true,0);
         for(i = uint(0); i < _loaders.length; )
         {
            if(!_loaders[i].isAllLoadSucceed)
            {
               _isAllLoadSucceed = false;
            }
            _content.draw(_loaders[i].getContent(),null,null,"normal");
            i++;
         }
      }
      
      private function layerComplete(layer:ILayer) : void
      {
         var i:int = 0;
         var isAllLayerComplete:Boolean = true;
         for(i = 0; i < _loaders.length; )
         {
            if(!_loaders[i].isComplete)
            {
               isAllLayerComplete = false;
            }
            i++;
         }
         if(isAllLayerComplete)
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
         var i:int = 0;
         if(_loaders == null)
         {
            return;
         }
         i = 0;
         while(i < _loaders.length)
         {
            _loaders[i].dispose();
            i++;
         }
         _loaders = null;
         _recordStyle = null;
         _recordColor = null;
         _playerInfo = null;
         _callBack = null;
         _sceneCharacterLoaderPath = null;
      }
   }
}
