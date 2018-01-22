package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.MenoryUtil;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public class BaseCharacterLoader implements ICharacterLoader
   {
       
      
      protected var _layers:Vector.<ILayer>;
      
      protected var _layerFactory:ILayerFactory;
      
      protected var _info:PlayerInfo;
      
      protected var _recordStyle:Array;
      
      protected var _recordColor:Array;
      
      protected var _content:BitmapData;
      
      private var _callBack:Function;
      
      private var _completeCount:int;
      
      protected var _wing:MovieClip;
      
      protected var _weapon:MovieClip;
      
      public function BaseCharacterLoader(param1:PlayerInfo)
      {
         _wing = new MovieClip();
         super();
         _info = param1;
      }
      
      protected function initLayers() : void
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
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[7].split("|")[0])),_info.Sex,_recordColor[7],"show"));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[1].split("|")[0])),_info.Sex,_recordColor[1],"show"));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[0].split("|")[0])),_info.Sex,_recordColor[0],"show"));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[3].split("|")[0])),_info.Sex,_recordColor[3],"show"));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_info.Sex,_recordColor[4],"show"));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[2].split("|")[0])),_info.Sex,_recordColor[2],"show",false,_info.getHairType()));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_info.Sex,_recordColor[5],"show"));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[6].split("|")[0])),_info.Sex,_recordColor[6],"show"));
         _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[8].split("|")[0])),_info.Sex,_recordColor[8],"show"));
      }
      
      protected function getIndexByTemplateId(param1:String) : int
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
                                                if("7" !== _loc3_)
                                                {
                                                   if("27" !== _loc3_)
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
      
      public final function load(param1:Function = null) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _callBack = param1;
         if(_layerFactory == null || _info == null || _info.Style == null)
         {
            loadComplete();
            return;
         }
         initLayers();
         var _loc3_:int = _layers.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _layers[_loc4_];
            _loc2_ && _loc2_.load(__layerComplete);
            _loc4_++;
         }
      }
      
      public function getUnCompleteLog() : String
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:String = "";
         if(_layers == null)
         {
            return "_layers == null\n";
         }
         var _loc3_:int = _layers.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _layers[_loc4_];
            if(_loc2_ && !_loc2_.isComplete)
            {
               _loc1_ = _loc1_ + ("unLoaded templete: " + _layers[_loc4_].info.TemplateID.toString() + "\n");
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function __layerComplete(param1:ILayer) : void
      {
         var _loc3_:int = 0;
         if(!_layers)
         {
            return;
         }
         var _loc2_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _layers.length)
         {
            if(_layers[_loc3_] && !_layers[_loc3_].isComplete)
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
      
      protected function loadComplete() : void
      {
         if(_callBack != null)
         {
            _callBack(this);
         }
      }
      
      protected function drawCharacter() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Number = _layers[1].width;
         var _loc3_:Number = _layers[1].height;
         if(_loc1_ == 0 || _loc3_ == 0)
         {
            return;
         }
         if(_content)
         {
            _content.dispose();
         }
         _content = new BitmapData(_loc1_,_loc3_,true,0);
         _loc2_ = _layers.length - 1;
         while(_loc2_ >= 0)
         {
            if(_info.getShowSuits())
            {
               if(!(_layers[_loc2_].info.CategoryID != 13 && _layers[_loc2_].info.CategoryID != 15 && _layers[_loc2_].info.CategoryID != 7))
               {
                  addr90:
                  if(_layers[_loc2_].info.CategoryID == 15)
                  {
                     _wing = _layers[_loc2_].getContent() as MovieClip;
                  }
                  else
                  {
                     _content.draw((_layers[_loc2_] as ILayer).getContent(),null,null,"normal");
                  }
               }
            }
            else if(_layers[_loc2_].info.CategoryID != 13)
            {
               §§goto(addr90);
            }
            _loc2_--;
         }
         MenoryUtil.clearMenory();
      }
      
      public function getContent() : Array
      {
         return [_content,_wing];
      }
      
      public function setFactory(param1:ILayerFactory) : void
      {
         _layerFactory = param1;
      }
      
      public function update() : void
      {
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc9_:* = false;
         var _loc10_:* = false;
         var _loc11_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         if(_info && _info.Style && _layers)
         {
            _loc7_ = _info.Style.split(",");
            _loc2_ = _info.Colors.split(",");
            _loc9_ = false;
            _loc10_ = false;
            _loc11_ = 0;
            while(_loc11_ < _loc7_.length)
            {
               if(_recordStyle != null)
               {
                  if(_loc11_ < _recordStyle.length)
                  {
                     _loc1_ = getIndexByTemplateId(_loc7_[_loc11_].split("|")[0]);
                     if(!(_loc1_ == -1 || _loc1_ == 9))
                     {
                        if(_recordStyle.indexOf(_loc7_[_loc11_]) == -1)
                        {
                           if(!_loc9_)
                           {
                              _loc9_ = _loc7_[_loc11_].charAt(0) == 1;
                           }
                           if(!_loc10_)
                           {
                              _loc10_ = _loc7_[_loc11_].charAt(0) == 3;
                           }
                           _loc5_ = ItemManager.Instance.getTemplateById(int(_loc7_[_loc11_].split("|")[0]));
                           _loc3_ = getCharacterLoader(_loc5_,_loc2_[_loc11_],_loc7_[_loc11_].split("|")[1]);
                           if(_layers[_loc1_])
                           {
                              _layers[_loc1_].dispose();
                           }
                           _layers[_loc1_] = _loc3_;
                           _loc3_.load(__layerComplete);
                        }
                        else if(_loc2_[_loc11_] != null)
                        {
                           if(_recordColor[_loc11_] != _loc2_[_loc11_])
                           {
                              _layers[_loc1_] && _layers[_loc1_].setColor(_loc2_[_loc11_]);
                           }
                        }
                     }
                     _loc11_++;
                     continue;
                  }
                  break;
               }
               break;
            }
            if(_info && _loc9_ && !_loc10_)
            {
               _loc8_ = ItemManager.Instance.getTemplateById(_info.getPartStyle(3));
               _loc6_ = getCharacterLoader(_loc8_,_info.getPartColor(3));
               _loc4_ = getIndexByTemplateId(String(_loc8_.TemplateID));
               if(_layers[_loc4_])
               {
                  _layers[_loc4_].dispose();
               }
               _layers[_loc4_] = _loc6_;
               _loc6_.load(__layerComplete);
            }
            __layerComplete(null);
            _recordStyle = _loc7_;
            _recordColor = _loc2_;
         }
      }
      
      protected function getCharacterLoader(param1:ItemTemplateInfo, param2:String = "", param3:String = null) : ILayer
      {
         param2 = !!EquipType.isEditable(param1)?param2:"";
         if(param1.CategoryID == 3)
         {
            return _layerFactory.createLayer(param1,_info.Sex,param2,"show",false,_info.getHairType(),param3);
         }
         return _layerFactory.createLayer(param1,_info.Sex,param2,"show",false,1,param3);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _content = null;
         _loc1_ = 0;
         while(_loc1_ < _layers.length)
         {
            _layers[_loc1_] && _layers[_loc1_].dispose();
            _loc1_++;
         }
         _wing = null;
         _weapon = null;
         _layers = null;
         _layerFactory = null;
         _info = null;
         _callBack = null;
      }
   }
}
