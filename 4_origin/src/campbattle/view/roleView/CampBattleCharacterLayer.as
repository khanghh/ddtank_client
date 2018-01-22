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
      
      public function CampBattleCharacterLayer(param1:ItemTemplateInfo, param2:int, param3:Boolean, param4:int, param5:int, param6:String, param7:int)
      {
         _equipType = param2;
         _sex = param3;
         _index = param4;
         _direction = param5;
         _baseURL = param6;
         _mountType = param7;
         super(param1);
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
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:String = "";
         _loc4_ = !!_sex?"m":"f";
         if(_mountType == 0)
         {
            _loc2_ = _equipType == 0?"face":_equipType == 2?"clothz":"hair";
            _loc5_ = (_equipType == 2?"cloth":_loc2_) + (_direction == 1?"":"f");
            _loc3_ = _baseURL + _loc2_ + "/" + _loc4_ + "/" + String(_index) + "/" + _loc5_ + "/" + String(param1) + ".png";
         }
         else
         {
            _loc2_ = _equipType == 0?"face":_equipType == 2?"cloth":"hair";
            _loc5_ = (_equipType == 2?"cloth":_loc2_) + (_direction == 1?"":"f");
            if(_equipType == 0)
            {
               _loc3_ = _baseURL + "face/" + _loc4_ + "/" + String(_index) + "/" + _loc5_ + "/" + String(param1) + ".png";
            }
            else if(_equipType == 1)
            {
               _loc3_ = _baseURL + "hair/" + _loc4_ + "/" + String(_index) + "/" + _loc5_ + "/" + String(param1) + ".png";
            }
            else if(_equipType == 2)
            {
               if(_mountType == 140)
               {
                  if(String(param1) == "1")
                  {
                     _loc3_ = PathManager.SITE_MAIN + "image/mounts/cloth/n/1/" + String(param1) + ".png";
                  }
               }
               else
               {
                  _loc3_ = _baseURL + "cloth/" + _loc4_ + "/" + String(_index) + "/" + String(param1) + ".png";
               }
            }
            else if(_equipType == 3)
            {
               _loc3_ = PathManager.SITE_MAIN + "image/mounts/saddle/" + _mountType + "/" + String(param1) + ".png";
            }
            else if(_equipType == 4)
            {
               if(_mountType != 140 || String(param1) == "1")
               {
                  _loc3_ = PathManager.SITE_MAIN + "image/mounts/horse/" + _mountType + "/" + String(param1) + ".png";
               }
            }
         }
         return _loc3_;
      }
   }
}
