package ddt.view.character{   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.LoadResourceManager;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PathManager;      public class SpecialEffectsLayer extends BaseLayer   {                   private var _specialType:int;            public function SpecialEffectsLayer(layer:int = 1) { super(null); }
            override protected function getUrl(layer:int) : String { return null; }
            override protected function initLoaders() : void { }
   }}