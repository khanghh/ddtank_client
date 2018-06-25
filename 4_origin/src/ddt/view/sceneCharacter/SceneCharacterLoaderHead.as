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
      
      public function SceneCharacterLoaderHead(playerInfo:PlayerInfo, loadGirlHead:Boolean = false)
      {
         super();
         _playerInfo = playerInfo;
         _needLoadGirlHead = loadGirlHead;
      }
      
      public function load(callBack:Function = null) : void
      {
         var loaderCount:int = 0;
         var i:int = 0;
         _callBack = callBack;
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
            loaderCount = _loaders.length;
            for(i = 0; i < loaderCount; )
            {
               _loaders[i].load(layerComplete);
               i++;
            }
         }
      }
      
      private function girlHeadPicLoaded(headPic:DisplayObject) : void
      {
         if(headPic == null)
         {
            _callBack(this,false);
         }
         else
         {
            _content = new BitmapData(headPic.width,headPic.height,true,0);
            _content.draw(headPic,null,null,"normal");
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
         var i:* = 0;
         var layer:* = null;
         var picWidth:Number = _loaders[0].width;
         var picHeight:Number = _loaders[0].height;
         if(picWidth == 0 || picHeight == 0)
         {
            return;
         }
         _content = new BitmapData(picWidth,picHeight,true,0);
         for(i = uint(0); i < _loaders.length; )
         {
            layer = _loaders[i];
            if(!layer.isAllLoadSucceed)
            {
               _isAllLoadSucceed = false;
            }
            _content.draw(layer.getContent(),null,null,"normal");
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
         return;
         §§push(_girlHeadPicLoader && null);
      }
   }
}
