package ddt.view.sceneCharacter
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class SceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sceneCharacterLoaderPath:String;
      
      private var _sex:Boolean;
      
      public function SceneCharacterLayer(info:ItemTemplateInfo, color:String = "", direction:int = 1, sex:Boolean = true, sceneCharacterLoaderPath:String = "")
      {
         _direction = direction;
         _sceneCharacterLoaderPath = sceneCharacterLoaderPath;
         _sex = sex;
         super(info,color);
      }
      
      override protected function getUrl(layer:int) : String
      {
         return PathManager.solveSceneCharacterLoaderPath(_info.CategoryID,_info.Pic,_sex,_info.NeedSex == 1,String(layer),_direction,_sceneCharacterLoaderPath);
      }
   }
}
