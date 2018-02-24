package campbattle.view.roleView
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.view.character.BaseLayer;
   import flash.display.Bitmap;
   
   public class CampBattleCharacterLayer extends BaseLayer
   {
       
      
      private var _equipType:int;
      
      private var _sex:Boolean;
      
      private var _index:int;
      
      private var _direction:int;
      
      private var _baseURL:String;
      
      private var _mountType:int;
      
      public function CampBattleCharacterLayer(param1:ItemTemplateInfo, param2:int, param3:Boolean, param4:int, param5:int, param6:String, param7:int){super(null);}
      
      override public function reSetBitmap() : void{}
      
      override protected function clearBitmap() : void{}
      
      override protected function getUrl(param1:int) : String{return null;}
   }
}
