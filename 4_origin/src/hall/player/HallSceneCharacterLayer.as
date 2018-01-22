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
      
      public function HallSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true, param5:int = 0, param6:int = 0)
      {
         _direction = param3;
         _sex = param4;
         _sceneCharacterLoaderType = param5;
         _mountsType = param6;
         super(param1,param2);
      }
      
      override protected function getUrl(param1:int) : String
      {
         var _loc3_:* = null;
         var _loc2_:String = "";
         if(param1 == 1)
         {
            if(_mountsType > 0)
            {
               if(_sceneCharacterLoaderType == 0)
               {
                  if(_mountsType == 140)
                  {
                     _loc2_ = PathManager.SITE_MAIN + "image/mounts/cloth/n/1/" + String(param1) + ".png";
                  }
                  else
                  {
                     _loc2_ = PathManager.SITE_MAIN + "image/mounts/cloth/" + (!!_sex?"M":"F") + "/1/" + String(param1) + ".png";
                  }
               }
               else if(_sceneCharacterLoaderType == 1)
               {
                  _loc2_ = PathManager.SITE_MAIN + "image/mounts/saddle/" + _mountsType + "/" + String(param1) + ".png";
               }
               else if(_sceneCharacterLoaderType == 2)
               {
                  _loc2_ = PathManager.SITE_MAIN + "image/mounts/horse/" + _mountsType + "/" + String(param1) + ".png";
               }
            }
            else
            {
               _loc3_ = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
               _loc2_ = PathManager.SITE_MAIN + "image/mounts/clothZ/" + (!!_sex?"M":"F") + "/" + _loc3_ + "/1/" + String(param1) + ".png";
            }
         }
         return _loc2_;
      }
   }
}
