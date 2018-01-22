package catchInsect.player
{
   import catchInsect.CatchInsectManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.character.BaseLayer;
   
   public class CatchInsectSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sex:Boolean;
      
      public function CatchInsectSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true){super(null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
