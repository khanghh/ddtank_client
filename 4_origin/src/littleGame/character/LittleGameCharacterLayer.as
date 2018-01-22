package littleGame.character
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class LittleGameCharacterLayer extends BaseLayer
   {
       
      
      private var _sex:Boolean;
      
      private var _specialType:int;
      
      public function LittleGameCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = true, param4:int = 1, param5:int = 0, param6:int = 0)
      {
         _sex = param3;
         _specialType = param5;
         super(param1,param2,false,1,String(param6));
      }
      
      override protected function getUrl(param1:int) : String
      {
         if(_specialType > 0)
         {
            return PathManager.solveLitteGameCharacterPath(_specialType,_sex,1,param1,_pic);
         }
         if(_info.CategoryID != 5)
         {
            return PathManager.solveSceneCharacterLoaderPath(_info.CategoryID,_info.Pic,_sex,_info.NeedSex == 1,String(param1),1,"");
         }
         return PathManager.solveLitteGameCharacterPath(_info.CategoryID,_sex,1,param1,_pic);
      }
   }
}
