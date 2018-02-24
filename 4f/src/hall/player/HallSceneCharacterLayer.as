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
      
      public function HallSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true, param5:int = 0, param6:int = 0){super(null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
