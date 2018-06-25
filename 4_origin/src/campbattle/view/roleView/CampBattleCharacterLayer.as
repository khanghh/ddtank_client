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
      
      public function CampBattleCharacterLayer(info:ItemTemplateInfo, equipType:int, sex:Boolean, index:int, direction:int, baseURl:String, mountType:int)
      {
         _equipType = equipType;
         _sex = sex;
         _index = index;
         _direction = direction;
         _baseURL = baseURl;
         _mountType = mountType;
         super(info);
      }
      
      override public function reSetBitmap() : void
      {
         var i:int = 0;
         var tmpBitmap:* = null;
         clearBitmap();
         for(i = 0; i < _queueLoader.loaders.length; )
         {
            if(_queueLoader.loaders[i].content)
            {
               tmpBitmap = new Bitmap((_queueLoader.loaders[i].content as Bitmap).bitmapData);
            }
            _bitmaps.push(tmpBitmap);
            if(_bitmaps[i])
            {
               _bitmaps[i].smoothing = true;
               _bitmaps[i].visible = false;
               addChild(_bitmaps[i]);
            }
            i++;
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
      
      override protected function getUrl(layer:int) : String
      {
         var equipStr:* = null;
         var sexStr:* = null;
         var directionStr:* = null;
         var path:String = "";
         sexStr = !!_sex?"m":"f";
         if(_mountType == 0)
         {
            equipStr = _equipType == 0?"face":_equipType == 2?"clothz":"hair";
            directionStr = (_equipType == 2?"cloth":equipStr) + (_direction == 1?"":"f");
            path = _baseURL + equipStr + "/" + sexStr + "/" + String(_index) + "/" + directionStr + "/" + String(layer) + ".png";
         }
         else
         {
            equipStr = _equipType == 0?"face":_equipType == 2?"cloth":"hair";
            directionStr = (_equipType == 2?"cloth":equipStr) + (_direction == 1?"":"f");
            if(_equipType == 0)
            {
               path = _baseURL + "face/" + sexStr + "/" + String(_index) + "/" + directionStr + "/" + String(layer) + ".png";
            }
            else if(_equipType == 1)
            {
               path = _baseURL + "hair/" + sexStr + "/" + String(_index) + "/" + directionStr + "/" + String(layer) + ".png";
            }
            else if(_equipType == 2)
            {
               if(_mountType == 140)
               {
                  if(String(layer) == "1")
                  {
                     path = PathManager.SITE_MAIN + "image/mounts/cloth/n/1/" + String(layer) + ".png";
                  }
               }
               else
               {
                  path = _baseURL + "cloth/" + sexStr + "/" + String(_index) + "/" + String(layer) + ".png";
               }
            }
            else if(_equipType == 3)
            {
               path = PathManager.SITE_MAIN + "image/mounts/saddle/" + _mountType + "/" + String(layer) + ".png";
            }
            else if(_equipType == 4)
            {
               if(_mountType != 140 || String(layer) == "1")
               {
                  path = PathManager.SITE_MAIN + "image/mounts/horse/" + _mountType + "/" + String(layer) + ".png";
               }
            }
         }
         return path;
      }
   }
}
