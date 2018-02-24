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
       
      
      public function LayerFactory(){super();}
      
      public static function get instance() : ILayerFactory{return null;}
      
      public function createLayer(param1:ItemTemplateInfo, param2:Boolean, param3:String = "", param4:String = "show", param5:Boolean = false, param6:int = 1, param7:String = null, param8:String = "") : ILayer{return null;}
   }
}
