package starling.scene.hall.player
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class HallSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sceneCharacterLoaderType:int;
      
      private var _sex:Boolean;
      
      public function HallSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true, param5:int = 0)
      {
         _direction = param3;
         _sex = param4;
         _sceneCharacterLoaderType = param5;
         super(param1,param2);
      }
      
      override protected function getUrl(param1:int) : String
      {
         var _loc3_:String = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
         var _loc2_:String = "";
         if(param1 == 1)
         {
            if(_sceneCharacterLoaderType == 0)
            {
               _loc2_ = PathManager.SITE_MAIN + "image/mounts/clothZ/" + (!!_sex?"M":"F") + "/" + _loc3_ + "/1/" + String(param1) + ".png";
            }
            else if(_sceneCharacterLoaderType == 1)
            {
               _loc2_ = PathManager.SITE_MAIN + "image/mounts/cloth/" + (!!_sex?"M":"F") + "/1/2.png";
            }
            else if(_sceneCharacterLoaderType == 2)
            {
               _loc2_ = PathManager.SITE_MAIN + "image/mounts/cloth/n/1/1.png";
            }
         }
         return _loc2_;
      }
   }
}
