package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatFriendListPanel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.ShopController;
   
   public class ShopPresentView extends Sprite
   {
       
      
      private var _frame:BaseAlerFrame;
      
      private var _friendList:ChatFriendListPanel;
      
      private var _comBtn:BaseButton;
      
      private var _controller:ShopController;
      
      private var _bg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _textArea:TextArea;
      
      public function ShopPresentView(){super();}
      
      public function setup(param1:ShopController) : void{}
      
      private function init() : void{}
      
      private function __comBtnClickHandler(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function doSelected(param1:String, param2:Number = 0) : void{}
      
      public function show() : void{}
      
      public function dispose() : void{}
   }
}
