package ddt.view.caddyII
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.items.AwardListItem;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class CaddyAwardListFrame extends Frame implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _btn:TextButton;
      
      private var _list:VBox;
      
      private var _listArray:Vector.<AwardListItem>;
      
      private var _titleBitmap:Bitmap;
      
      private var _bg:Bitmap;
      
      private var _Vline:MutipleImage;
      
      private var _descripTxt1:FilterFrameText;
      
      private var _descripTxt2:FilterFrameText;
      
      private var _descripTxt3:FilterFrameText;
      
      private var sortTitleTxt:FilterFrameText;
      
      private var NametitleTxt:FilterFrameText;
      
      private var NumbertitleTxt:FilterFrameText;
      
      private var _dataList:Object;
      
      public function CaddyAwardListFrame(){super();}
      
      private function initView() : void{}
      
      private function getBadLuckHandler(param1:CaddyEvent) : void{}
      
      private function updateData() : void{}
      
      private function clickHander(param1:MouseEvent) : void{}
      
      private function upDataUserName() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
