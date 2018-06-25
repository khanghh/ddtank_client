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
      
      public function GameCharacterLoader(info:PlayerInfo)
      {
         super(info);
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
         var arr:* = null;
         var i:int = 0;
         if(_layers != null)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _layers;
            for each(var layer in _layers)
            {
               layer.dispose();
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
            arr = STATES_ENUM;
            for(i = 0; i < arr.length; )
            {
               _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_info.Sex,_recordColor[5],"state",false,1,null,String(arr[i][0])));
               _layers.push(_layerFactory.createLayer(null,_info.Sex,"","specialEffect",false,1,null,String(arr[i][1])));
               i++;
            }
         }
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      override protected function getIndexByTemplateId(id:String) : int
      {
         var _loc2_:* = id.charAt(0);
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
         if(id.charAt(1) == "3")
         {
            return 0;
         }
         if(id.charAt(1) == "5")
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
         var picWidth:Number = _layers[1].width;
         var picHeight:Number = _layers[1].height;
         if(picWidth == 0 || picHeight == 0)
         {
            return;
         }
         if(_normalSuit)
         {
            _normalSuit.dispose();
         }
         _normalSuit = new BitmapData(picWidth,picHeight,true,0);
         if(_lackHpSuit)
         {
            _lackHpSuit.dispose();
         }
         _lackHpSuit = new BitmapData(picWidth,picHeight,true,0);
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
         var i:int = 0;
         var j:int = 0;
         var spf:* = null;
         var sp:* = null;
         var picWidth:Number = _layers[1].width;
         var picHeight:Number = _layers[1].height;
         if(picWidth == 0 || picHeight == 0)
         {
            return;
         }
         if(_face)
         {
            _face.dispose();
         }
         _face = new BitmapData(picWidth,picHeight,true,0);
         if(_faceup)
         {
            _faceup.dispose();
         }
         _faceup = new BitmapData(picWidth,picHeight,true,0);
         if(_sp)
         {
            var _loc12_:int = 0;
            var _loc11_:* = _sp;
            for each(var bmd in _sp)
            {
               bmd.dispose();
            }
         }
         _sp = new Vector.<BitmapData>();
         if(_lackHpFace)
         {
            var _loc14_:int = 0;
            var _loc13_:* = _lackHpFace;
            for each(var bmd1 in _lackHpFace)
            {
               bmd1.dispose();
            }
         }
         _lackHpFace = new Vector.<BitmapData>();
         if(_faceDown)
         {
            _faceDown.dispose();
         }
         _faceDown = new BitmapData(picWidth,picHeight,true,0);
         for(i = 7; i >= 0; )
         {
            if(_layers[i].info.CategoryID == 15)
            {
               _wing = _layers[i].getContent() as MovieClip;
            }
            else if(i == 5)
            {
               _face.draw((_layers[i] as ILayer).getContent(),null,null,"normal");
            }
            else if(i == 6)
            {
               if(EquipType.isDynamicWeapon(_info.WeaponID))
               {
                  _weapon = (_layers[i] as ILayer).getContent() as MovieClip;
               }
               else
               {
                  _faceDown.draw((_layers[i] as ILayer).getContent(),null,null,"normal");
               }
            }
            else if(i < 5)
            {
               _faceup.draw((_layers[i] as ILayer).getContent(),null,null,"normal");
            }
            i--;
         }
         var picWidth1:Number = _layers[8].width;
         var picHeight1:Number = _layers[8].height;
         picWidth1 = picWidth1 == 0?50:Number(picWidth1);
         picHeight1 = picHeight1 == 0?50:Number(picHeight1);
         for(j = 8; j < _layers.length; )
         {
            spf = new BitmapData(picWidth1,picHeight1,true,0);
            sp = new BitmapData(picWidth1,picHeight1,true,0);
            spf.draw((_layers[j] as ILayer).getContent(),null,null,"normal");
            sp.draw((_layers[j + 1] as ILayer).getContent(),null,null,"normal");
            _lackHpFace.push(spf);
            _sp.push(sp);
            j = j + 2;
         }
      }
      
      override public function getContent() : Array
      {
         return [_wing,_sp,_faceup,_face,_lackHpFace,_faceDown,_normalSuit,_lackHpSuit,_weapon];
      }
      
      override protected function getCharacterLoader(value:ItemTemplateInfo, color:String = "", pic:String = null) : ILayer
      {
         if(value.CategoryID == 3)
         {
            return _layerFactory.createLayer(value,_info.Sex,color,"game",false,_info.getHairType(),pic);
         }
         return _layerFactory.createLayer(value,_info.Sex,color,"game",false,1,pic);
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
