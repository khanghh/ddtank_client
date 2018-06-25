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
      
      public function BaseCharacterLoader(info:PlayerInfo)
      {
         _wing = new MovieClip();
         super();
         _info = info;
      }
      
      protected function initLayers() : void
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
      
      protected function getIndexByTemplateId(id:String) : int
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
                                                if("7" !== _loc3_)
                                                {
                                                   if("27" !== _loc3_)
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
      
      public final function load(callBack:Function = null) : void
      {
         var i:int = 0;
         var t:* = null;
         _callBack = callBack;
         if(_layerFactory == null || _info == null || _info.Style == null)
         {
            loadComplete();
            return;
         }
         initLayers();
         var layerCount:int = _layers.length;
         for(i = 0; i < layerCount; )
         {
            t = _layers[i];
            t && t.load(__layerComplete);
            i++;
         }
      }
      
      public function getUnCompleteLog() : String
      {
         var i:int = 0;
         var t:* = null;
         var result:String = "";
         if(_layers == null)
         {
            return "_layers == null\n";
         }
         var layerCount:int = _layers.length;
         for(i = 0; i < layerCount; )
         {
            t = _layers[i];
            if(t && !t.isComplete)
            {
               result = result + ("unLoaded templete: " + _layers[i].info.TemplateID.toString() + "\n");
            }
            i++;
         }
         return result;
      }
      
      private function __layerComplete(layer:ILayer) : void
      {
         var i:int = 0;
         if(!_layers)
         {
            return;
         }
         var isAllLayerComplete:Boolean = true;
         for(i = 0; i < _layers.length; )
         {
            if(_layers[i] && !_layers[i].isComplete)
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
      
      protected function loadComplete() : void
      {
         if(_callBack != null)
         {
            _callBack(this);
         }
      }
      
      protected function drawCharacter() : void
      {
         var i:int = 0;
         var picWidth:Number = _layers[1].width;
         var picHeight:Number = _layers[1].height;
         if(picWidth == 0 || picHeight == 0)
         {
            return;
         }
         if(_content)
         {
            _content.dispose();
         }
         _content = new BitmapData(picWidth,picHeight,true,0);
         for(i = _layers.length - 1; i >= 0; )
         {
            if(_info.getShowSuits())
            {
               if(!(_layers[i].info.CategoryID != 13 && _layers[i].info.CategoryID != 15 && _layers[i].info.CategoryID != 7))
               {
                  addr105:
                  if(_layers[i].info.CategoryID == 15)
                  {
                     _wing = _layers[i].getContent() as MovieClip;
                  }
                  else
                  {
                     _content.draw((_layers[i] as ILayer).getContent(),null,null,"normal");
                  }
               }
            }
            else if(_layers[i].info.CategoryID != 13)
            {
               §§goto(addr105);
            }
            i--;
         }
         MenoryUtil.clearMenory();
      }
      
      public function getContent() : Array
      {
         return [_content,_wing];
      }
      
      public function setFactory(factory:ILayerFactory) : void
      {
         _layerFactory = factory;
      }
      
      public function update() : void
      {
         var st:* = null;
         var co:* = null;
         var shouldchangehair:* = false;
         var hadchangehair:* = false;
         var i:int = 0;
         var index:int = 0;
         var item:* = null;
         var t:* = null;
         var hair:* = null;
         var l:* = null;
         var index1:int = 0;
         if(_info && _info.Style && _layers)
         {
            st = _info.Style.split(",");
            co = _info.Colors.split(",");
            shouldchangehair = false;
            hadchangehair = false;
            for(i = 0; i < st.length; )
            {
               if(_recordStyle != null)
               {
                  if(i < _recordStyle.length)
                  {
                     index = getIndexByTemplateId(st[i].split("|")[0]);
                     if(!(index == -1 || index == 9))
                     {
                        if(_recordStyle.indexOf(st[i]) == -1)
                        {
                           if(!shouldchangehair)
                           {
                              shouldchangehair = st[i].charAt(0) == 1;
                           }
                           if(!hadchangehair)
                           {
                              hadchangehair = st[i].charAt(0) == 3;
                           }
                           item = ItemManager.Instance.getTemplateById(int(st[i].split("|")[0]));
                           t = getCharacterLoader(item,co[i],st[i].split("|")[1]);
                           if(_layers[index])
                           {
                              _layers[index].dispose();
                           }
                           _layers[index] = t;
                           t.load(__layerComplete);
                        }
                        else if(co[i] != null)
                        {
                           if(_recordColor[i] != co[i])
                           {
                              _layers[index] && _layers[index].setColor(co[i]);
                           }
                        }
                     }
                     i++;
                     continue;
                  }
                  break;
               }
               break;
            }
            if(_info && shouldchangehair && !hadchangehair)
            {
               hair = ItemManager.Instance.getTemplateById(_info.getPartStyle(3));
               l = getCharacterLoader(hair,_info.getPartColor(3));
               index1 = getIndexByTemplateId(String(hair.TemplateID));
               if(_layers[index1])
               {
                  _layers[index1].dispose();
               }
               _layers[index1] = l;
               l.load(__layerComplete);
            }
            __layerComplete(null);
            _recordStyle = st;
            _recordColor = co;
         }
      }
      
      protected function getCharacterLoader(value:ItemTemplateInfo, color:String = "", pic:String = null) : ILayer
      {
         color = !!EquipType.isEditable(value)?color:"";
         if(value.CategoryID == 3)
         {
            return _layerFactory.createLayer(value,_info.Sex,color,"show",false,_info.getHairType(),pic);
         }
         return _layerFactory.createLayer(value,_info.Sex,color,"show",false,1,pic);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         _content = null;
         for(i = 0; i < _layers.length; )
         {
            _layers[i] && _layers[i].dispose();
            i++;
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
