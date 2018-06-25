package consortionBattle.player{   import com.pickgliss.loader.BitmapLoader;   import consortionBattle.ConsortiaBattleManager;   import ddt.data.goods.ItemTemplateInfo;   import ddt.view.character.BaseLayer;   import flash.display.Bitmap;      public class ConsBattSceneCharacterLayer extends BaseLayer   {                   private var _equipType:int;            private var _sex:Boolean;            private var _index:int;            private var _direction:int;            public function ConsBattSceneCharacterLayer(info:ItemTemplateInfo, equipType:int, sex:Boolean, index:int, direction:int) { super(null); }
            override protected function initLoaders() : void { }
            override public function reSetBitmap() : void { }
            override protected function clearBitmap() : void { }
            override protected function getUrl(layer:int) : String { return null; }
   }}