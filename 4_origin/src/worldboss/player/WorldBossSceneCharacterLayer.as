package worldboss.player
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class WorldBossSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sex:Boolean;
      
      public function WorldBossSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true)
      {
         _direction = param3;
         _sex = param4;
         super(param1,param2);
      }
      
      override protected function getUrl(param1:int) : String
      {
         var _loc2_:String = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
         return PathManager.SITE_MAIN + "image/mounts/clothZ/" + (!!_sex?"M":"F") + "/" + _loc2_ + "/1/" + String(param1) + ".png";
      }
   }
}
