package room.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RoomDupSimpleTipFram extends BaseAlerFrame
   {
       
      
      private var _view:Sprite;
      
      private var _bg:Bitmap;
      
      private var _dupTip:FilterFrameText;
      
      private var _newEnemy:FilterFrameText;
      
      private var _boguBoss:FilterFrameText;
      
      private var _moreGoods:FilterFrameText;
      
      private var _goodsI:FilterFrameText;
      
      private var _goodsII:FilterFrameText;
      
      private var _goodsIII:FilterFrameText;
      
      private var _goodsIV:FilterFrameText;
      
      public function RoomDupSimpleTipFram(){super();}
      
      private function initView() : void{}
      
      private function initEvents() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      public function show() : void{}
      
      override public function dispose() : void{}
   }
}
