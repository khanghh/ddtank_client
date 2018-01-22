package consortionBattle.player
{
   import com.pickgliss.loader.BitmapLoader;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.view.character.BaseLayer;
   import flash.display.Bitmap;
   
   public class ConsBattSceneCharacterLayer extends BaseLayer
   {
       
      
      private var _equipType:int;
      
      private var _sex:Boolean;
      
      private var _index:int;
      
      private var _direction:int;
      
      public function ConsBattSceneCharacterLayer(param1:ItemTemplateInfo, param2:int, param3:Boolean, param4:int, param5:int){super(null);}
      
      override protected function initLoaders() : void{}
      
      override public function reSetBitmap() : void{}
      
      override protected function clearBitmap() : void{}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
