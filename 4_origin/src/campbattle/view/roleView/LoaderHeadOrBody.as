package campbattle.view.roleView
{
   import campbattle.data.RoleData;
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   
   public class LoaderHeadOrBody
   {
       
      
      private var _loaders:Array;
      
      private var _content:BitmapData;
      
      private var _completeCount:int;
      
      private var _isAllLoadSucceed:Boolean = true;
      
      private var _callBack:Function;
      
      private var _consBatPlayerData:RoleData;
      
      private var _equipType:int;
      
      private var _recordStyle:Array;
      
      private var _recordColor:Array;
      
      public function LoaderHeadOrBody(param1:RoleData, param2:int)
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
         _loaders = [];
         var _loc1_:int = 5361;
         if(_equipType == 1)
         {
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),0,_consBatPlayerData.Sex,_consBatPlayerData.team,1,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),1,_consBatPlayerData.Sex,_consBatPlayerData.team,1,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
         }
         else if(_consBatPlayerData.MountsType == 140)
         {
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),_equipType,_consBatPlayerData.Sex,_consBatPlayerData.team,0,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
         }
         else
         {
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),_equipType,_consBatPlayerData.Sex,_consBatPlayerData.team,1,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(_loc1_),_equipType,_consBatPlayerData.Sex,_consBatPlayerData.team,2,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
         }
      }
      
      private function drawCharacter() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = undefined;
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
