package catchInsect.player
{
   import catchInsect.CatchInsectManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.character.BaseLayer;
   
   public class CatchInsectSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sex:Boolean;
      
      public function CatchInsectSceneCharacterLayer(info:ItemTemplateInfo, color:String = "", direction:int = 1, sex:Boolean = true)
      {
         _direction = direction;
         _sex = sex;
         super(info,color);
      }
      
      override protected function getUrl(layer:int) : String
      {
         var type:String = _direction == 1?"clothF":_direction == 2?"cloth":"clothF";
         return CatchInsectManager.instance.getCatchInsectResource() + "/cloth/" + (!!_sex?"M":"F") + "/" + type + "/" + String(layer) + ".png";
      }
   }
}
