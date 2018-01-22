package consortionBattle.player
{
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   
   public class ConsBatLoaderHeadOrBody
   {
       
      
      private var _loaders:Vector.<ConsBattSceneCharacterLayer>;
      
      private var _content:BitmapData;
      
      private var _completeCount:int;
      
      private var _isAllLoadSucceed:Boolean = true;
      
      private var _callBack:Function;
      
      private var _consBatPlayerData:ConsortiaBattlePlayerInfo;
      
      private var _equipType:int;
      
      public function ConsBatLoaderHeadOrBody(param1:ConsortiaBattlePlayerInfo, param2:int)
      {
         super();
         _consBatPlayerData = param1;
         _equipType = param2;
      }
      
      public function load(param1:Function = null) : void
      {
         var _loc3_:int = 0;
         _callBack = param1;
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
         _loaders = new Vector.<ConsBattSceneCharacterLayer>();
         var _loc1_:int = 5361;
         if(_equipType == 1)
         {
            _loaders.push(new ConsBattSceneCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),1,_consBatPlayerData.sex,_consBatPlayerData.clothIndex,1));
            _loaders.push(new ConsBattSceneCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),3,_consBatPlayerData.sex,_consBatPlayerData.clothIndex,1));
         }
         else
         {
            _loaders.push(new ConsBattSceneCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),2,_consBatPlayerData.sex,_consBatPlayerData.clothIndex,1));
            _loaders.push(new ConsBattSceneCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),2,_consBatPlayerData.sex,_consBatPlayerData.clothIndex,2));
         }
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
         _consBatPlayerData = null;
         _callBack = null;
      }
   }
}
