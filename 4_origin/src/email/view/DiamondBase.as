package email.view
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.email.EmailInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   class DiamondBase extends Sprite implements Disposeable
   {
      
      private static var CELL_HEIGHT:int = 45;
      
      private static var CELL_WIDTH:int = 45;
       
      
      protected var _info:EmailInfo;
      
      public var diamondBg:ScaleBitmapImage;
      
      public var chargedImg:Bitmap;
      
      public var centerMC:ScaleFrameImage;
      
      public var countTxt:FilterFrameText;
      
      private var _index:int;
      
      public var _cell:EmaillBagCell;
      
      function DiamondBase()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         _cell = new EmaillBagCell();
         _cell.width = CELL_WIDTH;
         _cell.height = CELL_HEIGHT;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("email.cellPos");
         _cell.x = _loc1_.x;
         _cell.y = _loc1_.y;
         _cell.allowDrag = false;
         addChild(_cell);
         mouseChildren = false;
         mouseEnabled = false;
         diamondBg = ComponentFactory.Instance.creatComponentByStylename("email.DiamondBg");
         addChildAt(diamondBg,0);
         centerMC = ComponentFactory.Instance.creat("email.centerMC");
         addChild(centerMC);
         centerMC.setFrame(1);
         centerMC.visible = false;
         chargedImg = ComponentFactory.Instance.creatBitmap("asset.email.chargedImg");
         addChild(chargedImg);
         chargedImg.visible = false;
         countTxt = ComponentFactory.Instance.creat("email.diamondTxt");
         addChild(countTxt);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index == param1)
         {
            return;
         }
         _index = param1;
      }
      
      public function get info() : EmailInfo
      {
         return _info;
      }
      
      public function set info(param1:EmailInfo) : void
      {
         _info = param1;
         if(_info)
         {
            update();
         }
         else
         {
            mouseEnabled = false;
            mouseChildren = false;
            centerMC.visible = false;
            chargedImg.visible = false;
            countTxt.text = "";
            _cell.visible = false;
         }
      }
      
      public function forSendedCell() : void
      {
         centerMC.setFrame(5);
         diamondBg.visible = false;
         chargedImg.visible = false;
         countTxt.visible = false;
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         _cell.dragDrop(param1);
      }
      
      protected function addEvent() : void
      {
      }
      
      protected function removeEvent() : void
      {
      }
      
      protected function update() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(diamondBg)
         {
            ObjectUtils.disposeObject(diamondBg);
         }
         diamondBg = null;
         if(chargedImg)
         {
            ObjectUtils.disposeObject(chargedImg);
         }
         chargedImg = null;
         if(centerMC)
         {
            ObjectUtils.disposeObject(centerMC);
         }
         centerMC = null;
         if(countTxt)
         {
            ObjectUtils.disposeObject(countTxt);
         }
         countTxt = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         _info = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
