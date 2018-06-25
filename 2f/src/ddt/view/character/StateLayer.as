package ddt.view.character{   import com.pickgliss.loader.BitmapLoader;   import com.pickgliss.loader.LoadResourceManager;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.PathManager;   import flash.events.Event;      public class StateLayer extends BaseLayer   {                   private var _stateType:int;            private var _sex:Boolean;            public function StateLayer(info:ItemTemplateInfo, sex:Boolean, color:String, type:int = 1) { super(null,null); }
            override protected function getUrl(layer:int) : String { return null; }
            override protected function initLoaders() : void { }
            override protected function __loadComplete(event:Event) : void { }
   }}