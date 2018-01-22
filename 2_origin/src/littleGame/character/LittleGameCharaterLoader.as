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
      
      public function LittleGameCharaterLoader(param1:PlayerInfo, param2:int = 1)
      {
         super();
         _playerInfo = param1;
         _loaders = new Vector.<LittleGameCharacterLayer>();
         _recordStyle = _playerInfo.Style.split(",");
         _recordColor = _playerInfo.Colors.split(",");
         hasFaceColor = Boolean(_recordColor[5]);
         hasClothColor = Boolean(_recordColor[4]);
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],_playerInfo.Sex,param2));
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,param2));
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[2].split("|")[0])),_recordColor[2],_playerInfo.Sex,param2));
         _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[3].split("|")[0])),_recordColor[3],_playerInfo.Sex,param2));
         if(effect == null)
         {
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,param2,30,1));
         }
         if(specialHeads == null || hasFaceColor)
         {
            specialHeads = new Vector.<BitmapData>();
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,param2,6,1));
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,param2,6,2));
            _loaders.push(new LittleGameCharacterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5],_playerInfo.Sex,param2,6,3));
         }
      }
      
      public function load(param1:Function) : void
      {
         var _loc2_:int = 0;
         _callBack = param1;
         _loc2_ = 0;
         while(_loc2_ < _loaders.length)
         {
            _loaders[_loc2_].load(onComplete);
            _loc2_++;
         }
      }
      
      private function onComplete(param1:ILayer) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = true;
         _loc4_ = 0;
         while(_loc4_ < _loaders.length)
         {
            if(!_loaders[_loc4_].isComplete)
            {
               _loc3_ = false;
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            _loc2_ = getTimer();
            drawCharacter();
            trace("============drawcharacter",getTimer() - _loc2_);
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
      
      private function drawHeadByFace(param1:int) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(_loaders[param1].width,_loaders[param1].height,true,0);
         var _loc2_:LittleGameCharacterLayer = _loaders[param1];
         _loc3_.draw(_loc2_.getContent(),null,null,"normal");
         _loc2_ = _loaders[2];
         _loc3_.draw(_loc2_.getContent(),null,null,"normal");
         _loc2_ = _loaders[3];
         _loc3_.draw(_loc2_.getContent(),null,null,"normal");
         return _loc3_;
      }
      
      public function getContent() : Vector.<BitmapData>
      {
         var _loc1_:Vector.<BitmapData> = new Vector.<BitmapData>();
         _loc1_.push(_head);
         _loc1_.push(_body);
         _loc1_.push(effect);
         if(hasFaceColor)
         {
            _loc1_.push(drawHeadByFace(_loaders.length - 3));
            _loc1_.push(drawHeadByFace(_loaders.length - 2));
            _loc1_.push(drawHeadByFace(_loaders.length - 1));
         }
         else
         {
            _loc1_.push(specialHeads[0]);
            _loc1_.push(specialHeads[1]);
            _loc1_.push(specialHeads[2]);
         }
         return _loc1_;
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
         for each(var _loc1_ in _loaders)
         {
            _loc1_.dispose();
         }
         _loaders == null;
         _head = null;
         _body = null;
         _playerInfo = null;
      }
   }
}
