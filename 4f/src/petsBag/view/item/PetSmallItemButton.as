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
      
      public function PetSmallItemButton(param1:PetInfo = null){super(null);}
      
      public function setButtonStyleName(param1:String) : void{}
      
      override protected function initView() : void{}
      
      protected function onOver(param1:MouseEvent) : void{}
      
      protected function onOut(param1:MouseEvent) : void{}
      
      override public function set info(param1:PetInfo) : void{}
      
      public function set superInfo(param1:PetInfo) : void{}
      
      override public function dispose() : void{}
      
      public function get place() : int{return 0;}
      
      public function set place(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function get tipData() : Object{return null;}
      
      public function get tipDirctions() : String{return null;}
      
      public function get tipGapV() : int{return 0;}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function set tipData(param1:Object) : void{}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function set tipGapV(param1:int) : void{}
      
      public function set tipGapH(param1:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
