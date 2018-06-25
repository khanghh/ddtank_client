package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public class RoomCharaterLoader extends BaseCharacterLoader
   {
       
      
      private var _suit:BitmapData;
      
      private var _faceUpBmd:BitmapData;
      
      private var _faceBmd:BitmapData;
      
      private var _hairBmd:BitmapData;
      
      private var _armBmd:BitmapData;
      
      public var showWeapon:Boolean;
      
      public function RoomCharaterLoader(info:PlayerInfo)
      {
         super(info);
      }
      
      override protected function initLayers() : void
      {
         if(_layers != null)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _layers;
            for each(var layer in _layers)
            {
               layer.dispose();
            }
            _layers = null;
         }
         _layers = new Vector.<ILayer>();
         _recordStyle = _info.Style.split(",");
         _recordColor = _info.Colors.split(",");
         loadPart(7);
         loadPart(1);
         loadPart(0);
         loadPart(3);
         loadPart(4);
         loadPart(2);
         loadPart(5);
         laodArm();
         loadPart(8);
      }
      
      override protected function getIndexByTemplateId(id:String) : int
      {
         var item:ItemTemplateInfo = ItemManager.Instance.getTemplateById(int(id));
         if(item == null)
         {
            return -1;
         }
         var _loc3_:* = item.CategoryID.toString();
         if("1" !== _loc3_)
         {
            if("10" !== _loc3_)
            {
               if("11" !== _loc3_)
               {
                  if("12" !== _loc3_)
                  {
                     if("13" !== _loc3_)
                     {
                        if("15" !== _loc3_)
                        {
                           if("16" !== _loc3_)
                           {
                              if("17" !== _loc3_)
                              {
                                 if("2" !== _loc3_)
                                 {
                                    if("3" !== _loc3_)
                                    {
                                       if("4" !== _loc3_)
                                       {
                                          if("5" !== _loc3_)
                                          {
                                             if("6" !== _loc3_)
                                             {
                                                if("27" !== _loc3_)
                                                {
                                                   if("7" !== _loc3_)
                                                   {
                                                      if("64" !== _loc3_)
                                                      {
                                                         return -1;
                                                      }
                                                   }
                                                   addr71:
                                                   return 7;
                                                }
                                                §§goto(addr71);
                                             }
                                             else
                                             {
                                                return 6;
                                             }
                                          }
                                          else
                                          {
                                             return 4;
                                          }
                                       }
                                       else
                                       {
                                          return 3;
                                       }
                                    }
                                    else
                                    {
                                       return 5;
                                    }
                                 }
                                 else
                                 {
                                    return 1;
                                 }
                              }
                              else
                              {
                                 return -1;
                              }
                           }
                           else
                           {
                              return 9;
                           }
                        }
                        else
                        {
                           return 8;
                        }
                     }
                     else
                     {
                        return 0;
                     }
                  }
               }
               addr29:
               return 2;
            }
            addr28:
            §§goto(addr29);
         }
         §§goto(addr28);
      }
      
      private function loadPart(index:int) : void
      {
         var item:* = null;
         var color:* = null;
         if(_recordStyle[index].split("|")[0] > 0)
         {
            item = ItemManager.Instance.getTemplateById(int(_recordStyle[index].split("|")[0]));
            color = !!EquipType.isEditable(item)?_recordColor[index]:"";
            _layers.push(_layerFactory.createLayer(item,_info.Sex,color,"show",index == 2,_info.getHairType()));
         }
      }
      
      private function laodArm() : void
      {
         if(_recordStyle[6].split("|")[0] > 0)
         {
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[6].split("|")[0])),_info.Sex,_recordColor[6],"show",false,_info.getHairType(),_recordStyle[6].split("|")[1]));
         }
      }
      
      override protected function drawCharacter() : void
      {
         var picWidth:Number = 250;
         var picHeight:Number = 342;
         if(picWidth == 0 || picHeight == 0)
         {
            return;
         }
         if(_suit)
         {
            _suit.dispose();
         }
         _suit = new BitmapData(picWidth * 4,picHeight,true,0);
         if(_faceUpBmd)
         {
            _faceUpBmd.dispose();
         }
         _faceUpBmd = new BitmapData(picWidth,picHeight,true,0);
         if(_faceBmd)
         {
            _faceBmd.dispose();
         }
         _faceBmd = new BitmapData(picWidth * 4,picHeight,true,0);
         if(_hairBmd)
         {
            _hairBmd.dispose();
            _hairBmd = null;
         }
         if(_layers[5].getContent() && _layers[5].getContent().width > picWidth)
         {
            _hairBmd = new BitmapData(_layers[5].getContent().width,picHeight,true,0);
         }
         if(_armBmd)
         {
            _armBmd.dispose();
            _armBmd = null;
         }
         if(_info.WeaponID != 0 && _info.WeaponID != -1 && _info.WeaponID != 70016 && showWeapon)
         {
            if(_layers[7].getContent())
            {
               _armBmd = new BitmapData(_layers[7].getContent().width,picHeight,true,0);
               _armBmd.draw(_layers[7].getContent(),null,null,"normal");
            }
         }
         if(_info.getShowSuits())
         {
            _suit.draw(_layers[0].getContent(),null,null,"normal");
         }
         else
         {
            if(_hairBmd)
            {
               _hairBmd.draw(_layers[5].getContent(),null,null,"normal");
            }
            else
            {
               _faceUpBmd.draw(_layers[5].getContent(),null,null,"normal");
            }
            _faceUpBmd.draw(_layers[4].getContent(),null,null,"normal");
            _faceUpBmd.draw(_layers[3].getContent(),null,null,"normal");
            _faceUpBmd.draw(_layers[2].getContent(),null,null,"normal");
            _faceUpBmd.draw(_layers[1].getContent(),null,null,"normal");
            _faceBmd.draw(_layers[6].getContent(),null,null,"normal");
         }
         _wing = _layers[8].getContent() as MovieClip;
      }
      
      override public function getContent() : Array
      {
         return [_suit,_faceUpBmd,_faceBmd,_wing,_hairBmd,_armBmd];
      }
   }
}
