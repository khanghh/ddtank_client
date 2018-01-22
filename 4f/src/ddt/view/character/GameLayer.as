package ddt.view.character
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class GameLayer extends BaseLayer
   {
       
      
      private var _state:String = "";
      
      public function GameLayer(param1:ItemTemplateInfo, param2:String, param3:Boolean = false, param4:int = 1, param5:String = null, param6:String = ""){super(null,null,null,null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
