package littleGame.character
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class LittleGameCharacterLayer extends BaseLayer
   {
       
      
      private var _sex:Boolean;
      
      private var _specialType:int;
      
      public function LittleGameCharacterLayer(info:ItemTemplateInfo, color:String = "", sex:Boolean = true, littleGameId:int = 1, specialType:int = 0, picId:int = 0)
      {
         _sex = sex;
         _specialType = specialType;
         super(info,color,false,1,String(picId));
      }
      
      override protected function getUrl(layer:int) : String
      {
         if(_specialType > 0)
         {
            return PathManager.solveLitteGameCharacterPath(_specialType,_sex,1,layer,_pic);
         }
         if(_info.CategoryID != 5)
         {
            return PathManager.solveSceneCharacterLoaderPath(_info.CategoryID,_info.Pic,_sex,_info.NeedSex == 1,String(layer),1,"");
         }
         return PathManager.solveLitteGameCharacterPath(_info.CategoryID,_sex,1,layer,_pic);
      }
   }
}
