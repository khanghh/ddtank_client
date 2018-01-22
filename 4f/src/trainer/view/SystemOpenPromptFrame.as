package trainer.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.layout.StageResizeUtils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class SystemOpenPromptFrame extends Frame
   {
       
      
      private var _iconTxtBg:Bitmap;
      
      private var _btnBg:Bitmap;
      
      private var _tipTxt:FilterFrameText;
      
      private var _btn:SimpleBitmapButton;
      
      private var _icon:Bitmap;
      
      private var _equipCell:BagCell;
      
      private var _toPlace:int;
      
      private var _callback:Function;
      
      private var _type:int;
      
      private var _image:ScaleFrameImage;
      
      public function SystemOpenPromptFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function btnClickHandler(param1:MouseEvent) : void{}
      
      public function show(param1:int, param2:Function, param3:InventoryItemInfo = null, param4:int = 0) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
