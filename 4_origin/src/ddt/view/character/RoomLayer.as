package ddt.view.character
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class RoomLayer extends BaseLayer
   {
       
      
      private var _clothType:int = 0;
      
      public function RoomLayer(info:ItemTemplateInfo, color:String = "", gunback:Boolean = false, hairType:int = 1, pic:String = null, clothType:int = 0)
      {
         _clothType = clothType;
         super(info,color,gunback,hairType,pic);
      }
      
      override protected function getUrl(layer:int) : String
      {
         if(_clothType == 0)
         {
            return PathManager.solveGoodsPath(_info.CategoryID,_pic,_info.NeedSex == 1,"show",_hairType,String(layer),_info.Level,_gunBack,int(_info.Property1));
         }
         return "normal.png";
      }
      
      override protected function initLoaders() : void
      {
         var url:* = null;
         var l:* = null;
         if(_info)
         {
            url = getUrl(0);
            url = url.toLocaleLowerCase();
            l = LoadResourceManager.Instance.createLoader(url,0);
            _queueLoader.addLoader(l);
         }
      }
      
      override public function reSetBitmap() : void
      {
         var i:int = 0;
         clearBitmap();
         for(i = 0; i < _queueLoader.loaders.length; )
         {
            _bitmaps.push(_queueLoader.loaders[i].content);
            if(_bitmaps[i])
            {
               _bitmaps[i].smoothing = true;
               _bitmaps[i].visible = false;
               addChild(_bitmaps[i]);
            }
            i++;
         }
      }
   }
}
