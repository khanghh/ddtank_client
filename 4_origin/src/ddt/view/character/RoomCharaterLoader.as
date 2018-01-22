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
      
      public function RoomCharaterLoader(param1:PlayerInfo)
      {
         super(param1);
      }
      
      override protected function initLayers() : void
      {
         if(_layers != null)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _layers;
            for each(var _loc1_ in _layers)
            {
               _loc1_.dispose();
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
      
      override protected function getIndexByTemplateId(param1:String) : int
      {
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(int(param1));
         if(_loc2_ == null)
         {
            return -1;
         }
         var _loc3_:* = _loc2_.CategoryID.toString();
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
                                                   addr54:
                                                   return 7;
                                                }
                                                §§goto(addr54);
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
               addr22:
               return 2;
            }
            addr21:
            §§goto(addr22);
         }
         §§goto(addr21);
      }
      
      private function loadPart(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_recordStyle[param1].split("|")[0] > 0)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(int(_recordStyle[param1].split("|")[0]));
            _loc2_ = !!EquipType.isEditable(_loc3_)?_recordColor[param1]:"";
            _layers.push(_layerFactory.createLayer(_loc3_,_info.Sex,_loc2_,"show",param1 == 2,_info.getHairType()));
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
         var _loc1_:Number = 250;
         var _loc2_:Number = 342;
         if(_loc1_ == 0 || _loc2_ == 0)
         {
            return;
         }
         if(_suit)
         {
            _suit.dispose();
         }
         _suit = new BitmapData(_loc1_ * 4,_loc2_,true,0);
         if(_faceUpBmd)
         {
            _faceUpBmd.dispose();
         }
         _faceUpBmd = new BitmapData(_loc1_,_loc2_,true,0);
         if(_faceBmd)
         {
            _faceBmd.dispose();
         }
         _faceBmd = new BitmapData(_loc1_ * 4,_loc2_,true,0);
         if(_hairBmd)
         {
            _hairBmd.dispose();
            _hairBmd = null;
         }
         if(_layers[5].getContent() && _layers[5].getContent().width > _loc1_)
         {
            _hairBmd = new BitmapData(_layers[5].getContent().width,_loc2_,true,0);
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
               _armBmd = new BitmapData(_layers[7].getContent().width,_loc2_,true,0);
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
