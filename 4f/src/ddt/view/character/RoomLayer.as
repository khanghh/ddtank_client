package ddt.view.character{   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.LoadResourceManager;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PathManager;      public class RoomLayer extends BaseLayer   {                   private var _clothType:int = 0;            public function RoomLayer(info:ItemTemplateInfo, color:String = "", gunback:Boolean = false, hairType:int = 1, pic:String = null, clothType:int = 0) { super(null,null,null,null,null); }
            override protected function getUrl(layer:int) : String { return null; }
            override protected function initLoaders() : void { }
            override public function reSetBitmap() : void { }
   }}