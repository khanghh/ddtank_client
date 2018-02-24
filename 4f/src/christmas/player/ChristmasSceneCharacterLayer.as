package christmas.player
{
   import christmas.loader.LoaderChristmasUIModule;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.character.BaseLayer;
   
   public class ChristmasSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _direction:int;
      
      private var _sex:Boolean;
      
      public function ChristmasSceneCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:int = 1, param4:Boolean = true){super(null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
