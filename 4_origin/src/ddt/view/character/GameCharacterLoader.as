package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import room.RoomManager;
   
   public class GameCharacterLoader extends BaseCharacterLoader
   {
      
      public static var MALE_STATES:Array = [[1,1],[2,2],[3,3],[4,4],[5,5],[7,7],[8,8],[11,9]];
      
      public static var FEMALE_STATES:Array = [[1,1],[2,2],[3,3],[4,4],[5,5],[7,6],[9,8],[11,9]];
       
      
      private var _sp:Vector.<BitmapData>;
      
      private var _faceup:BitmapData;
      
      private var _face:BitmapData;
      
      private var _lackHpFace:Vector.<BitmapData>;
      
      private var _faceDown:BitmapData;
      
      private var _normalSuit:BitmapData;
      
      private var _lackHpSuit:BitmapData;
      
      public var specialType:int = -1;
      
      public var stateType:int = -1;
      
      public function GameCharacterLoader(param1:PlayerInfo)
      {
         super(param1);
      }
      
      public function get STATES_ENUM() : Array
      {
         if(_info.Sex)
         {
            return MALE_STATES;
         }
         return FEMALE_STATES;
      }
      
      override protected function initLayers() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         if(_layers != null)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _layers;
            for each(var _loc2_ in _layers)
            {
               _loc2_.dispose();
            }
            _layers = null;
         }
         _layers = new Vector.<ILayer>();
         _recordStyle = _info.Style.split(",");
         _recordColor = _info.Colors.split(",");
         if(_info.getShowSuits())
         {
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[7].split("|")[0])),_info.Sex,"","game"));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[7].split("|")[0])),_info.Sex,"","game",false,1,null,"1"));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[6].split("|")[0])),_info.Sex,_recordColor[6],"game",true,1,_recordStyle[6].split("|")[1]));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[8].split("|")[0])),_info.Sex,"","game"));
         }
         else
         {
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[1].split("|")[0])),_info.Sex,_recordColor[1],"game"));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[0].split("|")[0])),_info.Sex,_recordColor[0],"game"));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[3].split("|")[0])),_info.Sex,_recordColor[3],"game"));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_info.Sex,_recordColor[4],"game"));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[2].split("|")[0])),_info.Sex,_recordColor[2],"game",false,_info.getHairType()));
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_info.Sex,_recordColor[5],"game"));
            if(RoomManager.Instance.current.type != 29 && (_info.WeaponID <= 0 || _info.WeaponID == 70016))
            {
               _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(70016),_info.Sex,_recordColor[6],"game",true,1));
            }
            else
            {
               _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[6].split("|")[0])),_info.Sex,_recordColor[6],"game",true,1,_recordStyle[6].split("|")[1]));
            }
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[8].split("|")[0])),_info.Sex,"","game"));
            _loc1_ = STATES_ENUM;
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_info.Sex,_recordColor[5],"state",false,1,null,String(_loc1_[_loc3_][0])));
               _layers.push(_layerFactory.createLayer(null,_info.Sex,"","specialEffect",false,1,null,String(_loc1_[_loc3_][1])));
               _loc3_++;
            }
         }
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      override protected function getIndexByTemplateId(param1:String) : int
      {
         var _loc2_:* = param1.charAt(0);
         if("1" !== _loc2_)
         {
            if("2" !== _loc2_)
            {
               if("3" !== _loc2_)
               {
                  if("4" !== _loc2_)
                  {
                     if("5" !== _loc2_)
                     {
                        if("6" !== _loc2_)
                        {
                           if("7" !== _loc2_)
                           {
                              return -1;
                           }
                           return 7;
                        }
                        return 5;
                     }
                     return 3;
                  }
                  return 2;
               }
               return 4;
            }
            return 0;
         }
         if(param1.charAt(1) == "3")
         {
            return 0;
         }
         if(param1.charAt(1) == "5")
         {
            return 8;
         }
         return 1;
      }
      
      override protected function drawCharacter() : void
      {
         if(_info.getShowSuits())
         {
            drawSuits();
         }
         else
         {
            drawNormal();
         }
      }
      
      private function drawSuits() : void
      {
         var _loc1_:Number = _layers[1].width;
         var _loc2_:Number = _layers[1].height;
         if(_loc1_ == 0 || _loc2_ == 0)
         {
            return;
         }
         if(_normalSuit)
         {
            _normalSuit.dispose();
         }
         _normalSuit = new BitmapData(_loc1_,_loc2_,true,0);
         if(_lackHpSuit)
         {
            _lackHpSuit.dispose();
         }
         _lackHpSuit = new BitmapData(_loc1_,_loc2_,true,0);
         if(EquipType.isDynamicWeapon(_info.WeaponID))
         {
            _weapon = _layers[2].getContent() as MovieClip;
         }
         else
         {
            _normalSuit.draw((_layers[2] as ILayer).getContent(),null,null,"normal");
            _lackHpSuit.draw((_layers[2] as ILayer).getContent(),null,null,"normal");
         }
         _normalSuit.draw((_layers[0] as ILayer).getContent(),null,null,"normal");
         _lackHpSuit.draw((_layers[1] as ILayer).getContent(),null,null,"normal");
         _wing = _layers[3].getContent() as MovieClip;
      }
      
      private function drawNormal() : void
      {
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc1_:Number = _layers[1].width;
         var _loc10_:Number = _layers[1].height;
         if(_loc1_ == 0 || _loc10_ == 0)
         {
            return;
         }
         if(_face)
         {
            _face.dispose();
         }
         _face = new BitmapData(_loc1_,_loc10_,true,0);
         if(_faceup)
         {
            _faceup.dispose();
         }
         _faceup = new BitmapData(_loc1_,_loc10_,true,0);
         if(_sp)
         {
            var _loc12_:int = 0;
            var _loc11_:* = _sp;
            for each(var _loc3_ in _sp)
            {
               _loc3_.dispose();
            }
         }
         _sp = new Vector.<BitmapData>();
         if(_lackHpFace)
         {
            var _loc14_:int = 0;
            var _loc13_:* = _lackHpFace;
            for each(var _loc8_ in _lackHpFace)
            {
               _loc8_.dispose();
            }
         }
         _lackHpFace = new Vector.<BitmapData>();
         if(_faceDown)
         {
            _faceDown.dispose();
         }
         _faceDown = new BitmapData(_loc1_,_loc10_,true,0);
         _loc9_ = 7;
         while(_loc9_ >= 0)
         {
            if(_layers[_loc9_].info.CategoryID == 15)
            {
               _wing = _layers[_loc9_].getContent() as MovieClip;
            }
            else if(_loc9_ == 5)
            {
               _face.draw((_layers[_loc9_] as ILayer).getContent(),null,null,"normal");
            }
            else if(_loc9_ == 6)
            {
               if(EquipType.isDynamicWeapon(_info.WeaponID))
               {
                  _weapon = (_layers[_loc9_] as ILayer).getContent() as MovieClip;
               }
               else
               {
                  _faceDown.draw((_layers[_loc9_] as ILayer).getContent(),null,null,"normal");
               }
            }
            else if(_loc9_ < 5)
            {
               _faceup.draw((_layers[_loc9_] as ILayer).getContent(),null,null,"normal");
            }
            _loc9_--;
         }
         var _loc6_:Number = _layers[8].width;
         var _loc5_:Number = _layers[8].height;
         _loc6_ = _loc6_ == 0?50:Number(_loc6_);
         _loc5_ = _loc5_ == 0?50:Number(_loc5_);
         _loc7_ = 8;
         while(_loc7_ < _layers.length)
         {
            _loc2_ = new BitmapData(_loc6_,_loc5_,true,0);
            _loc4_ = new BitmapData(_loc6_,_loc5_,true,0);
            _loc2_.draw((_layers[_loc7_] as ILayer).getContent(),null,null,"normal");
            _loc4_.draw((_layers[_loc7_ + 1] as ILayer).getContent(),null,null,"normal");
            _lackHpFace.push(_loc2_);
            _sp.push(_loc4_);
            _loc7_ = _loc7_ + 2;
         }
      }
      
      override public function getContent() : Array
      {
         return [_wing,_sp,_faceup,_face,_lackHpFace,_faceDown,_normalSuit,_lackHpSuit,_weapon];
      }
      
      override protected function getCharacterLoader(param1:ItemTemplateInfo, param2:String = "", param3:String = null) : ILayer
      {
         if(param1.CategoryID == 3)
         {
            return _layerFactory.createLayer(param1,_info.Sex,param2,"game",false,_info.getHairType(),param3);
         }
         return _layerFactory.createLayer(param1,_info.Sex,param2,"game",false,1,param3);
      }
      
      override public function dispose() : void
      {
         _sp = null;
         _faceup = null;
         _face = null;
         _lackHpFace = null;
         _faceDown = null;
         _normalSuit = null;
         _lackHpSuit = null;
         super.dispose();
      }
   }
}
