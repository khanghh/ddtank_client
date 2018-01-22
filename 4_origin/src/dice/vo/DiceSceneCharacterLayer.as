package dice.vo
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class DiceSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sex:Boolean;
      
      public function DiceSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true)
      {
         _direction = param3;
         _sex = param4;
         super(param1,param2);
      }
      
      override protected function getUrl(param1:int) : String
      {
         var _loc2_:String = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
         return PathManager.getDiceResource() + "cloth/" + (!!_sex?"M":"F") + "/" + _loc2_ + "/" + String(param1) + ".png";
      }
   }
}
