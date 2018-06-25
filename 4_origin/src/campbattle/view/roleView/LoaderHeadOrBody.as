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
      
      public function LoaderHeadOrBody(roleData:RoleData, equipType:int)
      {
         super();
         _consBatPlayerData = roleData;
         _equipType = equipType;
      }
      
      public function load(callBack:Function = null) : void
      {
         var i:int = 0;
         _callBack = callBack;
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
         _loaders = [];
         var tmpItemId:int = 5361;
         if(_equipType == 1)
         {
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(tmpItemId),0,_consBatPlayerData.Sex,_consBatPlayerData.team,1,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(tmpItemId),1,_consBatPlayerData.Sex,_consBatPlayerData.team,1,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
         }
         else if(_consBatPlayerData.MountsType == 140)
         {
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(tmpItemId),_equipType,_consBatPlayerData.Sex,_consBatPlayerData.team,0,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
         }
         else
         {
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(tmpItemId),_equipType,_consBatPlayerData.Sex,_consBatPlayerData.team,1,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
            _loaders.push(new CampBattleCharacterLayer(ItemManager.Instance.getTemplateById(tmpItemId),_equipType,_consBatPlayerData.Sex,_consBatPlayerData.team,2,_consBatPlayerData.baseURl,_consBatPlayerData.MountsType));
         }
      }
      
      private function drawCharacter() : void
      {
         var i:* = 0;
         var layer:* = undefined;
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
         _consBatPlayerData = null;
         _callBack = null;
      }
   }
}
