package ddt.view.character
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class RoomLayer extends BaseLayer
   {
       
      
      private var _clothType:int = 0;
      
      public function RoomLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = false, param4:int = 1, param5:String = null, param6:int = 0){super(null,null,null,null,null);}
      
      override protected function getUrl(param1:int) : String{return null;}
      
      override protected function initLoaders() : void{}
      
      override public function reSetBitmap() : void{}
   }
}
