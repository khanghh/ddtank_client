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
      
      public function HallSceneCharacterLayer(info:ItemTemplateInfo, color:String = "", direction:int = 1, sex:Boolean = true, sceneCharacterLoaderType:int = 0)
      {
         _direction = direction;
         _sex = sex;
         _sceneCharacterLoaderType = sceneCharacterLoaderType;
         super(info,color);
      }
      
      override protected function getUrl(layer:int) : String
      {
         var type:String = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
         var path:String = "";
         if(layer == 1)
         {
            if(_sceneCharacterLoaderType == 0)
            {
               path = PathManager.SITE_MAIN + "image/mounts/clothZ/" + (!!_sex?"M":"F") + "/" + type + "/1/" + String(layer) + ".png";
            }
            else if(_sceneCharacterLoaderType == 1)
            {
               path = PathManager.SITE_MAIN + "image/mounts/cloth/" + (!!_sex?"M":"F") + "/1/2.png";
            }
            else if(_sceneCharacterLoaderType == 2)
            {
               path = PathManager.SITE_MAIN + "image/mounts/cloth/n/1/1.png";
            }
         }
         return path;
      }
   }
}
