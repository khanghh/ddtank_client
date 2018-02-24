package ddt.view.character
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class ShowLayer extends BaseLayer
   {
       
      
      public function ShowLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = false, param4:int = 1, param5:String = null){super(null,null,null,null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
      
      override public function reSetBitmap() : void{}
   }
}
