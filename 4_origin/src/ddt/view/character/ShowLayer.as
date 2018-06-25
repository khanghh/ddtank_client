package ddt.view.character
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   
   public class ShowLayer extends BaseLayer
   {
       
      
      public function ShowLayer(info:ItemTemplateInfo, color:String = "", gunBack:Boolean = false, hairType:int = 1, pic:String = null)
      {
         super(info,color,gunBack,hairType,pic);
      }
      
      override protected function getUrl(layer:int) : String
      {
         return PathManager.solveGoodsPath(_info.CategoryID,_pic,_info.NeedSex == 1,"show",_hairType,String(layer),_info.Level,_gunBack,int(_info.Property1));
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
