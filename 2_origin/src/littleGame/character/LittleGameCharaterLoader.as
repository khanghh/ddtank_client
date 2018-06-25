package littleGame.character
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class LittleGameCharaterLoader
   {
      
      private static const HAIR_LAYER:int = 2;
      
      private static const EAR_LAYER:int = 3;
      
      private static var boyCloth:BitmapData;
      
      private static var girlCloth:BitmapData;
      
      private static var effect:BitmapData;
      
      private static var specialHeads:Vector.<BitmapData>;
       
      
      private var _playerInfo:PlayerInfo;
      
      private var _loaders:Vector.<LittleGameCharacterLayer>;
      
      private var _recordStyle:Array;
      
      private var _recordColor:Array;
      
      private var _head:BitmapData;
      
      private var _body:BitmapData;
      
      private var hasClothColor:Boolean = false;
      
      private var hasFaceColor:Boolean = false;
      
      private var _callBack:Function;
      
      public function LittleGameCharaterLoader(info:PlayerInfo, littleGameId:int = 1)
      {
         super();
         _playerInfo = info;
         _loaders = new Vector.<LittleGameCharacterLayer>();
         _recordStyle = _playerInfo.Style.split(",");
         _recordColor = _playerInfo.Colors.split(",");
         hasFaceColor = Boolean(_recordColor[5]);
         hasClothColor = Boolean(_recordColor[4]);
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],_playerInfo.Sex,littleGameId));
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,littleGameId));
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[2].split("|")[0])),_recordColor[2],_playerInfo.Sex,littleGameId));
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[3].split("|")[0])),_recordColor[3],_playerInfo.Sex,littleGameId));
         if(effect == null)
         {
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,littleGameId,30,1));
         }
         if(specialHeads == null || hasFaceColor)
         {
            specialHeads = new Vector.<BitmapData>();
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,littleGameId,6,1));
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,littleGameId,6,2));
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,littleGameId,6,3));
         }
      }
      
      public function load(callBack:Function) : void
      {
         var i:int = 0;
         _callBack = callBack;
         for(i = 0; i < _loaders.length; )
         {
            _loaders[i].load(onComplete);
            i++;
         }
      }
      
      private function onComplete(layer:ILayer) : void
      {
         var i:int = 0;
         var t:Number = NaN;
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
            t = getTimer();
            drawCharacter();
            trace("============drawcharacter",getTimer() - t);
            loadComplete();
         }
      }
      
      private function drawCharacter() : void
      {
         _head = drawHeadByFace(1);
         if(_playerInfo.Sex)
         {
            if(boyCloth)
            {
               if(!hasClothColor)
               {
                  _body = boyCloth;
               }
               else
               {
                  _body = new BitmapData(_loaders[0].width,_loaders[0].height,true,0);
                  _body.draw(_loaders[0],null,null,"normal");
               }
            }
            else
            {
               _body = new BitmapData(_loaders[0].width,_loaders[0].height,true,0);
               _body.draw(_loaders[0],null,null,"normal");
               if(!hasClothColor)
               {
                  boyCloth = _body;
               }
            }
         }
         else if(girlCloth)
         {
            if(!hasClothColor)
            {
               _body = girlCloth;
            }
            else
            {
               _body = new BitmapData(_loaders[0].width,_loaders[0].height,true,0);
               _body.draw(_loaders[0],null,null,"normal");
            }
         }
         else
         {
            _body = new BitmapData(_loaders[0].width,_loaders[0].height,true,0);
            _body.draw(_loaders[0],null,null,"normal");
            if(!hasClothColor)
            {
               girlCloth = _body;
            }
         }
         if(effect == null)
         {
            effect = new BitmapData(_loaders[4].width,_loaders[4].height,true,0);
            effect.draw(_loaders[4],null,null,"normal");
         }
         if(specialHeads.length == 0)
         {
            if(!hasFaceColor)
            {
               specialHeads.push(drawHeadByFace(_loaders.length - 3));
               specialHeads.push(drawHeadByFace(_loaders.length - 2));
               specialHeads.push(drawHeadByFace(_loaders.length - 1));
            }
         }
      }
      
      private function drawHeadByFace(faceLayer:int) : BitmapData
      {
         var head:BitmapData = new BitmapData(_loaders[faceLayer].width,_loaders[faceLayer].height,true,0);
         var layer:LittleGameCharacterLayer = _loaders[faceLayer];
         head.draw(layer.getContent(),null,null,"normal");
         layer = _loaders[2];
         head.draw(layer.getContent(),null,null,"normal");
         layer = _loaders[3];
         head.draw(layer.getContent(),null,null,"normal");
         return head;
      }
      
      public function getContent() : Vector.<BitmapData>
      {
         var result:Vector.<BitmapData> = new Vector.<BitmapData>();
         result.push(_head);
         result.push(_body);
         result.push(effect);
         if(hasFaceColor)
         {
            result.push(drawHeadByFace(_loaders.length - 3));
            result.push(drawHeadByFace(_loaders.length - 2));
            result.push(drawHeadByFace(_loaders.length - 1));
         }
         else
         {
            result.push(specialHeads[0]);
            result.push(specialHeads[1]);
            result.push(specialHeads[2]);
         }
         return result;
      }
      
      private function loadComplete() : void
      {
         if(_callBack != null)
         {
            _callBack();
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _loaders;
         for each(var layer in _loaders)
         {
            layer.dispose();
         }
         _loaders == null;
         _head = null;
         _body = null;
         _playerInfo = null;
      }
   }
}
