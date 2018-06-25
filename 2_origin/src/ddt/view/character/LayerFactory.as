package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   
   public class LayerFactory implements ILayerFactory
   {
      
      public static const ICON:String = "icon";
      
      public static const SHOW:String = "show";
      
      public static const GAME:String = "game";
      
      public static const STATE:String = "state";
      
      public static const ROOM:String = "room";
      
      public static const SPECIAL_EFFECT:String = "specialEffect";
      
      public static const MOVIE_CLIP_EFFECT:String = "movie_clip_effect";
      
      private static var _instance:ILayerFactory;
       
      
      public function LayerFactory()
      {
         super();
      }
      
      public static function get instance() : ILayerFactory
      {
         if(_instance == null)
         {
            _instance = new LayerFactory();
         }
         return _instance;
      }
      
      public function createLayer(info:ItemTemplateInfo, sex:Boolean, color:String = "", type:String = "show", gunBack:Boolean = false, hairType:int = 1, pic:String = null, stateType:String = "") : ILayer
      {
         var _layer:* = null;
         var _loc10_:* = type;
         if("icon" !== _loc10_)
         {
            if("show" !== _loc10_)
            {
               if("game" !== _loc10_)
               {
                  if("state" !== _loc10_)
                  {
                     if("specialEffect" !== _loc10_)
                     {
                        if("room" !== _loc10_)
                        {
                           if("movie_clip_effect" === _loc10_)
                           {
                              _layer = new CellMovieClipSpecialEffectLayer(int(info.Property1));
                           }
                        }
                        else
                        {
                           _layer = new RoomLayer(info,"",false,1,null,int(stateType));
                        }
                     }
                     else
                     {
                        _layer = new SpecialEffectsLayer(int(stateType));
                     }
                  }
                  else
                  {
                     _layer = new StateLayer(info,sex,color,int(stateType));
                  }
               }
               else if(info)
               {
                  if(info.CategoryID == 15)
                  {
                     _layer = new BaseWingLayer(info,1);
                  }
                  else if(EquipType.isDynamicWeapon(info.TemplateID))
                  {
                     _layer = new DynamicWeaponLayer(info,color,gunBack,hairType,pic);
                  }
                  else
                  {
                     _layer = new GameLayer(info,color,gunBack,hairType,pic,stateType);
                  }
               }
            }
            else if(info)
            {
               if(info.CategoryID == 15)
               {
                  _layer = new BaseWingLayer(info);
               }
               else
               {
                  _layer = new ShowLayer(info,color,gunBack,hairType,pic);
               }
            }
         }
         else
         {
            _layer = new IconLayer(info,color,gunBack,hairType);
         }
         return _layer;
      }
   }
}
