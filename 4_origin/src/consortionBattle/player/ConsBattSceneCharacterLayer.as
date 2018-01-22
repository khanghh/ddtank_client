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
      
      public function ConsBattSceneCharacterLayer(param1:ItemTemplateInfo, param2:int, param3:Boolean, param4:int, param5:int)
      {
         _equipType = param2;
         _sex = param3;
         _index = param4;
         _direction = param5;
         super(param1);
      }
      
      override protected function initLoaders() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_info != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _info.Property8.length)
            {
               _loc2_ = getUrl(int(_info.Property8.charAt(_loc3_)));
               if(_loc2_ && _loc2_.length > 0)
               {
                  _loc1_ = ConsortiaBattleManager.instance.createLoader(_loc2_);
                  _queueLoader.addLoader(_loc1_);
               }
               _loc3_++;
            }
            _defaultLayer = 0;
            _currentEdit = _queueLoader.length;
         }
      }
      
      override public function reSetBitmap() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         clearBitmap();
         _loc2_ = 0;
         while(_loc2_ < _queueLoader.loaders.length)
         {
            if(_queueLoader.loaders[_loc2_].content)
            {
               _loc1_ = new Bitmap((_queueLoader.loaders[_loc2_].content as Bitmap).bitmapData);
            }
            _bitmaps.push(_loc1_);
            if(_bitmaps[_loc2_])
            {
               _bitmaps[_loc2_].smoothing = true;
               _bitmaps[_loc2_].visible = false;
               addChild(_bitmaps[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      override protected function clearBitmap() : void
      {
         while(this && this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         _bitmaps = new Vector.<Bitmap>();
      }
      
      override protected function getUrl(param1:int) : String
      {
         var _loc2_:String = _equipType == 1?"face":_equipType == 2?"cloth":"hair";
         var _loc3_:String = !!_sex?"M":"F";
         var _loc4_:String = _loc2_ + (_direction == 1?"":"F");
         return ConsortiaBattleManager.instance.resourcePrUrl + _loc2_ + "/" + _loc3_ + "/" + String(_index) + "/" + _loc4_ + "/" + String(param1) + ".png";
      }
   }
}
