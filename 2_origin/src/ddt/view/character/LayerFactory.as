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
      
      public function createLayer(param1:ItemTemplateInfo, param2:Boolean, param3:String = "", param4:String = "show", param5:Boolean = false, param6:int = 1, param7:String = null, param8:String = "") : ILayer
      {
         var _loc9_:* = null;
         var _loc10_:* = param4;
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
                              _loc9_ = new CellMovieClipSpecialEffectLayer(int(param1.Property1));
                           }
                        }
                        else
                        {
                           _loc9_ = new RoomLayer(param1,"",false,1,null,int(param8));
                        }
                     }
                     else
                     {
                        _loc9_ = new SpecialEffectsLayer(int(param8));
                     }
                  }
                  else
                  {
                     _loc9_ = new StateLayer(param1,param2,param3,int(param8));
                  }
               }
               else if(param1)
               {
                  if(param1.CategoryID == 15)
                  {
                     _loc9_ = new BaseWingLayer(param1,1);
                  }
                  else if(EquipType.isDynamicWeapon(param1.TemplateID))
                  {
                     _loc9_ = new DynamicWeaponLayer(param1,param3,param5,param6,param7);
                  }
                  else
                  {
                     _loc9_ = new GameLayer(param1,param3,param5,param6,param7,param8);
                  }
               }
            }
            else if(param1)
            {
               if(param1.CategoryID == 15)
               {
                  _loc9_ = new BaseWingLayer(param1);
               }
               else
               {
                  _loc9_ = new ShowLayer(param1,param3,param5,param6,param7);
               }
            }
         }
         else
         {
            _loc9_ = new IconLayer(param1,param3,param5,param6);
         }
         return _loc9_;
      }
   }
}
