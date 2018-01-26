package littleGame.character
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   
   public class LittleGameCharacterLayer extends BaseLayer
   {
       
      
      private var _sex:Boolean;
      
      private var _specialType:int;
      
      public function LittleGameCharacterLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = true, param4:int = 1, param5:int = 0, param6:int = 0){super(null,null,null,null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
