package farm.player
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class FarmSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sceneCharacterLoaderPath:String;
      
      private var _sex:Boolean;
      
      public function FarmSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true, param5:String = ""){super(null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
