package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import pet.data.PetInfo;
   
   public class PetSmallItemButton extends PetSmallItem implements ITipedDisplay
   {
       
      
      private var _place:int;
      
      private var _bmpBtn:Bitmap;
      
      private var _btnStyleName:String;
      
      protected var _star:StarBar;
      
      private var _tipStyle:String;
      
      private var _tipData:Object;
      
      private var _tipDirctions:String;
      
      private var _tipGapV:int;
      
      private var _tipGapH:int;
      
      public function PetSmallItemButton(param1:PetInfo = null)
      {
         super(param1);
         this.mouseChildren = false;
         _star = new StarBar();
         _star.y = 62;
         addChild(_star);
         tipStyle = "petsBag.PetBenchBagTip";
         tipDirctions = "2,7,5,1,6,4";
      }
      
      public function setButtonStyleName(param1:String) : void
      {
         if(param1 == null)
         {
            ObjectUtils.disposeObject(_bmpBtn);
            _bmpBtn = null;
            _btnStyleName = null;
            info = null;
            return;
         }
         if(_btnStyleName == param1)
         {
            return;
         }
         _btnStyleName = param1;
         if(_bmpBtn == null)
         {
            _bmpBtn = new Bitmap();
         }
         _bmpBtn.bitmapData = ComponentFactory.Instance.creatBitmapData(_btnStyleName);
         _bmpBtn.x = 64 - _bmpBtn.width >> 1;
         _bmpBtn.y = 59 - _bmpBtn.height >> 1;
         addChildAt(_bmpBtn,2);
      }
      
      override protected function initView() : void
      {
         super.initView();
         addEventListener("rollOut",onOut);
         addEventListener("rollOver",onOver);
      }
      
      protected function onOver(param1:MouseEvent) : void
      {
      }
      
      protected function onOut(param1:MouseEvent) : void
      {
      }
      
      override public function set info(param1:PetInfo) : void
      {
         if(param1 != null)
         {
            setButtonStyleName(null);
         }
         .super.info = param1;
         if(info)
         {
            _star.starNum(info.StarLevel,"assets.petsBag.starSmall");
            _star.x = (this.width - _star.width) / 2 - 5;
            tipData = info;
            ShowTipManager.Instance.addTip(this);
         }
         else
         {
            _star.starNum(0,"assets.petsBag.starSmall");
            tipData = null;
            ShowTipManager.Instance.removeTip(this);
         }
      }
      
      public function set superInfo(param1:PetInfo) : void
      {
         .super.info = param1;
      }
      
      override public function dispose() : void
      {
         if(_shiner != null)
         {
            _shiner.removeEventListener("rollOver",onOver);
            _shiner.removeEventListener("rollOut",onOut);
         }
         if(_bmpBtn != null)
         {
            ObjectUtils.disposeObject(_bmpBtn);
            _bmpBtn = null;
         }
         ObjectUtils.disposeObject(_star);
         _star = null;
         ShowTipManager.Instance.removeTip(this);
         super.dispose();
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function set place(param1:int) : void
      {
         _place = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipStyle(param1:String) : void
      {
         if(_tipStyle == param1)
         {
            return;
         }
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(_tipData == param1)
         {
            return;
         }
         _tipData = param1;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         if(_tipDirctions == param1)
         {
            return;
         }
         _tipDirctions = param1;
      }
      
      public function set tipGapV(param1:int) : void
      {
         if(_tipGapV == param1)
         {
            return;
         }
         _tipGapV = param1;
      }
      
      public function set tipGapH(param1:int) : void
      {
         if(_tipGapH == param1)
         {
            return;
         }
         _tipGapH = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
