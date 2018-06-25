package ddt.view.walkcharacter
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class WalkCharaterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sex:Boolean;
      
      private var _clothPath:String;
      
      public function WalkCharaterLayer(info:ItemTemplateInfo, color:String = "", direction:int = 1, sex:Boolean = true, clothPath:String = "")
      {
         _direction = direction;
         _sex = sex;
         _clothPath = clothPath;
         super(info,color);
      }
      
      override protected function getUrl(layer:int) : String
      {
         return PathManager.solveSceneCharacterLoaderPath(_info.CategoryID,_info.Pic,_sex,_info.NeedSex == 1,String(layer),_direction,_clothPath);
      }
   }
}
