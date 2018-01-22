package christmas.player
{
   import christmas.loader.LoaderChristmasUIModule;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.character.BaseLayer;
   
   public class ChristmasSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sex:Boolean;
      
      public function ChristmasSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true)
      {
         _direction = param3;
         _sex = param4;
         super(param1,param2);
      }
      
      override protected function getUrl(param1:int) : String
      {
         var _loc2_:String = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
         return LoaderChristmasUIModule.Instance.getChristmasResource() + "/cloth/" + (!!_sex?"M":"F") + "/" + _loc2_ + "/" + String(param1) + ".png";
      }
   }
}
