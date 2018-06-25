package ddt.view.character{   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PathManager;      public class ShowLayer extends BaseLayer   {                   public function ShowLayer(info:ItemTemplateInfo, color:String = "", gunBack:Boolean = false, hairType:int = 1, pic:String = null) { super(null,null,null,null,null); }
            override protected function getUrl(layer:int) : String { return null; }
            override public function reSetBitmap() : void { }
   }}