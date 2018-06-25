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
      
      public function ConsBattSceneCharacterLayer(info:ItemTemplateInfo, equipType:int, sex:Boolean, index:int, direction:int)
      {
         _equipType = equipType;
         _sex = sex;
         _index = index;
         _direction = direction;
         super(info);
      }
      
      override protected function initLoaders() : void
      {
         var i:int = 0;
         var url:* = null;
         var l:* = null;
         if(_info != null)
         {
            for(i = 0; i < _info.Property8.length; )
            {
               url = getUrl(int(_info.Property8.charAt(i)));
               if(url && url.length > 0)
               {
                  l = ConsortiaBattleManager.instance.createLoader(url);
                  _queueLoader.addLoader(l);
               }
               i++;
            }
            _defaultLayer = 0;
            _currentEdit = _queueLoader.length;
         }
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
         var equipStr:String = _equipType == 1?"face":_equipType == 2?"cloth":"hair";
         var sexStr:String = !!_sex?"M":"F";
         var directionStr:String = equipStr + (_direction == 1?"":"F");
         return ConsortiaBattleManager.instance.resourcePrUrl + equipStr + "/" + sexStr + "/" + String(_index) + "/" + directionStr + "/" + String(layer) + ".png";
      }
   }
}
