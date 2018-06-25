package hall.player
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class HallSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sceneCharacterLoaderType:int;
      
      private var _sex:Boolean;
      
      private var _mountsType:int;
      
      public function HallSceneCharacterLayer(info:ItemTemplateInfo, color:String = "", direction:int = 1, sex:Boolean = true, sceneCharacterLoaderType:int = 0, mountsType:int = 0)
      {
         _direction = direction;
         _sex = sex;
         _sceneCharacterLoaderType = sceneCharacterLoaderType;
         _mountsType = mountsType;
         super(info,color);
      }
      
      override protected function getUrl(layer:int) : String
      {
         var type:* = null;
         var path:String = "";
         if(layer == 1)
         {
            if(_mountsType > 0)
            {
               if(_sceneCharacterLoaderType == 0)
               {
                  if(_mountsType == 140)
                  {
                     path = PathManager.SITE_MAIN + "image/mounts/cloth/n/1/" + String(layer) + ".png";
                  }
                  else
                  {
                     path = PathManager.SITE_MAIN + "image/mounts/cloth/" + (!!_sex?"M":"F") + "/1/" + String(layer) + ".png";
                  }
               }
               else if(_sceneCharacterLoaderType == 1)
               {
                  path = PathManager.SITE_MAIN + "image/mounts/saddle/" + _mountsType + "/" + String(layer) + ".png";
               }
               else if(_sceneCharacterLoaderType == 2)
               {
                  path = PathManager.SITE_MAIN + "image/mounts/horse/" + _mountsType + "/" + String(layer) + ".png";
               }
            }
            else
            {
               type = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
               path = PathManager.SITE_MAIN + "image/mounts/clothZ/" + (!!_sex?"M":"F") + "/" + type + "/1/" + String(layer) + ".png";
            }
         }
         return path;
      }
   }
}
