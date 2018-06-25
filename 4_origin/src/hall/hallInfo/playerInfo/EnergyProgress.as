package hall.hallInfo.playerInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class EnergyProgress extends Component
   {
       
      
      private var _pBar:Bitmap;
      
      private var _energyProgressBarFrame:Bitmap;
      
      private var _energyProgressBar:Bitmap;
      
      private var _energyProgressBarBitmapData:BitmapData;
      
      private var _energyTxt:FilterFrameText;
      
      private var _rectangle:Rectangle;
      
      public function EnergyProgress()
      {
         _rectangle = new Rectangle();
         super();
         initView();
      }
      
      private function initView() : void
      {
         _energyProgressBarFrame = ComponentFactory.Instance.creatBitmap("asset.hall.playerInfo.energyProgressFrame");
         addChild(_energyProgressBarFrame);
         _pBar = ComponentFactory.Instance.creatBitmap("asset.hall.playerInfo.energyProgressbar");
         _energyProgressBar = new Bitmap();
         _energyProgressBar.x = _pBar.x;
         _energyProgressBar.y = _pBar.y;
         addChild(_energyProgressBar);
         _energyTxt = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.energyTxt");
         addChild(_energyTxt);
      }
      
      public function showProgressBar(energyNum:int, allNum:int) : void
      {
         _energyTxt.text = energyNum + "/" + allNum;
         _rectangle.x = 0;
         _rectangle.y = 0;
         _rectangle.height = _pBar.height;
         _rectangle.width = Math.ceil(energyNum / allNum * _pBar.width);
         if(_rectangle.height <= 0)
         {
            _rectangle.height = 1;
         }
         if(_rectangle.width <= 0)
         {
            _rectangle.width = 1;
         }
         _energyProgressBarBitmapData = new BitmapData(_rectangle.width,_rectangle.height,true,0);
         _energyProgressBarBitmapData.copyPixels(_pBar.bitmapData,_rectangle,new Point(0,0));
         _energyProgressBar.bitmapData = _energyProgressBarBitmapData;
      }
      
      override public function dispose() : void
      {
         if(_energyProgressBar && _energyProgressBar.bitmapData)
         {
            _energyProgressBar.bitmapData.dispose();
         }
         _energyProgressBar = null;
         if(_energyProgressBarFrame)
         {
            ObjectUtils.disposeObject(_energyProgressBarFrame);
            _energyProgressBarFrame = null;
         }
         if(_energyTxt)
         {
            ObjectUtils.disposeObject(_energyTxt);
            _energyTxt = null;
         }
         if(_pBar)
         {
            ObjectUtils.disposeObject(_pBar);
            _pBar = null;
         }
         if(_energyProgressBarBitmapData)
         {
            ObjectUtils.disposeObject(_energyProgressBarBitmapData);
            _energyProgressBarBitmapData = null;
         }
         if(_rectangle)
         {
            _rectangle = null;
         }
         super.dispose();
      }
   }
}
